#include <QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QSurfaceFormat>
#include <QDebug>

#include "../models/ModelProvider.h"
#include "../network/TcpClientConnectionHandler.h"

int main(int argc, char *argv[])
{
    // Настройка OpenGL
    QSurfaceFormat format;
    format.setVersion(3, 3);
    format.setProfile(QSurfaceFormat::CoreProfile);
    format.setDepthBufferSize(24);
    format.setStencilBufferSize(8);
    format.setSamples(4);
    format.setSwapBehavior(QSurfaceFormat::DoubleBuffer);
    format.setRenderableType(QSurfaceFormat::OpenGL);
    QSurfaceFormat::setDefaultFormat(format);

    QGuiApplication app(argc, argv);

    // ── TCP Client Setup ──────────────────────────
    QString cfgPath = QCoreApplication::applicationDirPath() + "/client_config.json";
    auto cfg = TcpClientConnectionHandler::loadConfig(cfgPath);

    TcpClientConnectionHandler tcpClient(cfg);

    // Логирование состояний подключения
    QObject::connect(&tcpClient, &TcpClientConnectionHandler::connectionStatusChanged,
        [&cfg](bool connected) {
            if (connected)
                qInfo() << cfg.logPrefix << "[CONNECTED] Server connection established";
            else
                qWarning() << cfg.logPrefix << "[DISCONNECTED] Server connection lost";
        });

    QObject::connect(&tcpClient, &TcpClientConnectionHandler::stateChanged,
        [&cfg](const QString &state) {
            qDebug() << cfg.logPrefix << "State:" << state;
        });

    QObject::connect(&tcpClient, &TcpClientConnectionHandler::dataReceived,
        [&cfg](const QByteArray &data) {
            qDebug() << cfg.logPrefix << "Data received:" << data;
        });

    QObject::connect(&tcpClient, &TcpClientConnectionHandler::heartbeatLost,
        [&cfg]() {
            qCritical() << cfg.logPrefix << "[HEARTBEAT LOST] Server unreachable!";
        });
    // ── End TCP Client Setup ──────────────────────

    ModelProvider modelProvider;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("modelProvider", &modelProvider);
    // Экспортируем TCP-клиент в QML (опционально)
    engine.rootContext()->setContextProperty("tcpClient", &tcpClient);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Failed to load QML";
        return -1;
    }

    return app.exec();
}

//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
//#include <QQmlContext>
//#include <QSurfaceFormat>
//#include <QDebug>

//#include "ModelProvider.h"

//int main(int argc, char *argv[])
//{
//    // Настройка OpenGL
//    QSurfaceFormat format;
//    format.setVersion(3, 3);
//    format.setProfile(QSurfaceFormat::CoreProfile);
//    format.setDepthBufferSize(24);
//    format.setStencilBufferSize(8);
//    format.setSamples(4);
//    format.setSwapBehavior(QSurfaceFormat::DoubleBuffer);
//    format.setRenderableType(QSurfaceFormat::OpenGL);
//    QSurfaceFormat::setDefaultFormat(format);

//    QGuiApplication app(argc, argv);

//    ModelProvider modelProvider;

//    QQmlApplicationEngine engine;

//    engine.rootContext()->setContextProperty("modelProvider", &modelProvider);

//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty()) {
//        qCritical() << "Failed to load QML";
//        return -1;
//    }

//    return app.exec();
//}
