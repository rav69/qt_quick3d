QT += quick quick3d core network

#equals(QT_MAJOR_VERSION, 4): error("Qt 5 required, but Qt 4 detected!")
CONFIG += c++17 qtconsole

TARGET = Simple3DViewer_Qt5
TEMPLATE = app

SOURCES += \
    ModelProvider.cpp \
    TcpClientConnectionHandler.cpp \
    main.cpp

HEADERS += \
    ModelProvider.h \
    TcpClientConnectionHandler.h

RESOURCES += resources.qrc

#LIBS += -lGL

DEFINES += QT_QUICK3D_PROFILE=1
