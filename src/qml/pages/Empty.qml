// ============================================================
// src/qml/pages/Empty.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import ThemeModule 1.0
import "../components" as Components

Rectangle {
    id: root
    color: Theme.bgColor

    signal backEmpty()

    Text {
        anchors.centerIn: parent
        text: "ЗАГЛУШКА"
        color: Theme.textHighlight
        font {
            family: Theme.fontFamily
            pixelSize: 38
            bold: true
            letterSpacing: 3
            capitalization: Font.AllUppercase
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
            onClicked: root.backEmpty()
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
