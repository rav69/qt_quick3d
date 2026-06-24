// ============================================================
// src/qml/components/FileListOverlay.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import ThemeModule 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "#50000000"
    visible: false
    z: 20

    // ─── СВОЙСТВА ──────────────────────────────────────────────
    property alias model: fileListView.model
    property alias delegate: fileListView.delegate
    property string title: "СПИСОК ФАЙЛОВ"

    signal fileSelected(string filePath)
    signal closed()

    // ─── БЛОКИРОВКА СОБЫТИЙ ──────────────────────────────────
    MouseArea {
        anchors.fill: parent
        onClicked: {}
        onPressed: {}
    }

    // ─── КАРТОЧКА СПИСКА ──────────────────────────────────────
    Rectangle {
        width: parent.width * 0.6
        height: parent.height * 0.7
        anchors.centerIn: parent
        color: Theme.bgColor
        border.color: Theme.accentDim
        border.width: 2
        radius: 8

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Text {
                text: root.title
                color: Theme.textHighlight
                font {
                    family: Theme.fontFamily
                    pixelSize: 20
                    bold: true
                    letterSpacing: 2
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Theme.accentDim
                opacity: 0.5
            }

            ScrollView {
                id: fileScrollView
                width: parent.width
                height: parent.height - 80
                clip: true

                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ListView {
                    id: fileListView
                    anchors.fill: parent
                    clip: true

                    delegate: Item {
                        width: fileListView.width
                        height: 40
                        Rectangle {
                            anchors.fill: parent
                            color: mouseArea.containsMouse ? Theme.accentColor : "transparent"
                            opacity: mouseArea.containsMouse ? 0.2 : 0
                            Behavior on opacity { NumberAnimation { duration: 150 } }
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
//                            text: modelData
                            text: modelData.split('/').pop()
                            color: Theme.textColor
                            font { family: Theme.fontFamily; pixelSize: 14 }
                        }
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                root.fileSelected(modelData)
                                root.visible = false
                            }
                        }
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                TacticalButton {
                    buttonText: "ЗАКРЫТЬ"
                    statusColor: "#D4A574"
                    indicatorVisible: false
                    width: 120
                    height: 40
                    onClicked: {
                        root.visible = false
                        root.closed()
                    }
                }
            }
        }
    }

    // ─── ФУНКЦИЯ ОБНОВЛЕНИЯ СПИСКА ──────────────────────────
    function updateFileList(files) {
        fileListView.model = files
    }
}
