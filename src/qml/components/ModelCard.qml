// ============================================================
// src/qml/components/ModelCard.qml
// ============================================================

import QtQuick 2.15
import QtGraphicalEffects 1.15

import ThemeModule 1.0

import ".." as Components

Item {
    id: root

    property string displayName: ""
    property string modelName: ""
    property real modelScale: 1.0
    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
    property int rotationDuration: 8000

    // Карточка с 3D моделью
    Rectangle {
        id: card
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        color: Theme.cardColor
        radius: Theme.cartRadius
        border.width: Theme.cartBorderWidth
        border.color: Theme.cartBorderColor

        // Тактические скобки
        TacticalCorners {
            anchors.fill: parent
            cornerSize: 25
            cornerThickness: 3
            cornerColor: Theme.accentColor
        }
//        Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.left: parent.left; color: Theme.accentColor }
//        Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.left: parent.left; color: Theme.accentColor }
//        Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.right: parent.right; color: Theme.accentColor }
//        Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.right: parent.right; color: Theme.accentColor }
//        Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.left: parent.left; color: Theme.accentColor }
//        Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.left: parent.left; color: Theme.accentColor }
//        Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.right: parent.right; color: Theme.accentColor }
//        Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.right: parent.right; color: Theme.accentColor }

        ModelViewer {
            anchors.fill: parent
            anchors.margins: 10
            modelName: root.modelName
            modelScale: root.modelScale
            rotationDuration: root.rotationDuration
            cameraPosition: root.cameraPosition
        }
    }

    // Заголовок модели
    Text {
        anchors.bottom: card.top
        anchors.bottomMargin: parent.height * .08
        anchors.horizontalCenter: parent.horizontalCenter

        text: root.displayName
        color: Theme.textHighlight
        font {
            pixelSize: Theme.titleFontSize
            bold: true
            capitalization: Font.AllUppercase
            letterSpacing: Theme.letterSpacing
        }

        layer.enabled: false
        layer.effect: Glow {
            radius: 4
            samples: 12
            color: Theme.accentColor
            transparentBorder: true
            opacity: 0.6
        }
    }

    // Статус-бар
    Text {
        anchors.top: card.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Состояние: ГОТОВ" +
              "  |  Уровень: ПОДЧИНЕННЫЙ" +
              "  |  Оргштатка: ЗРБР"
        color: Theme.accentDim
        font {
            family: Theme.fontFamily
            pixelSize: 14
            letterSpacing: 1.2
            bold: true
        }
    }
}

//import QtQuick 2.15

//Item {
//    id: root

//    property string modelName: ""
//    property real modelScale: 1.0
//    property vector3d cameraPosition: Qt.vector3d(0, 25, 150)
//    property int rotationDuration: 8000
//    property string displayName: ""

//    // Ссылка на тему (проксируется сверху)
//    property QtObject theme: Theme { }

//    // Карточка с 3D моделью
//    Rectangle {
//        id: card
//        width: parent.width / 1.5
//        height: parent.height / 2
//        anchors.centerIn: parent
//        color: theme.cartColor
//        radius: theme.cartRadius
//        border.width: theme.cartBorderWidth
//        border.color: theme.cartBorderColor

//        ModelViewer {
//            anchors.fill: parent
//            modelName: root.modelName
//            modelScale: root.modelScale
//            rotationDuration: root.rotationDuration
//            cameraPosition: root.cameraPosition
//        }
//    }

//    // Заголовок модели
//    Text {
//        anchors.bottom: card.top
//        anchors.bottomMargin: parent.height * 0.1
//        anchors.horizontalCenter: parent.horizontalCenter

//        text: root.displayName
//        color: theme.textColor
//        font.pixelSize: theme.textBaseFontSize
//        font.bold: true
//        font.letterSpacing: 1.5
//    }
//}
