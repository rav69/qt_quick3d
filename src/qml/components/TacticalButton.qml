// ============================================================
// src/qml/components/TacticalButton.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import ThemeModule 1.0

Item {
    id: btnRoot
    width: Theme.buttonWidth
    height: Theme.buttonHeight

    property string buttonText: ""
    property color statusColor: "#7CB342"
    property bool isActive: false

    signal clicked()

    Rectangle {
        id: btnBody
        anchors.fill: parent
        radius: Theme.buttonRadius
        color: mouseArea.pressed ? Qt.darker(Theme.cardColor, 1.3)
                                 : (mouseArea.containsMouse ? Qt.lighter(Theme.cardColor, 1.2) : Theme.cardColor)
        border.width: mouseArea.containsMouse ? Theme.buttonBorderWidth + 1 : Theme.buttonBorderWidth
        border.color: mouseArea.pressed ? Theme.textHighlight
                                        : (mouseArea.containsMouse ? Theme.accentColor : Theme.accentDim)

        Behavior on color { ColorAnimation { duration: 150 } }
        Behavior on border.width { NumberAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        // Тактические скобки
        TacticalCorners {
            anchors.fill: parent
            cornerSize: Theme.cornerMarkSize
            cornerThickness: Theme.cornerMarkThick
            cornerColor: Theme.accentColor
        }

        // Индикатор состояния
        StatusIndicator {
            id: statusDot
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.verticalCenter: parent.verticalCenter
            indicatorColor: btnRoot.statusColor
            indicatorSize: 8
        }

        Text {
            anchors.left: statusDot.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            text: btnRoot.buttonText
            color: mouseArea.pressed ? Theme.textHighlight
                                     : (mouseArea.containsMouse ? Theme.textHighlight : Theme.textColor)
            font {
                family: Theme.fontFamily
                pixelSize: Theme.buttonFontSize
                bold: true
                capitalization: Font.AllUppercase
                letterSpacing: 1.2
            }
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.Wrap

            Behavior on color { ColorAnimation { duration: 150 } }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btnRoot.clicked()
    }
}
