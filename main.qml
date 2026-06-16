// Variant 3 с кнопками
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import QtGraphicalEffects 1.15

Window {
    id: window
    visible: true
    width: 960
    height: 600
    title: qsTr("FIELD OPS MODEL VIEWER v3.0")
    color: theme.bgColor

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

    // DESERT OPS THEME
    QtObject {
        id: theme

        // Цветовая палитра
        property color bgColor:         "#1C1814"
        property color cardColor:       "#A000BFFF"
        property color accentColor:     "#D4A574"
        property color accentDim:       "#8B7355"
        property color warningColor:    "#E74C3C"
        property color textColor:       "#E8DCC4"
        property color textHighlight:   "#F4C983"

        // Типографика
        property string fontFamily:     "Tahoma"
        property int textBaseFontSize:  26
        property int titleFontSize:     32
        property real letterSpacing:    1.5

        // Карточка
        property int cartRadius:        0
        property int cartBorderWidth:   2
        property color cartBorderColor: accentDim

        // Свойства для кнопок
        property int buttonWidth:       170
        property int buttonHeight:      48
        property int buttonFontSize:    12
        property int buttonRadius:      0       // Прямые углы — military style
        property int buttonBorderWidth: 2       // Утолщённая рамка
        property int cornerMarkSize:    12      // Размер тактических скобок
        property int cornerMarkThick:   2       // Толщина скобок
    }

    // ПЕРЕИСПОЛЬЗУЕМЫЙ КОМПОНЕНТ ТАКТИЧЕСКОЙ КНОПКИ
    Component {
        id: tacticalButton

        Item {
            id: btnRoot
            width: theme.buttonWidth
            height: theme.buttonHeight

            property string buttonText: ""
            property color statusColor: "#7CB342"   // Зелёный статус по умолчанию
            property bool isActive: false

            signal clicked()

            // Основная кнопка
            Rectangle {
                id: btnBody
                anchors.fill: parent
                radius: theme.buttonRadius
                color: mouseArea.pressed ? Qt.darker(theme.cardColor, 1.3)
                                         : (mouseArea.containsMouse ? Qt.lighter(theme.cardColor, 1.2) : theme.cardColor)
                border.width: mouseArea.containsMouse ? theme.buttonBorderWidth + 1 : theme.buttonBorderWidth
                border.color: mouseArea.pressed ? theme.textHighlight
                                                : (mouseArea.containsMouse ? theme.accentColor : theme.accentDim)

                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on border.width { NumberAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }

                // Тактическая скобка — верхний левый угол
                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
                    anchors.top: parent.top; anchors.left: parent.left
                    color: theme.accentColor }
                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
                    anchors.top: parent.top; anchors.left: parent.left
                    color: theme.accentColor }

                // Тактическая скобка — верхний правый угол
                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
                    anchors.top: parent.top; anchors.right: parent.right
                    color: theme.accentColor }
                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
                    anchors.top: parent.top; anchors.right: parent.right
                    color: theme.accentColor }

                // Тактическая скобка — нижний левый угол
                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
                    anchors.bottom: parent.bottom; anchors.left: parent.left
                    color: theme.accentColor }
                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
                    anchors.bottom: parent.bottom; anchors.left: parent.left
                    color: theme.accentColor }

                // Тактическая скобка — нижний правый угол
                Rectangle { width: theme.cornerMarkSize; height: theme.cornerMarkThick
                    anchors.bottom: parent.bottom; anchors.right: parent.right
                    color: theme.accentColor }
                Rectangle { width: theme.cornerMarkThick; height: theme.cornerMarkSize
                    anchors.bottom: parent.bottom; anchors.right: parent.right
                    color: theme.accentColor }

                // Индикатор состояния (мигающая точка)
                Rectangle {
                    id: statusDot
                    width: 8
                    height: 8
                    radius: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    color: btnRoot.statusColor

                    // Пульсация
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { to: 0.3; duration: 800 }
                        NumberAnimation { to: 1.0; duration: 800 }
                    }
                }

                // Текст кнопки
                Text {
                    anchors.left: statusDot.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    text: btnRoot.buttonText
                    color: mouseArea.pressed ? theme.textHighlight
                                             : (mouseArea.containsMouse ? theme.textHighlight : theme.textColor)
                    font {
                        family: theme.fontFamily
                        pixelSize: theme.buttonFontSize
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
    }

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent

        Repeater {
            model: pagesConfig

            delegate: Item {
                // === КАРТОЧКА С 3D-МОДЕЛЬЮ ===
                Rectangle {
                    id: card
                    width: parent.width / 2
                    height: parent.height / 2
                    anchors.centerIn: parent
                    color: theme.cardColor
                    radius: theme.cartRadius
                    border.width: theme.cartBorderWidth
                    border.color: theme.cartBorderColor

                    // Утолщённые тактические скобки по углам
                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.left: parent.left; color: theme.accentColor }
                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.right: parent.right; color: theme.accentColor }
                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.left: parent.left; color: theme.accentColor }
                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }
                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.right: parent.right; color: theme.accentColor }

                    ModelViewer {
                        anchors.fill: parent
                        anchors.margins: 10
                        modelName: nameModels[modelData.modelIndex][1]
                        modelScale: nameModels[modelData.modelIndex][2]
                        rotationDuration: modelData.rotationDuration
                        cameraPosition: modelData.cameraPosition
                    }
                }

                // ЗАГОЛОВОК МОДЕЛИ
                Text {
                    anchors.bottom: card.top
                    anchors.bottomMargin: parent.height * .08
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: nameModels[modelData.modelIndex][0]
                    color: theme.textHighlight
                    font {
//                        family: theme.fontFamily
                        pixelSize: theme.titleFontSize
                        bold: true
                        capitalization: Font.AllUppercase
                        letterSpacing: theme.letterSpacing
                    }

                    layer.enabled: false
                    layer.effect: Glow {
                        radius: 4
                        samples: 12
                        color: theme.accentColor
                        transparentBorder: true
                        opacity: 0.6
                    }
                }

                // СТАТУС-БАР
                Text {
                    anchors.top: card.bottom
                    anchors.topMargin: 15
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: "Состояние: ГОТОВ" +
                          "  |  Уровень: ПОДЧИНЕННЫЙ" +
                          "  |  Оргштатка: ЗРБР"
                    color: theme.accentDim
                    font {
                        family: theme.fontFamily
                        pixelSize: 14
                        letterSpacing: 1.2
                        bold: true
                    }
                }
            }
        }
    }

    // ЛЕВАЯ КОЛОНКА КНОПОК
    Column {
        id: leftColumn
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        spacing: 78
        z: 10

        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "УРОВЕНЬ\nПОДЧИНЕННОСТИ"
                item.statusColor = "#7CB342"   // Зелёный
                item.clicked.connect(function() { console.log("▶ Уровень подчиненности") })
            }
        }
        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "ТИП\nИСТОЧНИКА"
                item.statusColor = "#D4A574"   // Песочный
                item.clicked.connect(function() { console.log("▶ Тип источника") })
            }
        }
        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "КООРДИНАТЫ"
                item.statusColor = "#7CB342"   // Зелёный
                item.clicked.connect(function() { console.log("▶ Координаты") })
            }
        }
    }

    // ПРАВАЯ КОЛОНКА КНОПОК
    Column {
        id: rightColumn
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.verticalCenter: parent.verticalCenter
        spacing: 78
        z: 10

        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "ТИП АПД"
                item.statusColor = "#D4A574"   // Песочный
                item.clicked.connect(function() { console.log("▶ Тип АПД") })
            }
        }
        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "БОЕГОТОВНОСТЬ"
                item.statusColor = "#E74C3C"   // Красный — тревога
                item.clicked.connect(function() { console.log("▶ Боеготовность") })
            }
        }
        Loader {
            sourceComponent: tacticalButton
            onLoaded: {
                item.buttonText = "ВТОРОЙ\nУРОВЕНЬ"
                item.statusColor = "#7CB342"   // Зелёный
                item.clicked.connect(function() { console.log("▶ Второй уровень") })
            }
        }
    }

    Row {
        id: smartIndicator
        anchors.bottom: view.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        z: 10

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
                           ? theme.accentColor
                           : theme.accentDim

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




// Мой вариант 1
//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("Qt 5.15.2 GLB Model Loader")
//    color: "transparent"

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
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 }
//    ]

//    QtObject {
//        id: theme
//        property int textBaseFontSize: 28
//        property color textColor: "white"
//        property int cartRadius: 10
//        property int cartBorderWidth: 1
//        property color cartBorderColor: "lightblue"
//        property color cartColor: "#A000BFFF"

//        // === Свойства для кнопок ===
//        property int buttonWidth: 120
//        property int buttonHeight: 42
//        property int buttonFontSize: 12
//        property int buttonRadius: 6
//    }

//    // === Переиспользуемый компонент кнопки ===
//    Component {
//        id: tacticalButton
//        Rectangle {
//            id: btnRoot
//            width: theme.buttonWidth
//            height: theme.buttonHeight
//            radius: theme.buttonRadius

//            // Свойства кнопки
//            property string buttonText: ""
//            property alias isHovered: mouseArea.containsMouse
//            property alias isPressed: mouseArea.pressed

//            signal clicked()

//            // Динамический цвет в зависимости от состояния
//            color: isPressed ? "#D000BFFF" : (isHovered ? "#C000BFFF" : theme.cartColor)
//            border.width: isHovered ? 2 : theme.cartBorderWidth
//            border.color: isHovered ? "white" : theme.cartBorderColor

//            // Плавные переходы состояний
//            Behavior on color { ColorAnimation { duration: 150 } }
//            Behavior on border.width { NumberAnimation { duration: 150 } }
//            Behavior on border.color { ColorAnimation { duration: 150 } }

//            // Эффект свечения при наведении
//            layer.enabled: isHovered
//            layer.effect: ShaderEffectSource {
//                sourceItem: Rectangle {
//                    width: btnRoot.width
//                    height: btnRoot.height
//                    radius: btnRoot.radius
//                    color: "transparent"
//                    border.width: 1
//                    border.color: theme.cartBorderColor
//                    opacity: 0.6
//                }
//                hideSource: true
//            }

//            Text {
//                anchors.centerIn: parent
//                text: btnRoot.buttonText
//                color: isPressed ? "lightblue" : theme.textColor
//                font {
//                    family: "Courier New"
//                    pixelSize: theme.buttonFontSize
//                    bold: isHovered
//                    capitalization: Font.AllUppercase
//                    letterSpacing: 0.8
//                }
//                Behavior on color { ColorAnimation { duration: 150 } }
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
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cartColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    ModelViewer {
//                        anchors.fill: parent
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }
//                Text {
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .1
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textColor
//                    font.pixelSize: theme.textBaseFontSize
//                    font.bold: true
//                    font.letterSpacing: 1.5
//                }
//            }
//        }
//    }

//    // === ЛЕВАЯ КОЛОНКА КНОПОК ===
//    Column {
//        id: leftColumn
//        anchors.left: parent.left
//        anchors.leftMargin: 20
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 15
//        z: 10  // Поверх всего

//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Уровень\nподчиненности"
//                item.clicked.connect(function() { console.log("Clicked: Уровень подчиненности") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Тип\nисточника"
//                item.clicked.connect(function() { console.log("Clicked: Тип источника") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Координаты"
//                item.clicked.connect(function() { console.log("Clicked: Координаты") })
//            }
//        }
//    }

//    // === ПРАВАЯ КОЛОНКА КНОПОК ===
//    Column {
//        id: rightColumn
//        anchors.right: parent.right
//        anchors.rightMargin: 20
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 15
//        z: 10  // Поверх всего

//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Тип АПД"
//                item.clicked.connect(function() { console.log("Clicked: Тип АПД") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Боеготовность"
//                item.clicked.connect(function() { console.log("Clicked: Боеготовность") })
//            }
//        }
//        Loader {
//            sourceComponent: tacticalButton
//            onLoaded: {
//                item.buttonText = "Второй\nуровень"
//                item.clicked.connect(function() { console.log("Clicked: Второй уровень") })
//            }
//        }
//    }

//    PageIndicator {
//        id: indicator
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: view.bottom
//        anchors.bottomMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter

//        delegate: Rectangle {
//            implicitWidth: 12
//            implicitHeight: 3
//            radius: 1
//            color: indicator.currentIndex === index ? theme.cartBorderColor : Qt.rgba(0.7, 0.7, 1, 0.3)
//            Behavior on color { ColorAnimation { duration: 200 } }
//        }
//    }
//}


// Мой вариант 2
//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("Qt 5.15.2 GLB Model Loader")
//    color: "#0A0E0A"  // Тёмный фон, чтобы полупрозрачный голубой читался

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
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 }
//    ]

//    QtObject {
//        id: theme
//        property int textBaseFontSize: 28
//        property color textColor: "white"
//        property int cartRadius: 10
//        property int cartBorderWidth: 1
//        property color cartBorderColor: "lightblue"
//        property color cartColor: "#A000BFFF"

//        // === Стили для кнопок ===
//        property int buttonWidth: 220
//        property int buttonHeight: 45
//        property int buttonRadius: 10
//        property int buttonBorderWidth: 1
//        property color buttonColor: "#A000BFFF"
//        property color buttonBorderColor: "lightblue"
//        property color buttonHoverColor: "#C000DFFF"   // Светлее при наведении
//        property color buttonPressedColor: "#80009FDF" // Темнее при нажатии
//        property int buttonFontSize: 14
//    }

//    SwipeView {
//        id: view
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cartColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    ModelViewer {
//                        anchors.fill: parent
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }

//                Text {
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .1
//                    anchors.horizontalCenter: parent.horizontalCenter
//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textColor
//                    font.pixelSize: theme.textBaseFontSize
//                    font.bold: true
//                    font.letterSpacing: 1.5
//                }
//            }
//        }
//    }

//    PageIndicator {
//        id: indicator
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: view.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }

//    // ============================================================
//    // === КНОПКИ: ЛЕВАЯ СТОРОНА (3 кнопки вертикально) ===
//    // ============================================================
//    Column {
//        id: leftButtons
//        anchors.left: parent.left
//        anchors.leftMargin: 20
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 15
//        z: 10  // Поверх SwipeView

//        MilitaryButton { text: "Уровень подчиненности" }
//        MilitaryButton { text: "Тип источника" }
//        MilitaryButton { text: "Координаты" }
//    }

//    // ============================================================
//    // === КНОПКИ: ПРАВАЯ СТОРОНА (3 кнопки вертикально) ===
//    // ============================================================
//    Column {
//        id: rightButtons
//        anchors.right: parent.right
//        anchors.rightMargin: 20
//        anchors.verticalCenter: parent.verticalCenter
//        spacing: 15
//        z: 10

//        MilitaryButton { text: "Тип АПД" }
//        MilitaryButton { text: "Боеготовность" }
//        MilitaryButton { text: "Второй уровень" }
//    }

//    // ============================================================
//    // === КОМПОНЕНТ КНОПКИ (inline, в стиле карточки) ===
//    // ============================================================
//    component MilitaryButton: Rectangle {
//        id: btn
//        width: theme.buttonWidth
//        height: theme.buttonHeight
//        radius: theme.buttonRadius
//        color: mouseArea.pressed ? theme.buttonPressedColor
//                                 : (mouseArea.containsMouse ? theme.buttonHoverColor : theme.buttonColor)
//        border.width: theme.buttonBorderWidth
//        border.color: theme.buttonBorderColor

//        property string text: ""

//        // Плавная анимация смены цвета
//        Behavior on color {
//            ColorAnimation { duration: 150 }
//        }

//        Text {
//            anchors.centerIn: parent
//            text: btn.text
//            color: theme.textColor
//            font.pixelSize: theme.buttonFontSize
//            font.bold: true
//            font.letterSpacing: 1.0
//            font.capitalization: Font.AllUppercase
//        }

//        MouseArea {
//            id: mouseArea
//            anchors.fill: parent
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                console.log("Button clicked:", btn.text)
//                // Здесь будет логика обработки клика
//            }
//        }
//    }
//}




// Variant 3

//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15
//import QtGraphicalEffects 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("FIELD OPS MODEL VIEWER v3.0")
//    color: theme.bgColor

//    // === ДАННЫЕ МОДЕЛЕЙ ===
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
//        { modelIndex: 8, cameraPosition: Qt.vector3d(0, 15, 90),  rotationDuration: 8000 }
//    ]

//    // === DESERT OPS THEME ===
//    QtObject {
//        id: theme

//        // Цветовая палитра (Песок, Хаки, Тёмная земля)
//        property color bgColor:         "#1C1814"       // Тёмно-коричневый/угольный
//        property color cardColor:       "#A000BFFF"//"#2A241E"       // Тёмный хаки
//        property color accentColor:     "#D4A574"       // Песочный (основной акцент)
//        property color accentDim:       "#8B7355"       // Приглушённый хаки (рамки, второстепенный текст)
//        property color warningColor:    "#E74C3C"       // Кирпично-красный (тревога)
//        property color textColor:       "#E8DCC4"       // Светлый песок (основной текст)
//        property color textHighlight:   "#F4C983"       // Яркий песочный/золотистый (заголовки)

//        // Типографика
//        property string fontFamily:     "Courier New"   // Моноширинный (или "Liberation Mono" в Astra)
//        property int textBaseFontSize:  26
//        property int titleFontSize:     32
//        property real letterSpacing:    1.5

//        // Карточка (Rugged / Защищённый стиль)
//        property int cartRadius:        0               // Абсолютно прямые, жёсткие углы
//        property int cartBorderWidth:   2               // Утолщённая рамка
//        property color cartBorderColor: accentDim
//    }

//    SwipeView {
//        id: view
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                // === КАРТОЧКА С 3D-МОДЕЛЬЮ ===
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cardColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    // Утолщённые тактические скобки по углам (эффект защищённого корпуса)
//                    // Верхний левый
//                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 0; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.left: parent.left; anchors.margins: 0; color: theme.accentColor }

//                    // Верхний правый
//                    Rectangle { width: 25; height: 3; anchors.top: parent.top; anchors.right: parent.right; anchors.margins: 0; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.top: parent.top; anchors.right: parent.right; anchors.margins: 0; color: theme.accentColor }

//                    // Нижний левый
//                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.margins: 0; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.margins: 0; color: theme.accentColor }

//                    // Нижний правый
//                    Rectangle { width: 25; height: 3; anchors.bottom: parent.bottom; anchors.right: parent.right; anchors.margins: 0; color: theme.accentColor }
//                    Rectangle { width: 3; height: 25; anchors.bottom: parent.bottom; anchors.right: parent.right; anchors.margins: 0; color: theme.accentColor }

//                    ModelViewer {
//                        anchors.fill: parent
//                        anchors.margins: 10 // Небольшой отступ от рамок
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }

//                // === ЗАГОЛОВОК МОДЕЛИ (Трафаретный стиль) ===
//                Text {
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .08
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textHighlight
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: theme.titleFontSize
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: theme.letterSpacing
//                    }

//                    // Тёплое, сдержанное свечение (как подсветка полевого дисплея)
//                    layer.enabled: true
//                    layer.effect: Glow {
//                        radius: 4
//                        samples: 12
//                        color: theme.accentColor
//                        transparentBorder: true
//                        opacity: 0.6
//                    }
//                }

//                // === ПОЛЕВОЙ СТАТУС-БАР ===
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

//    PageIndicator {
//        id: indicator
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: view.bottom
//        anchors.bottomMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter

//        // Стилизация индикатора в виде полевых меток
//        delegate: Rectangle {
//            implicitWidth: 16
//            implicitHeight: 4
//            radius: 0 // Прямые углы
//            color: indicator.currentIndex === index ? theme.accentColor : theme.accentDim

//            Behavior on color {
//                ColorAnimation { duration: 250 }
//            }
//        }
//    }

//    // === ЭФФЕКТ ПОЛЕВОГО ОГРАНИЧЕНИЯ (Виньетка) ===
//    // Создаёт ощущение, что мы смотрим через линзу или на защищённый экран
//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"
//        z: 999
//        visible: true

//        // Градиент по краям для затемнения
//        border.color: theme.bgColor
//        border.width: 40

//        layer.enabled: true
//        layer.effect: OpacityMask {
//            maskSource: Item {
//                width: window.width
//                height: window.height
//                Rectangle {
//                    anchors.fill: parent
//                    color: "black"
//                    radius: 0
//                }
//            }
//        }
//    }
//}


// Variant 2
//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15
//import QtGraphicalEffects 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("STEALTH MODEL VIEWER v2.0")
//    color: theme.bgColor

//    // === ДАННЫЕ МОДЕЛЕЙ ===
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
//        {
//            modelIndex: 0,
//            cameraPosition: Qt.vector3d(0, 25, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 1,
//            cameraPosition: Qt.vector3d(0, 10, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 3,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 4,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 5,
//            cameraPosition: Qt.vector3d(0, 0, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 7,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 8,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        }
//    ]

//    // === STEALTH THEME ===
//    QtObject {
//        id: theme

//        // Цветовая палитра
//        property color bgColor:         "#0D1117"       // Тёмно-синий графит
//        property color cardColor:       "#161B22"       // Стальной графит
//        property color accentColor:     "#58A6FF"       // Холодный синий (стелс-радар)
//        property color accentDim:       "#1F6FEB"       // Приглушённый синий
//        property color warningColor:    "#F85149"       // Красный (тревога)
//        property color textColor:       "#C9D1D9"       // Светло-серый
//        property color textHighlight:   "#58A6FF"       // Яркий синий

//        // Типографика
//        property string fontFamily:     "Courier New"   // Моноширинный (есть в Astra Linux)
//        property int textBaseFontSize:  26
//        property int titleFontSize:     32
//        property real letterSpacing:    1.5

//        // Карточка
//        property int cartRadius:        4               // Слегка скруглённые углы
//        property int cartBorderWidth:   1
//        property color cartBorderColor: accentDim
//    }

//    SwipeView {
//        id: view
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                // === КАРТОЧКА С 3D-МОДЕЛЬЮ ===
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cardColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    // Минималистичные тактические метки по углам
//                    // Верхний левый угол
//                    Rectangle {
//                        width: 15; height: 1
//                        anchors.top: parent.top
//                        anchors.left: parent.left
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }
//                    Rectangle {
//                        width: 1; height: 15
//                        anchors.top: parent.top
//                        anchors.left: parent.left
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }

//                    // Верхний правый угол
//                    Rectangle {
//                        width: 15; height: 1
//                        anchors.top: parent.top
//                        anchors.right: parent.right
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }
//                    Rectangle {
//                        width: 1; height: 15
//                        anchors.top: parent.top
//                        anchors.right: parent.right
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }

//                    // Нижний левый угол
//                    Rectangle {
//                        width: 15; height: 1
//                        anchors.bottom: parent.bottom
//                        anchors.left: parent.left
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }
//                    Rectangle {
//                        width: 1; height: 15
//                        anchors.bottom: parent.bottom
//                        anchors.left: parent.left
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }

//                    // Нижний правый угол
//                    Rectangle {
//                        width: 15; height: 1
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }
//                    Rectangle {
//                        width: 1; height: 15
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right
//                        anchors.margins: 8
//                        color: theme.accentColor
//                        opacity: 0.7
//                    }

//                    ModelViewer {
//                        anchors.fill: parent
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }

//                // === ЗАГОЛОВОК МОДЕЛИ (с синим свечением) ===
//                Text {
//                    id: titleText
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .1
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textHighlight
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: theme.titleFontSize
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: theme.letterSpacing
//                    }

//                    layer.enabled: true
//                    layer.effect: Glow {
//                        radius: 8
//                        samples: 24
//                        color: theme.accentColor
//                        transparentBorder: true
//                    }
//                }

//                // === СТАТУС-БАР С ТАКТИЧЕСКИМИ ДАННЫМИ ===
//                Text {
//                    anchors.top: card.bottom
//                    anchors.topMargin: 15
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: "ID: " + (modelData.modelIndex + 1).toString().padStart(3, '0') +
//                          "  |  TYPE: " +
//                          (modelData.modelIndex < 3 ? "AIRCRAFT" : "GROUND UNIT") +
//                          "  |  SCALE: " + nameModels[modelData.modelIndex][2].toFixed(2)
//                    color: theme.accentDim
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: 13
//                        letterSpacing: 1.2
//                    }
//                }
//            }
//        }
//    }

//    PageIndicator {
//        id: indicator
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: view.bottom
//        anchors.bottomMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter

//        // Стилизация индикатора в stealth стиле
//        delegate: Rectangle {
//            implicitWidth: 20
//            implicitHeight: 2
//            radius: 1
//            color: indicator.currentIndex === index ? theme.accentColor : theme.accentDim
//            opacity: indicator.currentIndex === index ? 1.0 : 0.5

//            Behavior on color {
//                ColorAnimation { duration: 300 }
//            }
//            Behavior on opacity {
//                NumberAnimation { duration: 300 }
//            }
//        }
//    }

//    // === ЭФФЕКТ СКАНЛАЙНОВ (опционально) ===
//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"
//        opacity: 0.02
//        z: 999
//        visible: false  // Установите true для эффекта CRT

//        Repeater {
//            model: parent.height / 4
//            Rectangle {
//                width: parent.width
//                height: 1
//                y: index * 4
//                color: theme.accentColor
//            }
//        }
//    }
//}




// Variant 1
//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15
//import QtGraphicalEffects 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("TACTICAL MODEL VIEWER v1.0")
//    color: theme.bgColor

//    // === ДАННЫЕ МОДЕЛЕЙ ===
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
//        {
//            modelIndex: 0,
//            cameraPosition: Qt.vector3d(0, 25, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 1,
//            cameraPosition: Qt.vector3d(0, 10, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 3,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 4,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 5,
//            cameraPosition: Qt.vector3d(0, 0, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 7,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 8,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        }
//    ]

//    // === TACTICAL HUD THEME ===
//    QtObject {
//        id: theme

//        // Цветовая палитра
//        property color bgColor:         "#0A0E0A"       // Почти чёрный с зелёным оттенком
//        property color cardColor:       "#A000BFFF"//"#1A1F1A"       // Тёмно-графитовый
//        property color accentColor:     "#00FF41"       // Ярко-зелёный (HUD-свечение)
//        property color accentDim:       "#00FF41"//"#3A5F3A"       // Приглушённый зелёный
//        property color warningColor:    "#FFB000"       // Янтарный (для предупреждений)
//        property color textColor:       "#B8FFB8"       // Светло-зелёный текст
//        property color textHighlight:   "#00FF41"       // Яркий зелёный для заголовков

//        // Типографика
//        property string fontFamily:     "Courier New"   // Моноширинный
//        property int textBaseFontSize:  26
//        property int titleFontSize:     32
//        property real letterSpacing:    2.0             // Разреженные буквы

//        // Карточка
//        property int cartRadius:        2               // Почти острые углы
//        property int cartBorderWidth:   2
//        property color cartBorderColor: accentDim
//    }

//    SwipeView {
//        id: view
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                // === КАРТОЧКА С 3D-МОДЕЛЬЮ ===
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cardColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    // Тактические метки по углам (верхний левый)
//                    Rectangle {
//                        width: 20; height: 2
//                        anchors.top: parent.top
//                        anchors.left: parent.left
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }
//                    Rectangle {
//                        width: 2; height: 20
//                        anchors.top: parent.top
//                        anchors.left: parent.left
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }

//                    // Верхний правый угол
//                    Rectangle {
//                        width: 20; height: 2
//                        anchors.top: parent.top
//                        anchors.right: parent.right
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }
//                    Rectangle {
//                        width: 2; height: 20
//                        anchors.top: parent.top
//                        anchors.right: parent.right
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }

//                    // Нижний левый угол
//                    Rectangle {
//                        width: 20; height: 2
//                        anchors.bottom: parent.bottom
//                        anchors.left: parent.left
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }
//                    Rectangle {
//                        width: 2; height: 20
//                        anchors.bottom: parent.bottom
//                        anchors.left: parent.left
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }

//                    // Нижний правый угол
//                    Rectangle {
//                        width: 20; height: 2
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }
//                    Rectangle {
//                        width: 2; height: 20
//                        anchors.bottom: parent.bottom
//                        anchors.right: parent.right
//                        anchors.margins: 5
//                        color: theme.accentColor
//                    }

//                    ModelViewer {
//                        anchors.fill: parent
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }

//                // === ЗАГОЛОВОК МОДЕЛИ (с эффектом свечения) ===
//                Text {
//                    id: titleText
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .1
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]
//                    color: theme.textHighlight
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: theme.titleFontSize
//                        bold: true
//                        capitalization: Font.AllUppercase
//                        letterSpacing: theme.letterSpacing
//                    }

//                    layer.enabled: true
//                    layer.effect: Glow {
//                        radius: 6
//                        samples: 20
//                        color: theme.accentColor
//                        transparentBorder: true
//                    }
//                }

//                // === СТАТУС-БАР С ТАКТИЧЕСКИМИ ДАННЫМИ ===
//                Text {
//                    anchors.top: card.bottom
//                    anchors.topMargin: 15
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: "STATUS: ACTIVE  |  CLASS: " +
//                          (modelData.modelIndex < 3 ? "AIRBORNE" : "GROUND") +
//                          "  |  THREAT: " +
//                          (nameModels[modelData.modelIndex][2] > 10 ? "HIGH" : "MEDIUM")
//                    color: theme.accentDim
//                    font {
//                        family: theme.fontFamily
//                        pixelSize: 14
//                        letterSpacing: 1.5
//                    }
//                }
//            }
//        }
//    }

//    PageIndicator {
//        id: indicator
//        count: view.count
//        currentIndex: view.currentIndex
//        anchors.bottom: view.bottom
//        anchors.bottomMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter

//        // Стилизация индикатора в military стиле
//        delegate: Rectangle {
//            implicitWidth: 12
//            implicitHeight: 3
//            radius: 0  // Острые углы
//            color: indicator.currentIndex === index ? theme.accentColor : theme.accentDim

//            Behavior on color {
//                ColorAnimation { duration: 200 }
//            }
//        }
//    }

//    // === ЭФФЕКТ СКАНЛАЙНОВ (опционально) ===
//    Rectangle {
//        anchors.fill: parent
//        color: "transparent"
//        opacity: 0.03
//        z: 999
//        visible: true  // Установите false, если не нужен эффект

//        Repeater {
//            model: parent.height / 3
//            Rectangle {
//                width: parent.width
//                height: 1
//                y: index * 3
//                color: theme.accentColor
//            }
//        }
//    }
//}

// Variant original

//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15
//import QtQuick3D 1.15

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("Qt 5.15.2 GLB Model Loader")
//    color: "transparent"

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
//        {
//            modelIndex: 0,
//            cameraPosition: Qt.vector3d(0, 25, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 1,
//            cameraPosition: Qt.vector3d(0, 10, 150),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 3,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 4,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 5,
//            cameraPosition: Qt.vector3d(0, 0, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 7,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        },
//        {
//            modelIndex: 8,
//            cameraPosition: Qt.vector3d(0, 15, 90),
//            rotationDuration: 8000
//        }
//    ]

//    QtObject {
//        id: theme
//        property int textBaseFontSize: 28
//        property color textColor: "white"
//        property int cartRadius: 10
//        property int cartBorderWidth: 1
//        property color cartBorderColor: "lightblue"
//        property color cartColor: "#A000BFFF"
//    }

//    SwipeView {
//        id: view
//        currentIndex: 0
//        anchors.fill: parent

//        Repeater {
//            model: pagesConfig

//            delegate: Item {
//                Rectangle {
//                    id: card
//                    width: parent.width / 1.5
//                    height: parent.height / 2
//                    anchors.centerIn: parent
//                    color: theme.cartColor
//                    radius: theme.cartRadius
//                    border.width: theme.cartBorderWidth
//                    border.color: theme.cartBorderColor

//                    ModelViewer {
//                        anchors.fill: parent
//                        modelName: nameModels[modelData.modelIndex][1]
//                        modelScale: nameModels[modelData.modelIndex][2]
//                        rotationDuration: modelData.rotationDuration
//                        cameraPosition: modelData.cameraPosition
//                    }
//                }
//                Text {
////                    anchors.top: card.bottom
////                    anchors.topMargin: 20
////                    anchors.horizontalCenter: parent.horizontalCenter
//                    anchors.bottom: card.top
//                    anchors.bottomMargin: parent.height * .1
//                    anchors.horizontalCenter: parent.horizontalCenter

//                    text: nameModels[modelData.modelIndex][0]  // Динамическое имя
//                    color: theme.textColor
//                    font.pixelSize: theme.textBaseFontSize
//                    font.bold: true
//                    font.letterSpacing: 1.5  // Бонус: межбуквенный интервал для красоты
//                }

//            }
//        }

//    }

//    PageIndicator {
//        id: indicator

//        count: view.count
//        currentIndex: view.currentIndex

//        anchors.bottom: view.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//    }
//}
