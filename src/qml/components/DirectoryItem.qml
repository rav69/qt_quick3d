// ============================================================
// src/qml/components/DirectoryItem.qml
// ============================================================

import QtQuick 2.15
import ThemeModule 1.0

Item {
    id: root
    width: parent.width
    height: rowHeight + (expanded && node.children && node.children.length > 0 ? childrenRepeater.height : 0)

    property var node: ({})
    property bool expanded: false
    property string selectedPath: ""   // ← путь выбранного файла

    signal fileSelected(string filePath)
    signal itemClicked(string filePath)
    signal itemDoubleClicked(string filePath)

    property int rowHeight: 30

    // ─── Строка элемента ──────────────────────────────────────
    Rectangle {
        id: rowRect
        width: root.width
        height: rowHeight
        color: mouseArea.containsMouse ? Theme.accentColor : (node.fullPath === selectedPath ? Qt.lighter(Theme.accentColor, 1.5) : "transparent")
        border.color: node.fullPath === selectedPath ? Theme.textHighlight : "transparent"
        border.width: node.fullPath === selectedPath ? 2 : 0

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 10 + (node.depth || 0) * 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Text {
                text: (!node.isFile && node.children && node.children.length > 0) ? (expanded ? "▼ " : "▶ ") : ""
                color: Theme.textColor
                font.pixelSize: 14
                visible: !node.isFile && node.children && node.children.length > 0
                MouseArea {
                    anchors.fill: parent
                    onClicked: expanded = !expanded
                }
            }

            Text {
                text: node.isFile ? "📄 " : "📁 "
                color: Theme.textColor
                font.pixelSize: 16
            }

            Text {
                text: node.name || ""
                color: Theme.textColor
                font { family: Theme.fontFamily; pixelSize: 14 }
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                if (!node.isFile && node.children && node.children.length > 0) {
                    expanded = !expanded
                } else {
                    root.itemClicked(node.fullPath || node.name)
                }
            }

            onDoubleClicked: {
                if (node.isFile) {
                    root.itemDoubleClicked(node.fullPath || node.name)
                }
            }
        }
    }

    // ─── Дочерние элементы (загружаются динамически) ────────
    Column {
        id: childrenRepeater
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rowRect.bottom
        visible: expanded && node.children && node.children.length > 0
        spacing: 0

        Repeater {
            model: root.node.children || []
            delegate: Loader {
                width: childrenRepeater.width
                height: item ? item.height : 0
                source: "DirectoryItem.qml"
                onLoaded: {
                    item.node = modelData
                    // ← Создаём привязку для selectedPath
                    item.selectedPath = Qt.binding(function() {
                        return root.selectedPath
                    })
                    // Пробрасываем сигналы
                    item.itemClicked.connect(root.itemClicked)
                    item.itemDoubleClicked.connect(root.itemDoubleClicked)
                    item.fileSelected.connect(root.fileSelected)
                }
            }
        }
    }
}

//// ============================================================
//// src/qml/components/DirectoryItem.qml
//// ============================================================

//import QtQuick 2.15
//import ThemeModule 1.0

//Item {
//    id: root
//    width: parent.width
//    height: rowHeight + (expanded && node.children && node.children.length > 0 ? childrenRepeater.height : 0)

//    property var node: ({})
//    property bool expanded: false

//    signal fileSelected(string filePath)

//    property int rowHeight: 30

//    // ─── Element string ──────────────────────────────────────
//    Rectangle {
//        id: rowRect
//        width: root.width
//        height: rowHeight
//        color: mouseArea.containsMouse ? Theme.accentColor : "transparent"

//        Row {
//            anchors.left: parent.left
//            anchors.leftMargin: 10 + (node.depth || 0) * 20
//            anchors.verticalCenter: parent.verticalCenter
//            spacing: 8
//            Text {
//                text: (!node.isFile && node.children && node.children.length > 0) ? (expanded ? "▼ " : "▶ ") : ""
//                color: Theme.textColor
//                font.pixelSize: 14
//                visible: !node.isFile && node.children && node.children.length > 0
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: expanded = !expanded
//                }
//            }

//            Text {
//                text: node.isFile ? "📄 " : ""
//                color: Theme.textColor
//                font.pixelSize: 16
//            }

//            Text {
//                text: node.name || ""
//                color: Theme.textColor
//                font { family: Theme.fontFamily; pixelSize: 14 }
//            }
//        }

//        MouseArea {
//            id: mouseArea
//            anchors.fill: parent
//            hoverEnabled: true
//            onClicked: {
//                if (!node.isFile && node.children && node.children.length > 0) {
//                    expanded = !expanded
//                } else {
//                    root.fileSelected(node.fullPath || node.name)
//                }
//            }
//        }
//    }

//    // ─── Child elements (loaded dynamically) ────────
//    Column {
//        id: childrenRepeater
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.top: rowRect.bottom
//        visible: expanded && node.children && node.children.length > 0
//        spacing: 0

//        Repeater {
//            model: root.node.children || []
//            delegate: Loader {
//                width: childrenRepeater.width
//                height: item ? item.height : 0
//                source: "DirectoryItem.qml"   // dynamic loading
//                onLoaded: {
//                    item.node = modelData
//                    item.fileSelected.connect(root.fileSelected)
//                }
//            }
//        }
//    }
//}
