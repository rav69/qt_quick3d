#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>
#include <QDebug>

#include "modelprovider.h"

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

    ModelProvider modelProvider;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("modelProvider", &modelProvider);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Failed to load QML";
        return -1;
    }

    return app.exec();
}

//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
//#include <QSurfaceFormat>
//#include <QDebug>
//#include <QOpenGLContext>

//int main(int argc, char *argv[])
//{
//    // Настройки для SVGA3D драйвера
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

//    qDebug() << "OpenGL format set to:" << QSurfaceFormat::defaultFormat().version();
//    qDebug() << "Profile:" << (QSurfaceFormat::defaultFormat().profile() == QSurfaceFormat::CoreProfile ? "Core" : "Compatibility");

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    if (engine.rootObjects().isEmpty()) {
//        qDebug() << "Failed to load QML";
//        return -1;
//    }

//    return app.exec();
//}
