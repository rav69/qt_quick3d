// ============================================================
// src/network/TcpClientConnectionHandler.cpp
// ============================================================


#include "TcpClientConnectionHandler.h"
#include <QDataStream>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QRandomGenerator>
#include <QUuid>
#include <QDateTime>

Q_LOGGING_CATEGORY(lcTcpClient, "tcp.client")

// ── Helpers ──────────────────────────────────────────────────

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

// ── Config Loader ────────────────────────────────────────────

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

// ── Constructor / Destructor ─────────────────────────────────

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

// ── Public Slots ─────────────────────────────────────────────

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

void TcpClientConnectionHandler::sendGetSources()
{
    if (!isConnected()) {
        qCWarning(lcTcpClient) << m_cfg.logPrefix << "Not connected, cannot send request";
        return;
    }

    fieldops_Envelope env = fieldops_Envelope_init_zero;
    QByteArray msgId = QUuid::createUuid().toString().toUtf8();
    int maxIdLen = sizeof(env.message_id) - 1;
    strncpy(env.message_id, msgId.constData(), maxIdLen);
    env.message_id[maxIdLen] = '\0';
    strncpy(env.action, "get_sources", sizeof(env.action) - 1);
    env.action[sizeof(env.action) - 1] = '\0';
    env.timestamp = QDateTime::currentMSecsSinceEpoch();

    env.which_payload = fieldops_Envelope_sources_req_tag;
    sendProtobuf(env);
    qCInfo(lcTcpClient) << m_cfg.logPrefix << "Sent GET_SOURCES request ID:" << env.message_id;
}

void TcpClientConnectionHandler::sendGetGroupingFiles()
{
    if (!isConnected()) {
        qCWarning(lcTcpClient) << m_cfg.logPrefix << "Not connected, cannot send request";
        return;
    }

    fieldops_Envelope env = fieldops_Envelope_init_zero;
    QByteArray msgId = QUuid::createUuid().toString().toUtf8();
    int maxIdLen = sizeof(env.message_id) - 1;
    strncpy(env.message_id, msgId.constData(), maxIdLen);
    env.message_id[maxIdLen] = '\0';
    strncpy(env.action, "get_grouping_files", sizeof(env.action) - 1);
    env.action[sizeof(env.action) - 1] = '\0';
    env.timestamp = QDateTime::currentMSecsSinceEpoch();

    env.which_payload = fieldops_Envelope_grouping_files_req_tag;
    sendProtobuf(env);
    qCInfo(lcTcpClient) << m_cfg.logPrefix << "Sent GET_GROUPING_FILES request ID:" << env.message_id;
}

void TcpClientConnectionHandler::sendFileOpen(const QString &relPath)
{
    if (!isConnected()) {
        qCWarning(lcTcpClient) << "Not connected";
        return;
    }

    fieldops_Envelope env = fieldops_Envelope_init_zero;
    QByteArray msgId = QUuid::createUuid().toString().toUtf8();
    strncpy(env.message_id, msgId.constData(), sizeof(env.message_id)-1);
    strncpy(env.action, "file_open", sizeof(env.action)-1);
    env.timestamp = QDateTime::currentMSecsSinceEpoch();

    env.which_payload = fieldops_Envelope_file_open_req_tag;
    strncpy(env.payload.file_open_req.full_path, relPath.toUtf8().constData(), sizeof(env.payload.file_open_req.full_path)-1);
    env.payload.file_open_req.full_path[sizeof(env.payload.file_open_req.full_path)-1] = '\0';

    sendProtobuf(env);
    qCInfo(lcTcpClient) << "Sent FILE_OPEN request for:" << relPath;
}

// ── Private Slots ────────────────────────────────────────────

void TcpClientConnectionHandler::onConnected()
{
    stopReconnect();
    qCInfo(lcTcpClient) << m_cfg.logPrefix << "[CONNECTED]" << m_cfg.address << ":" << m_cfg.port;
    emit connectionStatusChanged(true);
    emit stateChanged("Connected");
    m_heartbeat->start();
    resetWatchdog();
    m_buffer.clear();
    m_expectedSize = 0;

    // Отправляем запрос сразу после соединения
    sendGetSources();

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

void TcpClientConnectionHandler::removePongFromData(QByteArray &data)
{
    int pos = data.indexOf("PONG");
    while (pos != -1) {
        resetWatchdog();
        qCDebug(lcTcpClient) << m_cfg.logPrefix << "PONG received, watchdog reset";
        data.remove(pos, 4);
        pos = data.indexOf("PONG");
    }
}

void TcpClientConnectionHandler::onReadyRead()
{
    QByteArray data = m_socket->readAll();
    removePongFromData(data);
    if (!data.isEmpty()) {
        m_buffer.append(data);
        processBuffer();
    }
}

// ── Heartbeat ────────────────────────────────────────────────

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

// ── Reconnect ────────────────────────────────────────────────

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

void TcpClientConnectionHandler::sendProtobuf(const fieldops_Envelope &env)
{
    uint8_t buffer[PROTOBUF_SEND_BUFFER_SIZE];
    pb_ostream_t stream = pb_ostream_from_buffer(buffer, sizeof(buffer));
    if (!pb_encode(&stream, fieldops_Envelope_fields, &env)) {
        qCWarning(lcTcpClient) << m_cfg.logPrefix << "Encoding error:" << PB_GET_ERROR(&stream);
        return;
    }

    QByteArray frame;
    QDataStream ds(&frame, QIODevice::WriteOnly);
    ds << quint32(stream.bytes_written);
    frame.append((const char*)buffer, stream.bytes_written);
    m_socket->write(frame);
}

void TcpClientConnectionHandler::processBuffer()
{
    while (true) {
        if (m_expectedSize == 0 && m_buffer.size() >= 4) {
            QDataStream ds(m_buffer);
            ds >> m_expectedSize;
            m_buffer.remove(0, 4);
        }

        if (m_expectedSize == 0 || m_buffer.size() < m_expectedSize)
            break;

        QByteArray msg = m_buffer.left(m_expectedSize);
        m_buffer.remove(0, m_expectedSize);

        // ===== ОТЛАДОЧНЫЙ ВЫВОД =====
//        qCInfo(lcTcpClient) << "Received" << m_expectedSize << "bytes";
//        if (m_expectedSize > 0) {
//            QByteArray hex = msg.left(100).toHex();
//            qCInfo(lcTcpClient) << "Hex (first 100 bytes):" << hex;
//        }
        // =============================

        fieldops_Envelope env = fieldops_Envelope_init_zero;
        pb_istream_t stream = pb_istream_from_buffer(
            (const uint8_t*)msg.constData(), msg.size()
        );
        if (!pb_decode(&stream, fieldops_Envelope_fields, &env)) {
            qCWarning(lcTcpClient) << m_cfg.logPrefix << "Decode error:" << PB_GET_ERROR(&stream);
            m_expectedSize = 0;
            continue;
        }

        // =================================
        switch (env.which_payload) {
        case fieldops_Envelope_sources_resp_tag:
        {
            int count = env.payload.sources_resp.count;
            qCInfo(lcTcpClient) << m_cfg.logPrefix << "Received sources count:" << count;
            emit sourcesReceived(count);
            break;
        }
        case fieldops_Envelope_grouping_files_resp_tag:
        {
            auto &resp = env.payload.grouping_files_resp;
            qCInfo(lcTcpClient) << m_cfg.logPrefix << "Received grouping files count:" << resp.count;

            QStringList filePaths;
            for (int i = 0; i < resp.count; ++i) {
                filePaths.append(QString::fromUtf8(resp.files[i].full_path));
            }
            emit groupingFilesReceived(filePaths);
            break;
        }
        case fieldops_Envelope_file_open_resp_tag:
        {
            bool success = env.payload.file_open_resp.success;
            QString msg = QString::fromUtf8(env.payload.file_open_resp.message);
            qCInfo(lcTcpClient) << "File open result:" << (success ? "SUCCESS" : "FAILED") << msg;
            emit fileOpenResult(success, msg);
            break;
        }
        default:
            break;
        }

        m_expectedSize = 0;
    }

    // Защита от переполнения буфера
    if (m_buffer.size() > MAX_RECEIVE_BUFFER_SIZE) { // 1 MB
        qCWarning(lcTcpClient) << m_cfg.logPrefix << "Buffer overflow, resetting";
        m_buffer.clear();
        m_expectedSize = 0;
    }
}

void TcpClientConnectionHandler::startReconnect()
{
    if (!m_reconnectTimer->isActive()) {
        m_attempt = 0;
        m_reconnectTimer->start(0);
    }
}
