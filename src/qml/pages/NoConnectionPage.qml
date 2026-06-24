// ============================================================
// src/qml/pages/NoConnectionPage.qml
// ============================================================

import QtQuick 2.15
import ThemeModule 1.0
import "../components" as Components

Rectangle {
    id: root
    anchors.fill: parent
    color: Theme.bgColor
    visible: !tcpClient.connected

    // ─── RADIO INTERFERENCE ──────────────────────────────────
    Rectangle {
        anchors.fill: parent
        color: "transparent"

        Repeater {
            id: r
            model: 200
            Rectangle {
                x: Math.random() * parent.width
                y: Math.random() * parent.height
                width: Math.random() * 100 + 20
                height: 2
                color: "lightgrey"
                opacity: 0.5
            }
        }

        Timer {
            interval: 300
            running: true
            repeat: true
            onTriggered: {
                for (var i = 0; i < r.count; ++i) {
                    var item = r.itemAt(i)
                    if (item) {
                        item.x = Math.random() * parent.width
                        item.y = Math.random() * parent.height
                    }
                }
            }
        }
    }

    // ─── MESSAGE CARD ────────────────────────────────────────
    Rectangle {
        id: messageCard
        width: 480
        height: 200
        anchors.centerIn: parent
        color: "transparent"

        Components.TacticalCorners {
            anchors.fill: parent
            cornerSize: 30
            cornerThickness: 3
            cornerColor: Theme.accentColor
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "📡"
                color: Theme.textHighlight
                font.pixelSize: 64
                opacity: 0.5
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.2; duration: 1200 }
                    NumberAnimation { to: 0.6; duration: 1200 }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "СВЯЗЬ С СЕРВЕРОМ\nОТСУТСТВУЕТ"
                color: Theme.textHighlight
                font {
                    family: Theme.fontFamily
                    pixelSize: 28
                    bold: true
                    capitalization: Font.AllUppercase
                    letterSpacing: 3
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "ОЖИДАНИЕ ПОДКЛЮЧЕНИЯ..."
                color: Theme.textHighlight
                font {
                    family: Theme.fontFamily
                    pixelSize: 14
                    letterSpacing: 4
                }
                horizontalAlignment: Text.AlignHCenter
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.3; duration: 800 }
                    NumberAnimation { to: 1.0; duration: 800 }
                }
            }
        }
    }
}
