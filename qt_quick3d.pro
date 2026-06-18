QT += quick quick3d core network

#equals(QT_MAJOR_VERSION, 4): error("Qt 5 required, but Qt 4 detected!")
CONFIG += c++17 qtconsole

message("Project dir: $$PWD")
message("QML path: $$PWD/src/qml/main.qml")

TARGET = qt_quick3d
TEMPLATE = app

SOURCES += \
    src/models/ModelProvider.cpp \
    src/network/TcpClientConnectionHandler.cpp \
    src/core/main.cpp

HEADERS += \
    src/models/ModelProvider.h \
    src/network/TcpClientConnectionHandler.h

RESOURCES += \
    qml.qrc
#    \
#    resources/icons.qrc \

#LIBS += -lGL

DEFINES += QT_QUICK3D_PROFILE=1

# ============================================
# КОПИРОВАНИЕ КОНФИГА В ПАПКУ СБОРКИ
# ============================================
CONFIG += file_copies
copies.files = $$PWD/src/network/client_config.json
copies.path = $$OUT_PWD
COPIES += copies
