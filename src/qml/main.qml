// ============================================================
// src/qml/main.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import ThemeModule 1.0

import "pages" as Pages
import "components" as Components

ApplicationWindow {
    id: root
    visible: root.ready
    width: 960
    height: width * .625
    title: qsTr("Qt 5.15.2 GLB Model Loader")
    color: Theme.bgColor

    property bool ready: false

    function openMenuItem(index, page) {
        switch(index) {
        case 0:
            root.updatePage(false)
            break
        case 1:
            root.pushPageGroup(page)
            break
        case 2:
            root.pushPageAlgo(page)
            break
        case 3:
            root.pushPageEmpty(page)
            break
        default:
            break
        }
    }

    function updatePage(connected) {
        if (!connected) {
            while (mainStack.depth > 1) {
                mainStack.pop()
            }
        }
    }

    function pushPageGroup(url) {
        var state = mainStack.push(url)
        state.backGroup.connect(back)
        state.getFilesGroup.connect(getFilesGroup)
//        state.uploadGroup.connect(uploadGroup)
        state.deleteGroup.connect(deleteGroup)
        state.saveGroup.connect(saveGroup)
    }

    function pushPageAlgo(url) {
        var state = mainStack.push(url)
        state.backAlgo.connect(back)
    }

    function pushPageEmpty(url) {
        var state = mainStack.push(url)
        state.backEmpty.connect(back)
    }

    function back() {
        mainStack.pop()
    }

    function getFilesGroup() {
        console.log("getFilesGroup")
        tcpClient.sendGetGroupingFiles()
    }

    function uploadGroup() {
        console.log("uploadGroup")
    }

    function deleteGroup() {
        console.log("deleteGroup")
    }

    function saveGroup() {
        console.log("saveGroup")
    }

    Component.onCompleted: {
        console.log("ROOT completed, setting ready = true")
        root.ready = true

        tcpClient.connectionStatusChanged.connect(updatePage)
    }


    // ─── STACKVIEW (main content container) ──────────────────
    StackView {
        id: mainStack
        anchors.fill: parent

        // Начальная страница
        initialItem: {
            Qt.createComponent("qrc:/qml/pages/MapPage.qml").createObject(mainStack)
        }
    }

    // ─── DRAWER (LEFT MENU) ──────────────────────────────────
    Drawer {
        id: menuDrawer
        width: root.width * .3
        height: root.height
        edge: Qt.LeftEdge
        modal: true
        dim: true
        closePolicy: Drawer.CloseOnPressOutsideParent

        background: Rectangle {
            color: Theme.bgColor
            border.color: Theme.accentDim
            border.width: 1
        }

        Column {
            anchors.fill: parent
            spacing: 0

            Column {
                id: menuItems
                width: menuDrawer.width
                spacing: 0

                Repeater {
                    model: [
                        { name: "Главный экран", page: "MapPage.qml" },
                        { name: "Группировка", page: "GroupingPage.qml" },
//                        { name: "Группировка", page: "GroupingFirstPage.qml" },
                        { name: "Алгоритмы", page: "AlgorithmsPage.qml" },
                        { name: "Заглушка", page: "Empty.qml" }
                    ]

                    delegate: Item {
                        width: menuDrawer.width
                        height: 50

                        Rectangle {
                            anchors.fill: parent
                            color: mouseArea.containsMouse ? Theme.accentColor : "transparent"
                            opacity: mouseArea.containsMouse ? 0.2 : 0
                            Behavior on opacity { NumberAnimation { duration: 150 } }
                        }

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.name
                            color: Theme.textColor
                            font {
                                family: Theme.fontFamily
                                pixelSize: 14
                                bold: true
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("▶ Selected:", modelData.name)
                                menuDrawer.close()
//                                if (modelData.name === "Главный экран") updatePage(false)
//                                else root.pushPage("qrc:/qml/pages/" + modelData.page)
                                root.openMenuItem(index, "qrc:/qml/pages/" + modelData.page)
                            }
                        }

                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 1
                            color: Theme.accentDim
                            opacity: 0.3
                        }
                    }
                }
            }

            Item {
                width: menuDrawer.width
                height: parent.height - menuItems.height - 51
            }

            Rectangle {
                width: menuDrawer.width
                height: 1
                color: Theme.accentDim
                opacity: 0.5
            }

            Item {
                width: menuDrawer.width
                height: 50

                Rectangle {
                    anchors.fill: parent
                    color: mouseAreaClose.containsMouse ? Theme.warningColor : "transparent"
                    opacity: mouseAreaClose.containsMouse ? 0.2 : 0
                    Behavior on opacity { NumberAnimation { duration: 150 } }
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    text: "✕ СКРЫТЬ"
                    color: Theme.textHighlight
                    font {
                        family: Theme.fontFamily
                        pixelSize: 14
                        bold: true
                    }
                }

                MouseArea {
                    id: mouseAreaClose
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log(mainStack.depth)
                        menuDrawer.close()
                    }
                }
            }
        }
    }

    // ─── MENU TOGGLE BUTTON ──────────────────────────────────
    Rectangle {
        id: menuButton
        visible: mainStack.depth === 1 && tcpClient.connected
        width: root.width * .04
        height: menuButton.width
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: menuButton.width
        anchors.leftMargin: menuButton.width / 2
        color: menuArea.containsMouse ? Theme.accentColor : "white"
        radius: 8

        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            text: "☰"
            color: Theme.textColor
            font.pixelSize: 28
            font.bold: true
        }

        MouseArea {
            id: menuArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: menuDrawer.open()
        }
    }

    // ─── FOOTER STATUS BAR ──────────────────────────────────
    Rectangle {
        id: footer
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: root.height * .03
        color: Theme.bgColor

        Components.StatusBar {
            width: footer.width
            height: footer.height
            anchors.centerIn: footer
        }
    }
}


//// ============================================================
//// src/qml/main.qml
//// ============================================================

//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Window 2.15

//import ThemeModule 1.0

//import "pages" as Pages
//import "components" as Components

//ApplicationWindow {
//    id: root
//    visible: root.ready
//    width: 960
//    height: width * .625
//    title: qsTr("Qt 5.15.2 GLB Model Loader")
//    color: Theme.bgColor

//    property bool ready: false

//    Component.onCompleted: {
//        console.log("ROOT completed, setting ready = true")
//        root.ready = true
//    }

//    // ─── STACKVIEW (main content container) ──────────────────
//    StackView {
//        id: mainStack
//        anchors.fill: parent

//        // Начальная страница
//        initialItem: Pages.MainPage {}
//    }

//    // ─── DRAWER (LEFT MENU) ──────────────────────────────────
//    Drawer {
//        id: menuDrawer
//        width: root.width * .3
//        height: root.height
//        edge: Qt.LeftEdge
//        modal: true
//        dim: true
//        closePolicy: Drawer.CloseOnPressOutsideParent

//        background: Rectangle {
//            color: Theme.bgColor
//            border.color: Theme.accentDim
//            border.width: 1
//        }

//        Column {
//            anchors.fill: parent
//            spacing: 0

//            // ─── MENU ITEMS ────────────────────────────────────
//            Column {
//                id: menuItems
//                width: menuDrawer.width
//                spacing: 0

//                Repeater {
//                    model: ["Группировка", "Карта", "Алгоритмы"]
//                    delegate: Item {
//                        width: menuDrawer.width
//                        height: 50

//                        Rectangle {
//                            anchors.fill: parent
//                            color: mouseArea.containsMouse ? Theme.accentColor : "transparent"
//                            opacity: mouseArea.containsMouse ? 0.2 : 0
//                            Behavior on opacity { NumberAnimation { duration: 150 } }
//                        }

//                        Text {
//                            anchors.left: parent.left
//                            anchors.leftMargin: 20
//                            anchors.verticalCenter: parent.verticalCenter
//                            text: modelData
//                            color: Theme.textColor
//                            font {
//                                family: Theme.fontFamily
//                                pixelSize: 14
//                                bold: true
//                            }
//                        }

//                        MouseArea {
//                            id: mouseArea
//                            anchors.fill: parent
//                            hoverEnabled: true
//                            cursorShape: Qt.PointingHandCursor
//                            onClicked: {
//                                console.log("▶ Selected:", modelData)
//                                menuDrawer.close()
//                            }
//                        }

//                        Rectangle {
//                            anchors.bottom: parent.bottom
//                            width: parent.width
//                            height: 1
//                            color: Theme.accentDim
//                            opacity: 0.3
//                        }
//                    }
//                }
//            }

//            // ─── SPACER (pushes everything to bottom) ──────────
//            Item {
//                width: menuDrawer.width
//                height: parent.height - menuItems.height - 51
//            }

//            // ─── SEPARATOR ─────────────────────────────────────
//            Rectangle {
//                width: menuDrawer.width
//                height: 1
//                color: Theme.accentDim
//                opacity: 0.5
//            }

//            // ─── CLOSE / HIDE MENU ────────────────────────────
//            Item {
//                width: menuDrawer.width
//                height: 50

//                Rectangle {
//                    anchors.fill: parent
//                    color: mouseAreaClose.containsMouse ? Theme.warningColor : "transparent"
//                    opacity: mouseAreaClose.containsMouse ? 0.2 : 0
//                    Behavior on opacity { NumberAnimation { duration: 150 } }
//                }

//                Text {
//                    anchors.left: parent.left
//                    anchors.leftMargin: 20
//                    anchors.verticalCenter: parent.verticalCenter
//                    text: "✕ СКРЫТЬ"
//                    color: Theme.textHighlight
//                    font {
//                        family: Theme.fontFamily
//                        pixelSize: 14
//                        bold: true
//                    }
//                }

//                MouseArea {
//                    id: mouseAreaClose
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    cursorShape: Qt.PointingHandCursor
//                    onClicked: menuDrawer.close()
//                }
//            }
//        }
//    }

//    // ─── MAIN CONTENT ────────────────────────────────────────
//    Rectangle {
//        anchors.fill: parent
//        color: Theme.bgColor
////        anchors.leftMargin: 20
////        anchors.rightMargin: 20
////        anchors.topMargin: 20
////        anchors.bottomMargin: 60
////        color: Theme.cardColor
////        radius: 8
////        border.color: Theme.accentDim
////        border.width: 1

//        // Placeholder image
//        Image {
//            anchors.centerIn: parent
//            source: "qrc:/images/placeholder.png"
//            fillMode: Image.PreserveAspectFit
//            opacity: 1
//            visible: source != ""
//        }

//        Text {
//            anchors.centerIn: parent
//            text: "MAIN CONTENT AREA"
//            color: Theme.textColor
//            font {
//                family: Theme.fontFamily
//                pixelSize: 24
//                bold: true
//            }
//            opacity: 0.3
//        }
//    }

//    // ─── MENU TOGGLE BUTTON ──────────────────────────────────
//    Rectangle {
//        id: menuButton
//        visible: root.ready
//        width: root.width * .04
//        height: menuButton.width
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.bottomMargin: menuButton.width
//        anchors.leftMargin: menuButton.width / 2
//        color: menuArea.containsMouse ? Theme.accentColor : "white"
//        radius: 8

//        Behavior on color { ColorAnimation { duration: 150 } }

//        Text {
//            anchors.centerIn: parent
//            text: "☰"
//            color: Theme.textColor
//            font.pixelSize: 28
//            font.bold: true
//        }

//        MouseArea {
//            id: menuArea
//            anchors.fill: parent
//            hoverEnabled: true
//            cursorShape: Qt.PointingHandCursor
//            onClicked: menuDrawer.open()
//        }
//    }

//    // ─── FOOTER STATUS BAR ──────────────────────────────────
//    Rectangle {
//        id: footer
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.right: parent.right
//        height: root.height * .03
//        color: Theme.bgColor

//        Components.StatusBar {
//            width: footer.width
//            height: footer.height
//            anchors.centerIn: footer
//        }
//    }
//}

//// ============================================================
//// src/qml/main.qml
//// ============================================================

//import QtQuick 2.15
//import QtQuick.Window 2.15

//import "pages" as Pages

//Window {
//    id: window
//    visible: true
//    width: 960
//    height: 600
//    title: qsTr("Qt 5.15.2 GLB Model Loader")
//    color: "transparent"

//    Pages.MainPage {
//        anchors.fill: parent
//    }
//}
