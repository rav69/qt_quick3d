import QtQuick 2.15
import ThemeModule 1.0

Rectangle {
    id: root
    height: 30
    color: "transparent"

    Row {
        anchors.centerIn: parent
        spacing: 30

        Text {
            text: "СИСТЕМА: " + (tcpClient.connected ? "ОНЛАЙН" : "ОФФЛАЙН")
            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
        }
        Text {
            text: "ПОТЕРЯ СИГНАЛА: " + (tcpClient.connected ? "НЕТ" : "ДА")
            color: tcpClient.connected ? "#7CB342" : "#E74C3C"
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
        }
        Text {
            text: "ВРЕМЯ: " + new Date().toLocaleTimeString()
            color: Theme.accentDim
            font { family: Theme.fontFamily; pixelSize: 11; bold: true }
        }
    }
}
