// ============================================================
// src/qml/components/StatusIndicator.qml
// ============================================================

import QtQuick 2.15

Rectangle {
    id: root

    property color indicatorColor: "#7CB342"
    property int indicatorSize: 8

    width: indicatorSize
    height: indicatorSize
    radius: indicatorSize / 2
    color: indicatorColor

    SequentialAnimation on opacity {
        loops: Animation.Infinite
        NumberAnimation { to: 0.3; duration: 800 }
        NumberAnimation { to: 1.0; duration: 800 }
    }
}
