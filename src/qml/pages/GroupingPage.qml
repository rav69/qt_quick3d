// ============================================================
// src/qml/pages/GroupingPage.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D 1.15
import QtGraphicalEffects 1.15

import ThemeModule 1.0

import "../components" as Components

Rectangle {
    id: root
    color: Theme.bgColor

    // ДАННЫЕ МОДЕЛЕЙ
    readonly property var nameModels: [
        ["F-35 Lightning II",  "f35",       1],
        ["F-117 Nighthawk",    "f117",      10],
        ["Shahed-136",         "shahed",    50],
        ["Bayraktar TB2",      "bayraktar", 10],
        ["Military Vehicle",   "vehicle",   10],
        ["Helicopter",         "helicopter",  .5],
        ["Liutyi",             "liutyi",    10],
        ["Star Wars Fighter",  "star_wars",  .07],
        ["Buk Missile System", "buk",       6]
    ]

    readonly property var pagesConfig: [
        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },

        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },

        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 }
    ]

    signal backGroup()
    signal getFilesGroup()
//    signal uploadGroup()
    signal deleteGroup()
    signal saveGroup()

// ─── HEADER ────────────────────────────────────────────────
    Text {
        id: header
        anchors.top: parent.top
        anchors.topMargin: parent.height * .04
        anchors.left: parent.left
        anchors.leftMargin: parent.width * .04
        text: "ГРУППИРОВКА"
        color: Theme.textHighlight
        font {
            family: Theme.fontFamily
            pixelSize: 32//28
            bold: true
            letterSpacing: 3
            capitalization: Font.AllUppercase
        }
    }

    // SwipeView с моделями
    SwipeView {
        id: view
        visible: tcpClient.connected
        currentIndex: 0
        anchors.fill: parent

        Repeater {
            model: pagesConfig

            delegate: Components.ModelCard {
                displayName: nameModels[modelData.modelIndex][0]
                modelName: nameModels[modelData.modelIndex][1]
                modelScale: nameModels[modelData.modelIndex][2]
                rotationDuration: modelData.rotationDuration
                cameraPosition: modelData.cameraPosition
            }
        }
    }

    Column {
        id: leftColumn
        visible: tcpClient.connected
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        spacing: 78
        z: 10

        Components.TacticalButton {
            buttonText: "УРОВЕНЬ ПОДЧ."
            statusColor: "#7CB342"
            onClicked: console.log("▶ Уровень подчиненности")
        }
        Components.TacticalButton {
            buttonText: "ТИП ИСТОЧНИКА"
            statusColor: "#D4A574"
            onClicked: console.log("▶ Тип источника")
        }
        Components.TacticalButton {
            buttonText: "КООРДИНАТЫ"
            statusColor: "#7CB342"
            onClicked: console.log("▶ Координаты")
        }
    }

    Column {
        id: rightColumn
        visible: tcpClient.connected
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        spacing: 78
        z: 10

        Components.TacticalButton {
            buttonText: "ТИП АПД"
            statusColor: "#D4A574"
            onClicked: console.log("▶ Тип АПД")
        }
        Components.TacticalButton {
            buttonText: "БОЕГОТОВНОСТЬ"
            statusColor: "#E74C3C"
            onClicked: console.log("▶ Боеготовность")
        }
        Components.TacticalButton {
            buttonText: "II-й УРОВЕНЬ"
            statusColor: "#7CB342"
            onClicked: console.log("▶ Второй уровень")
        }
    }

    Row {
        id: smartIndicatorCarousel
        visible: tcpClient.connected
        anchors.bottom: view.bottom
        anchors.bottomMargin: parent.height * .2
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8

        property int maxVisible: 7
        property int totalCount: view.count
        property int currentIdx: view.currentIndex

        property int startIdx: Math.max(0, Math.min(
            currentIdx - Math.floor(maxVisible / 2),
            totalCount - maxVisible
        ))
        property int endIdx: Math.min(totalCount, startIdx + maxVisible)

        Repeater {
            model: smartIndicatorCarousel.endIdx - smartIndicatorCarousel.startIdx

            delegate: Item {
                width: realIndex === smartIndicatorCarousel.currentIdx ? 24 : 16
                height: 4

                property int realIndex: smartIndicatorCarousel.startIdx + index

                Rectangle {
                    anchors.fill: parent
                    radius: 0
                    color: realIndex === smartIndicatorCarousel.currentIdx
                           ? Theme.accentColor
                           : Theme.accentDim

                    Behavior on width {
                        NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
                    }
                    Behavior on color {
                        ColorAnimation { duration: 250 }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: view.currentIndex = realIndex
                }
            }
        }
    }

    Row {
        id: bottomRow
        visible: tcpClient.connected
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 67
        z: 10

        Components.TacticalButton {
            buttonText: "НАЗАД"
            indicatorVisible: false
            onClicked: root.backGroup()
        }
        Components.TacticalButton {
            buttonText: "ЗАГРУЗИТЬ"
            indicatorVisible: false
            onClicked: root.getFilesGroup()
        }
        Components.TacticalButton {
            buttonText: "УДАЛИТЬ"
            indicatorVisible: false
            onClicked: root.deleteGroup()
        }
        Components.TacticalButton {
            buttonText: "СОХРАНИТЬ"
            indicatorVisible: false
            onClicked: root.saveGroup()
        }
    }

    Components.FileListOverlay {
        id: fileListOverlay
        anchors.fill: parent
        title: "СПИСОК ФАЙЛОВ"

        onFileSelected: {
            console.log("Выбран файл:", filePath)
            tcpClient.sendFileOpen(filePath)
        }
        onClosed: {
            // дополнительная логика при закрытии
        }
    }

    Connections {
        target: tcpClient

        function onGroupingFilesReceived(filePaths) {
            fileListOverlay.updateFileList(filePaths)
            fileListOverlay.visible = true
        }

        function onFileOpenResult(success, message) {
            if (success) {
                console.log("✅ Файл открыт:", message)
            } else {
                console.warn("❌ Ошибка:", message)
            }
        }
    }
}
