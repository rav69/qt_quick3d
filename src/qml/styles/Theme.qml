import QtQuick 2.15

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
