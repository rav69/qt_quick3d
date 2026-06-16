QT += quick quick3d core

CONFIG += c++11 qtconsole

TARGET = Simple3DViewer_Qt5
TEMPLATE = app

SOURCES += \
    main.cpp \
    modelprovider.cpp

HEADERS += \
    modelprovider.h

RESOURCES += resources.qrc

#LIBS += -lGL

DEFINES += QT_QUICK3D_PROFILE=1
