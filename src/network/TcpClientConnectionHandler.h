#pragma once

#include <QObject>
#include <QTcpSocket>
#include <QTimer>
#include <QLoggingCategory>

Q_DECLARE_LOGGING_CATEGORY(lcTcpClient)

struct ClientConfig {
    QString address = "192.9.192.215";
    quint16 port = 8089;
    int heartbeatMs = 2000;
    int heartbeatTimeoutMs = 8000;
    int reconnectBaseMs = 1000;
    int reconnectMaxMs = 30000;
    bool autoConnect = true;
    QString logPrefix = "[CLIENT]";
};

class TcpClientConnectionHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool connected READ isConnected NOTIFY connectionStatusChanged)

public:
    explicit TcpClientConnectionHandler(const ClientConfig &cfg = ClientConfig(),
                                        QObject *parent = nullptr);
    ~TcpClientConnectionHandler() override;

    bool isConnected() const { return m_socket->state() == QTcpSocket::ConnectedState; }
    const ClientConfig &config() const { return m_cfg; }

    static ClientConfig loadConfig(const QString &path = "client_config.json");

public slots:
    void connectToServer();
    void disconnectFromServer();
    void sendData(const QByteArray &data) { if (isConnected()) m_socket->write(data); }

signals:
    void connectionStatusChanged(bool connected);
    void dataReceived(const QByteArray &data);
    void heartbeatLost();
    void stateChanged(const QString &state);

private slots:
    void onConnected();
    void onDisconnected();
    void onError(QAbstractSocket::SocketError);
    void onReadyRead();
    void sendHeartbeat();
    void onHeartbeatTimeout();
    void tryReconnect();

private:
    void startReconnect();
    void stopReconnect() { m_reconnectTimer->stop(); m_attempt = 0; }
    void resetWatchdog() { m_watchdog->start(); }
    int  backoffDelay();

    QTcpSocket *m_socket;
    QTimer *m_heartbeat, *m_watchdog, *m_reconnectTimer;
    ClientConfig m_cfg;
    int m_attempt = 0;
    bool m_graceful = false;
};
