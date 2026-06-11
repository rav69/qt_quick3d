QT += quick core gui #quick3d opengl

CONFIG += c++11 qtconsole

TARGET = Simple3DViewer_Qt5
TEMPLATE = app

SOURCES += main.cpp
RESOURCES += resources.qrc

#LIBS += -lGL

DEFINES += QT_QUICK3D_PROFILE=1
