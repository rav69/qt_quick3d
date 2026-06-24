// ============================================================
// src/qml/pages/AlgorithmsPage.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import ThemeModule 1.0
import "../components" as Components

Rectangle {
    id: root
    color: Theme.bgColor

    signal backAlgo()

    // ─── HEADER ────────────────────────────────────────────────
    Text {
        id: header
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        text: "АЛГОРИТМЫ"
        color: Theme.textHighlight
        font {
            family: Theme.fontFamily
            pixelSize: 28
            bold: true
            letterSpacing: 3
            capitalization: Font.AllUppercase
        }
    }

    // ─── BUTTONS GRID ─────────────────────────────────────────
    Grid {
        id: grid
        anchors.centerIn: parent
        spacing: 30
        columns: 3

        // Кнопки
        Repeater {
            model: [
                "Настройка ЦР",
                "Настройка КРУ",
                "Настройка КБД",
                "Настройка ВОП",
                "Настройка ...",
                "Настройка ..."
            ]

            delegate: Components.TacticalButton {
                width: 180
                height: 60
                buttonText: modelData
                statusColor: "#7CB342"
                onClicked: console.log("▶ Выбран:", modelData)
            }
        }
    }

    Row {
        id: bottomRow
        visible: tcpClient.connected
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * .1
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 78
        z: 10

        Components.TacticalButton {
            buttonText: "НАЗАД"
            statusColor: "#D4A574"
            indicatorVisible: false
            onClicked: root.backAlgo()
        }
//        Components.TacticalButton {
//            buttonText: "ВВОД"
//            statusColor: "#E74C3C"
//            indicatorVisible: false
//            onClicked: console.log("22222")
//        }
//        Components.TacticalButton {
//            buttonText: "ОТМЕНИТЬ"
//            statusColor: "#7CB342"
//            indicatorVisible: false
//            onClicked: console.log("33333")
//        }
    }
}
