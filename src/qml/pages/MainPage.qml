// ============================================================
// src/qml/pages/MainPage.qml
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

    // ЗАГЛУШКА "СВЯЗЬ ОТСУТСТВУЕТ"
    Rectangle {
        id: noConnectionOverlay
        anchors.fill: parent
        color: Theme.bgColor
        visible: !tcpClient.connected

        // Фоновый узор (имитация радиопомех)
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

        // Центральная карточка с сообщением
        Rectangle {
            id: messageCard
            width: 480
            height: 200
            anchors.centerIn: parent
            color: "transparent"

            // Тактические скобки
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

    // ЛЕВАЯ КОЛОНКА КНОПОК
    Column {
        id: leftColumn
        visible: tcpClient.connected
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        spacing: 78
        z: 10

        Components.TacticalButton {
            buttonText: "УРОВЕНЬ\nПОДЧИНЕННОСТИ"
            statusColor: "#7CB342"
            onClicked: console.log("▶ Уровень подчиненности")
        }
        Components.TacticalButton {
            buttonText: "ТИП\nИСТОЧНИКА"
            statusColor: "#D4A574"
            onClicked: console.log("▶ Тип источника")
        }
        Components.TacticalButton {
            buttonText: "КООРДИНАТЫ"
            statusColor: "#7CB342"
            onClicked: console.log("▶ Координаты")
        }
    }

    // ПРАВАЯ КОЛОНКА КНОПОК
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
            buttonText: "ВТОРОЙ\nУРОВЕНЬ"
            statusColor: "#7CB342"
            onClicked: console.log("▶ Второй уровень")
        }
    }

    // Индикатор карусели
    Row {
        id: smartIndicator
        visible: tcpClient.connected
        anchors.bottom: view.bottom
        anchors.bottomMargin: 40
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
            model: smartIndicator.endIdx - smartIndicator.startIdx

            delegate: Item {
                width: realIndex === smartIndicator.currentIdx ? 24 : 16
                height: 4

                property int realIndex: smartIndicator.startIdx + index

                Rectangle {
                    anchors.fill: parent
                    radius: 0
                    color: realIndex === smartIndicator.currentIdx
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
}

//import QtQuick 2.15
//import QtQuick.Window 2.15

//Rectangle {
//    color: "red"
//}


//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15
//import QtGraphicalEffects 1.15

//import "../components" as Components

//Rectangle {
//    color: theme.bgColor

//    // ДАННЫЕ МОДЕЛЕЙ
//    readonly property var nameModels: [
//        ["F-35 Lightning II",  "f35",       1],
//        ["F-117 Nighthawk",    "f117",      10],
//        ["Shahed-136",         "shahed",    50],
//        ["Bayraktar TB2",      "bayraktar", 10],
//        ["Military Vehicle",   "vehicle",   10],
//        ["Helicopter",         "helicopter",  .5],
//        ["Liutyi",             "liutyi",    10],
//        ["Star Wars Fighter",  "star_wars",  .07],
//        ["Buk Missile System", "buk",       6]
//    ]

//    readonly property var pagesConfig: [
//        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
//        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
//        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
//        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },

//        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
//        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
//        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
//        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },

//        { modelIndex: 0, cameraPosition: Qt.vector3d(0, 25, 150), rotationDuration: 8000 },
//        { modelIndex: 1, cameraPosition: Qt.vector3d(0, 10, 150), rotationDuration: 8000 },
//        { modelIndex: 3, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 4, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 5, cameraPosition: Qt.vector3d(0, 0, 90),   rotationDuration: 8000 },
//        { modelIndex: 7, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 },
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 }
//    ]

//    // DESERT OPS THEME
//    QtObject {
//        id: theme

//        // Цветовая палитра
//        property color bgColor:         "#1C1814"
//        property color cardColor:       "#A000BFFF"
//        property color accentColor:     "#D4A574"
//        property color accentDim:       "#8B7355"
//        property color warningColor:    "#E74C3C"
//        property color textColor:       "#E8DCC4"
//        property color textHighlight:   "#F4C983"

//        // Типографика
//        property string fontFamily:     "Tahoma"
//        property int textBaseFontSize:  26
//        property int titleFontSize:     32
//        property real letterSpacing:    1.5

//        // Карточка
//        property int cartRadius:        0
//        property int cartBorderWidth:   2
//        property color cartBorderColor: accentDim

//        // Свойства для кнопок
//        property int buttonWidth:       170
//        property int buttonHeight:      48
//        property int buttonFontSize:    12
//        property int buttonRadius:      0       // Прямые углы — military style
//        property int buttonBorderWidth: 2       // Утолщённая рамка
//        property int cornerMarkSize:    12      // Размер тактических скобок
//        property int cornerMarkThick:   2       // Толщина скобок
//    }

//    Rectangle {
//        id: statusDot
//        height: parent.height * .025
//        width: height
//        radius: height / 2
//        color: tcpClient.connected ? "lightgreen" : "red"
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.bottomMargin: 10
//        anchors.leftMargin: 240
//        z: 1

//        // Пульсация
//        SequentialAnimation on opacity {
//            loops: Animation.Infinite
//            NumberAnimation { to: 0.3; duration: 800 }
//            NumberAnimation { to: 1.0; duration: 800 }
//        }
//    }

//    // ЗАГЛУШКА "СВЯЗЬ ОТСУТСТВУЕТ"
//    Rectangle {
//        id: noConnectionOverlay
//        anchors.fill: parent
//        color: theme.bgColor
//        visible: !tcpClient.connected

//        // Фоновый узор (имитация радиопомех)
//        Rectangle {
//            id: sakjgdhaksjd
//            anchors.fill: parent
//            color: "transparent"

//            // Полосы помех
//            Repeater {
//                id: repeater
//                model: 200

//                Rectangle {
//                    id: line
//                    x: Math.random() * parent.width
//                    y: Math.random() * parent.height
//                    width: Math.random() * 100 + 20
//                    height: 2
//                    color: "lightgrey"//"#aaD4A574"
////                    rotation: Math.random() * 360
//                    opacity: 0.5
//                    SequentialAnimation {
//                        running: true
//                        loops: Animation.Infinite

//                        NumberAnimation {
//                            target: line
//                            property: "opacity"
//                            from: 0.5
//                            to: 0.0
//                            duration: 2000 + Math.random() * 3000
//                        }
//                        NumberAnimation {
//                            target: line
//                            property: "opacity"
//                            from: 0.0
//                            to: 0.5
//                            duration: 1000 + Math.random() * 2000
//                        }
//                        ScriptAction {
//                            script: {
//                                // Обновляем позицию после цикла
//                                line.x = Math.random() * parent.width
//                                line.y = Math.random() * parent.height
//                            }
//                        }
//                    }
//                }
//            }

////            Timer {
////                interval: 5000
////                running: true
////                repeat: true
////                onTriggered: {
////                    for (var i = 0; i < repeater.count; i++) {
////                        var item = repeater.itemAt(i)
////                        if (item) {
////                            item.x = Math.random() * parent.width
////                            item.y = Math.random() * parent.height
////                        }
////                    }
////                }
////            }

//        }

//        // Центральная карточка с сообщением
//        Rectangle {
//            id: messageCard
//            width: 480
//            height: 200
//            anchors.centerIn: parent
//            color: "transparent"

//            // Тактические скобки
//            Rectangle { width: 30; height: 3; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
//            Rectangle { width: 3; height: 30; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
//            Rectangle { width: 30; height: 3; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
//            Rectangle { width: 3; height: 30; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
//            Rectangle { width: 30; height: 3; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
//            Rectangle { width: 3; height: 30; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
//            Rectangle { width: 30; height: 3; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }
//            Rectangle { width: 3; height: 30; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }

//            Column {
//                anchors.centerIn: parent
//                spacing: 20

//                // Иконка антенны (текстовый символ)
//                Text {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    text: "📡"
//                    color: theme.textHighlight//accentDim
//                    font.pixelSize: 64
//                    opacity: 0.5

//                    // Анимация "поиска сигнала"
//                    SequentialAnimation on opacity {
//                        loops: Animation.Infinite
//                        NumberAnimation { to: 0.2; duration: 1200 }
//                        NumberAnimation { to: 0.6; duration: 1200 }
//                    }
//                }

//                // Основной текст
//                Text {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    text: "СВЯЗЬ С СЕРВЕРОМ\nОТСУТСТВУЕТ"
//                    color: theme.textHighlight
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: 28
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: 3
//                    }
//                    horizontalAlignment: Text.AlignHCenter
//                }

//                // Подтекст
//                Text {
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    text: "ОЖИДАНИЕ ПОДКЛЮЧЕНИЯ..."
//                    color: theme.textHighlight//accentDim
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: 14
//                        letterSpacing: 4
//                    }
//                    horizontalAlignment: Text.AlignHCenter

//                    // Мигание
//                    SequentialAnimation on opacity {
//                        loops: Animation.Infinite
//                        NumberAnimation { to: 0.3; duration: 800 }
//                        NumberAnimation { to: 1.0; duration: 800 }
//                    }
//                }
//            }
//        }
//    }

//    // ПЕРЕИСПОЛЬЗУЕМЫЙ КОМПОНЕНТ ТАКТИЧЕСКОЙ КНОПКИ
//    Component {
//        id: tacticalButton

//        Item {
//            id: btnRoot
//            width: theme.buttonWidth
//            height: theme.buttonHeight

//            property string buttonText: ""
//            property color statusColor: "#7CB342"   // Зелёный статус по умолчанию
//            property bool isActive: false

//            signal clicked()

//            // Основная кнопка
//            Rectangle {
//                id: btnBody
//                anchors.fill: parent
//                radius: theme.buttonRadius
//                color: mouseArea.pressed ? Qt.darker(theme.cardColor, 1.3)
//                                         : (mouseArea.containsMouse ? Qt.lighter(theme.cardColor, 1.2) : theme.cardColor)
//                border.width: mouseArea.containsMouse ? theme.buttonBorderWidth + 1 : theme.buttonBorderWidth
//                border.color: mouseArea.pressed ? theme.textHighlight
//                                                : (mouseArea.containsMouse ? theme.accentColor : theme.accentDim)

//                Behavior on color { ColorAnimation { duration: 150 } }
//                Behavior on border.width { NumberAnimation { duration: 150 } }
//                Behavior on border.color { ColorAnimation { duration: 150 } }

//                // Тактическая скобка — верхний левый угол
//                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
//                    anchors.top: parent.top; anchors.left: parent.left
//                    color: theme.accentColor }
//                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
//                    anchors.top: parent.top; anchors.left: parent.left
//                    color: theme.accentColor }

//                // Тактическая скобка — верхний правый угол
//                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
//                    anchors.top: parent.top; anchors.right: parent.right
//                    color: theme.accentColor }
//                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
//                    anchors.top: parent.top; anchors.right: parent.right
//                    color: theme.accentColor }

//                // Тактическая скобка — нижний левый угол
//                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
//                    anchors.bottom: parent.bottom; anchors.left: parent.left
//                    color: theme.accentColor }
//                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
//                    anchors.bottom: parent.bottom; anchors.left: parent.left
//                    color: theme.accentColor }

//                // Тактическая скобка — нижний правый угол
//                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
//                    anchors.bottom: parent.bottom; anchors.right: parent.right
//                    color: theme.accentColor }
//                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
//                    anchors.bottom: parent.bottom; anchors.right: parent.right
//                    color: theme.accentColor }

//                // Индикатор состояния (мигающая точка)
//                Rectangle {
//                    id: statusDot
//                    width: 8
//                    height: 8
//                    radius: 4
//                    anchors.left: parent.left
//                    anchors.leftMargin: 14
//                    anchors.verticalCenter: parent.verticalCenter
//                    color: btnRoot.statusColor

//                    // Пульсация
//                    SequentialAnimation on opacity {
//                        loops: Animation.Infinite
//                        NumberAnimation { to: 0.3; duration: 800 }
//                        NumberAnimation { to: 1.0; duration: 800 }
//                    }
//                }

//                // Текст кнопки
//                Text {
//                    anchors.left: statusDot.right
//                    anchors.leftMargin: 10
//                    anchors.right: parent.right
//                    anchors.rightMargin: 10
//                    anchors.verticalCenter: parent.verticalCenter

//                    text: btnRoot.buttonText
//                    color: mouseArea.pressed ? theme.textHighlight
//                                             : (mouseArea.containsMouse ? theme.textHighlight : theme.textColor)
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: theme.buttonFontSize
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: 1.2
//                    }
//                    horizontalAlignment: Text.AlignLeft
//                    wrapMode: Text.Wrap

//                    Behavior on color { ColorAnimation { duration: 150 } }
//                }
//            }

//            MouseArea {
//                id: mouseArea
//                anchors.fill: parent
//                hoverEnabled: true
//                cursorShape: Qt.PointingHandCursor
//                onClicked: btnRoot.clicked()
//            }
//        }
//    }

//    SwipeView {
//        id: view
//        visible: tcpClient.connected
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                // === КАРТОЧКА С 3D-МОДЕЛЬЮ ===
//                Rectangle {
//                    id: card
//                    width: parent.width / 2
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cardColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    // Утолщённые тактические скобки по углам
//                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
//                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
//                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
//                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }

//                    Components.ModelViewer {
//                        anchors.fill: parent
//                        anchors.margins: 10
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }

//                // ЗАГОЛОВОК МОДЕЛИ
//                Text {
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .08
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textHighlight
//                    font {
////                        family: theme.fontFamily
//                        pixelSize: theme.titleFontSize
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: theme.letterSpacing
//                    }

//                    layer.enabled: false
//                    layer.effect: Glow {
//                        radius: 4
//                        samples: 12
//                        color: theme.accentColor
//                        transparentBorder: true
//                        opacity: 0.6
//                    }
//                }

//                // СТАТУС-БАР
//                Text {
//                    anchors.top: card.bottom
//                    anchors.topMargin: 15
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: "Состояние: ГОТОВ" +
//                          "  |  Уровень: ПОДЧИНЕННЫЙ" +
//                          "  |  Оргштатка: ЗРБР"
//                    color: theme.accentDim
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: 14
//                        letterSpacing: 1.2
//                        bold: true
//                    }
//                }
//            }
//        }
//    }

//    // ЛЕВАЯ КОЛОНКА КНОПОК
//    Column {
//        id: leftColumn
//        visible: tcpClient.connected
//        anchors.left: parent.left
//        anchors.leftMargin: 40
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 78
//        z: 10

//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "УРОВЕНЬ\nПОДЧИНЕННОСТИ"
//                item.statusColor = "#7CB342"   // Зелёный
//                item.clicked.connect(function() { console.log("▶ Уровень подчиненности") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "ТИП\nИСТОЧНИКА"
//                item.statusColor = "#D4A574"   // Песочный
//                item.clicked.connect(function() { console.log("▶ Тип источника") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "КООРДИНАТЫ"
//                item.statusColor = "#7CB342"   // Зелёный
//                item.clicked.connect(function() { console.log("▶ Координаты") })
//            }
//        }
//    }

//    // ПРАВАЯ КОЛОНКА КНОПОК
//    Column {
//        id: rightColumn
//        visible: tcpClient.connected
//        anchors.right: parent.right
//        anchors.rightMargin: 40
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 78
//        z: 10

//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "ТИП АПД"
//                item.statusColor = "#D4A574"   // Песочный
//                item.clicked.connect(function() { console.log("▶ Тип АПД") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "БОЕГОТОВНОСТЬ"
//                item.statusColor = "#E74C3C"   // Красный — тревога
//                item.clicked.connect(function() { console.log("▶ Боеготовность") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "ВТОРОЙ\nУРОВЕНЬ"
//                item.statusColor = "#7CB342"   // Зелёный
//                item.clicked.connect(function() { console.log("▶ Второй уровень") })
//            }
//        }
//    }

//    // Индикатор КАРУСЕЛЬ
//    Row {
//        id: smartIndicator
//        visible: tcpClient.connected
//        anchors.bottom: view.bottom
//        anchors.bottomMargin: 40
//        anchors.horizontalCenter: parent.horizontalCenter
//        spacing: 8
////        z: 10

//        property int maxVisible: 7
//        property int totalCount: view.count
//        property int currentIdx: view.currentIndex

//        property int startIdx: Math.max(0, Math.min(
//            currentIdx - Math.floor(maxVisible / 2),
//            totalCount - maxVisible
//        ))
//        property int endIdx: Math.min(totalCount, startIdx + maxVisible)

//        Repeater {
//            model: smartIndicator.endIdx - smartIndicator.startIdx

//            delegate: Item {
//                width: realIndex === smartIndicator.currentIdx ? 24 : 16
//                height: 4

//                property int realIndex: smartIndicator.startIdx + index

//                Rectangle {
//                    anchors.fill: parent
//                    radius: 0
//                    color: realIndex === smartIndicator.currentIdx
//                           ? theme.accentColor
//                           : theme.accentDim

//                    Behavior on width {
//                        NumberAnimation { duration: 200; easing.type: Easing.OutQuad }
//                    }
//                    Behavior on color {
//                        ColorAnimation { duration: 250 }
//                    }
//                }

//                MouseArea {
//                    anchors.fill: parent
//                    cursorShape: Qt.PointingHandCursor
//                    onClicked: view.currentIndex = realIndex
//                }
//            }
//        }
//    }

//    // Статусная строка внизу
//    Rectangle {
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.right: parent.right
//        height: 30
//        color: "transparent"//"#22000000"

//        Row {
//            anchors.centerIn: parent
//            spacing: 30

//            Text {
//                text: "СИСТЕМА: " + (tcpClient.connected ? "ОНЛАЙН" : "ОФФЛАЙН")
//                color: tcpClient.connected ? "#7CB342" : "#E74C3C"
//                font { family: theme.fontFamily; pixelSize: 11; bold: true }
//            }
//            Text {
//                text: "ПОТЕРЯ СИГНАЛА: " + (tcpClient.connected ? "НЕТ" : "ДА")
//                color: tcpClient.connected ? "#7CB342" : "#E74C3C"
//                font { family: theme.fontFamily; pixelSize: 11; bold: true }
//            }
//            Text {
//                text: "ВРЕМЯ: " + new Date().toLocaleTimeString()
//                color: theme.accentDim
//                font { family: theme.fontFamily; pixelSize: 11; bold: true }
//            }
//        }
//    }
//}
