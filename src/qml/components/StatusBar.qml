// ============================================================
// src/qml/components/StatusBar.qml
// ============================================================

import QtQuick 2.15
import ThemeModule 1.0

Rectangle {
    id: root
    height: parent ? parent.height : 30
    color: "transparent"

    Row {
        anchors.centerIn: parent
        spacing: parent.width * .03

        StatusIndicator {
            indicatorColor: tcpClient.connected ? "lightgreen" : "red"
            indicatorSize: root.height * .8
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: "СИСТЕМА: " + (tcpClient.connected ? "ОНЛАЙН" : "ОФФЛАЙН")
            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: "ПОТЕРЯ СИГНАЛА: " + (tcpClient.connected ? "НЕТ" : "ДА")
            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: "ВРЕМЯ: " + new Date().toLocaleTimeString()
            color: Theme.textHighlight
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}

//// ============================================================
//// src/qml/components/StatusBar.qml
//// ============================================================

//import QtQuick 2.15
//import ThemeModule 1.0

//Rectangle {
//    id: root
//    height: 10
//    color: "transparent"

//    Row {
//        anchors.centerIn: root
//        spacing: 30

//        StatusIndicator {
//            indicatorColor: tcpClient.connected ? "lightgreen" : "red"
//            indicatorSize: root.height * .8
//        }

//        Text {
//            text: "СИСТЕМА: " + (tcpClient.connected ? "ОНЛАЙН" : "ОФФЛАЙН")
//            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
//            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
//        }
//        Text {
//            text: "ПОТЕРЯ СИГНАЛА: " + (tcpClient.connected ? "НЕТ" : "ДА")
//            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
//            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
//        }
//        Text {
//            text: "ВРЕМЯ: " + new Date().toLocaleTimeString()
//            color: Theme.accentDim
//            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
//        }
//    }
//}
