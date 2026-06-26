# ============================================================
# qt_quick3d.pro
# ============================================================

# ─── QT MODULES ──────────────────────────────────────────────
QT += quick quick3d core network webengine webenginewidgets

# ─── CONFIGURATION ───────────────────────────────────────────
CONFIG += c++17 qtconsole

# ─── PROJECT NAME ────────────────────────────────────────────
TARGET = qt_quick3d
TEMPLATE = app

# ─── QT VERSION CHECK (only 5.15.2) ────────────────────────
!equals(QT_VERSION, 5.15.2): \
    error("Only Qt 5.15.2 is supported, but using version $$QT_VERSION")

DEFINES += PB_FIELD_32BIT=1

# ─── SOURCE FILES ────────────────────────────────────────────
SOURCES += \
    src/core/main.cpp \
    src/filesystem/VirtualFileTreeModel/VirtualFileTreeModel.cpp \
    src/models/ModelProvider.cpp \
    src/proto/nanopb/pb_common.c \
    src/proto/nanopb/pb_decode.c \
    src/proto/nanopb/pb_encode.c \
    src/proto/protocol.pb.c \
    src/network/TcpClientConnectionHandler.cpp \
    src/theme/Theme.cpp

# ─── HEADER FILES ────────────────────────────────────────────
HEADERS += \
    src/filesystem/VirtualFileTreeModel/VirtualFileTreeModel.h \
    src/models/ModelProvider.h \
    src/proto/nanopb/pb.h \
    src/proto/nanopb/pb_common.h \
    src/proto/nanopb/pb_decode.h \
    src/proto/nanopb/pb_encode.h \
    src/proto/protocol.pb.h \
    src/network/TcpClientConnectionHandler.h \
    src/theme/Theme.h

# ─── RESOURCES ───────────────────────────────────────────────
RESOURCES += \
    qml.qrc \
    res_images.qrc \
    res_web.qrc

# ─── QML_TYPES SETTINGS (Theme singleton) ────────────────────
CONFIG += qmltypes
QML_IMPORT_NAME = ThemeModule
QML_IMPORT_MAJOR_VERSION = 1
INCLUDEPATH += $$PWD/src/theme

# ─── DEFINES ─────────────────────────────────────────────────
#DEFINES += QT_QUICK3D_PROFILE=1
CONFIG(debug, debug|release) {
    DEFINES += QT_QUICK3D_PROFILE=1
}
# ─── DEBUG MESSAGES ──────────────────────────────────────────
message("Project dir: $$PWD")
message("QML path: $$PWD/src/qml/main.qml")

# ─── COPY CONFIG TO BUILD FOLDER ─────────────────────────────
CONFIG += file_copies
copies.files = $$PWD/src/network/client_config.json
copies.path = $$OUT_PWD
COPIES += copies

DISTFILES += \
    src/proto/protocol.proto
