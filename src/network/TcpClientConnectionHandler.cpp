#include "TcpClientConnectionHandler.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QRandomGenerator>

Q_LOGGING_CATEGORY(lcTcpClient, "tcp.client")

// ── Helpers ────────────────────────────────────

static QJsonObject section(const QJsonObject &root, const char *key) {
    return root.value(key).toObject();
}

static QString strVal(const QJsonObject &obj, const char *key, const QString &def) {
    return obj.value(key).toString(def);
}

static int intVal(const QJsonObject &obj, const char *key, int def) {
    return obj.value(key).toInt(def);
}

static bool boolVal(const QJsonObject &obj, const char *key, bool def) {
    return obj.value(key).toBool(def);
}

// ── Config Loader ──────────────────────────────

ClientConfig TcpClientConnectionHandler::loadConfig(const QString &path)
{
    ClientConfig c;
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly)) {
        qCWarning(lcTcpClient) << "Cannot open" << path << "- defaults";
        return c;
    }

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(f.readAll(), &err);
    f.close();

    if (err.error != QJsonParseError::NoError) {
        qCWarning(lcTcpClient) << "JSON error in" << path << ":" << err.errorString();
        return c;
    }

    const QJsonObject root = doc.object();

//    if (auto s = section(root, "server"); !s.isEmpty()) {
    QJsonObject s = section(root, "server");
    if (!s.isEmpty()) {
        c.address = strVal(s, "address", c.address);
        c.port = static_cast<quint16>(intVal(s, "port", c.port));
    }
//    if (auto hb = section(root, "heartbeat"); !hb.isEmpty()) {
    QJsonObject hb = section(root, "heartbeat");
    if (!hb.isEmpty()) {
        c.heartbeatMs = intVal(hb, "interval_ms", c.heartbeatMs);
        c.heartbeatTimeoutMs = intVal(hb, "timeout_ms", c.heartbeatTimeoutMs);
    }
//    if (auto rc = section(root, "reconnect"); !rc.isEmpty()) {
    QJsonObject rc = section(root, "reconnect");
    if (!rc.isEmpty()) {
        c.reconnectBaseMs = intVal(rc, "base_ms", c.reconnectBaseMs);
        c.reconnectMaxMs  = intVal(rc, "max_ms", c.reconnectMaxMs);
        c.autoConnect     = boolVal(rc, "auto_connect", c.autoConnect);
    }
    c.logPrefix = strVal(root, "log_prefix", c.logPrefix);

    qCInfo(lcTcpClient) << c.logPrefix << "Config loaded:" << path;
    return c;
}

// ── Constructor / Destructor ───────────────────

TcpClientConnectionHandler::TcpClientConnectionHandler(const ClientConfig &cfg, QObject *parent)
    : QObject(parent)
    , m_socket(new QTcpSocket(this))
    , m_heartbeat(new QTimer(this))
    , m_watchdog(new QTimer(this))
    , m_reconnectTimer(new QTimer(this))
    , m_cfg(cfg)
{
    m_socket->setSocketOption(QAbstractSocket::KeepAliveOption, 1);
    connect(m_socket, &QTcpSocket::connected,    this, &TcpClientConnectionHandler::onConnected);
    connect(m_socket, &QTcpSocket::disconnected, this, &TcpClientConnectionHandler::onDisconnected);
    connect(m_socket, QOverload<QAbstractSocket::SocketError>::of(&QTcpSocket::errorOccurred),
            this, &TcpClientConnectionHandler::onError);
    connect(m_socket, &QTcpSocket::readyRead,    this, &TcpClientConnectionHandler::onReadyRead);

    m_heartbeat->setInterval(m_cfg.heartbeatMs);
    connect(m_heartbeat, &QTimer::timeout, this, &TcpClientConnectionHandler::sendHeartbeat);

    m_watchdog->setSingleShot(true);
    m_watchdog->setInterval(m_cfg.heartbeatTimeoutMs);
    connect(m_watchdog, &QTimer::timeout, this, &TcpClientConnectionHandler::onHeartbeatTimeout);

    m_reconnectTimer->setSingleShot(true);
    connect(m_reconnectTimer, &QTimer::timeout, this, &TcpClientConnectionHandler::tryReconnect);

    qCInfo(lcTcpClient) << m_cfg.logPrefix << "Init |" << m_cfg.address << ":" << m_cfg.port
                         << "| hb:" << m_cfg.heartbeatMs << "/" << m_cfg.heartbeatTimeoutMs
                         << "| rc:" << m_cfg.reconnectBaseMs << "-" << m_cfg.reconnectMaxMs;

    if (m_cfg.autoConnect) connectToServer();
}

TcpClientConnectionHandler::~TcpClientConnectionHandler()
{
    m_graceful = true;
    m_heartbeat->stop();
    m_watchdog->stop();
    m_reconnectTimer->stop();
    if (m_socket->state() == QTcpSocket::ConnectedState) {
        m_socket->disconnectFromHost();
        m_socket->waitForDisconnected(500);
    }
}

// ── Public Slots ───────────────────────────────

void TcpClientConnectionHandler::connectToServer()
{
    if (m_socket->state() != QTcpSocket::UnconnectedState) return;

    m_graceful = false;
    m_attempt = 0;
    qCInfo(lcTcpClient) << m_cfg.logPrefix << "Connecting...";
    emit stateChanged("Connecting");
    m_socket->connectToHost(m_cfg.address, m_cfg.port);
}

void TcpClientConnectionHandler::disconnectFromServer()
{
    m_graceful = true;
    stopReconnect();
    m_heartbeat->stop();
    m_watchdog->stop();
    if (m_socket->state() == QTcpSocket::ConnectedState) {
        qCInfo(lcTcpClient) << m_cfg.logPrefix << "Disconnecting";
        m_socket->disconnectFromHost();
    }
}

// ── Slots ──────────────────────────────────────

void TcpClientConnectionHandler::onConnected()
{
    stopReconnect();
    qCInfo(lcTcpClient) << m_cfg.logPrefix << "[CONNECTED]" << m_cfg.address << ":" << m_cfg.port;
    emit connectionStatusChanged(true);
    emit stateChanged("Connected");
    m_heartbeat->start();
    resetWatchdog();
}

void TcpClientConnectionHandler::onDisconnected()
{
    m_heartbeat->stop();
    m_watchdog->stop();

    if (m_graceful) {
        qCInfo(lcTcpClient) << m_cfg.logPrefix << "[DISCONNECTED]";
        emit stateChanged("Disconnected");
    } else {
        qCWarning(lcTcpClient) << m_cfg.logPrefix << "[DISCONNECTED] Reconnecting...";
        emit stateChanged("Reconnecting");
        startReconnect();
    }
    emit connectionStatusChanged(false);
}

void TcpClientConnectionHandler::onError(QAbstractSocket::SocketError)
{
    if (m_graceful || m_reconnectTimer->isActive()) return;
    qCWarning(lcTcpClient) << m_cfg.logPrefix << "[ERROR]" << m_socket->errorString();
    emit stateChanged("Error");
    startReconnect();
}

void TcpClientConnectionHandler::onReadyRead()
{
    QByteArray data = m_socket->readAll();
    if (data.contains("PONG")) {
        resetWatchdog();
        qCDebug(lcTcpClient) << m_cfg.logPrefix << "PONG";
    } else {
        emit dataReceived(data);
    }
}

// ── Heartbeat ──────────────────────────────────

void TcpClientConnectionHandler::sendHeartbeat()
{
    if (isConnected()) {
        m_socket->write("PING", 4);
        qCDebug(lcTcpClient) << m_cfg.logPrefix << "PING";
    }
}

void TcpClientConnectionHandler::onHeartbeatTimeout()
{
    qCWarning(lcTcpClient) << m_cfg.logPrefix << "[TIMEOUT]" << m_cfg.heartbeatTimeoutMs << "ms";
    emit heartbeatLost();
    m_graceful = false;
    m_socket->abort();
    emit connectionStatusChanged(false);
    emit stateChanged("Reconnecting");
    startReconnect();
}

// ── Reconnect ──────────────────────────────────

void TcpClientConnectionHandler::tryReconnect()
{
    if (isConnected()) { stopReconnect(); return; }

    m_attempt++;
    int delay = backoffDelay();

    qCInfo(lcTcpClient) << m_cfg.logPrefix << "Reconnect #" << m_attempt << "in" << delay << "ms";
    m_socket->abort();
    m_socket->connectToHost(m_cfg.address, m_cfg.port);
    m_reconnectTimer->start(delay);
}

int TcpClientConnectionHandler::backoffDelay()
{
    int d = m_cfg.reconnectBaseMs * (1 << qMin(m_attempt - 1, 5));
    d = qMin(d, m_cfg.reconnectMaxMs);
    if (int j = d / 10; j > 0) d += QRandomGenerator::global()->bounded(j);
    return d;
}

void TcpClientConnectionHandler::startReconnect()
{
    if (!m_reconnectTimer->isActive()) {
        m_attempt = 0;
        m_reconnectTimer->start(0);
    }
}
