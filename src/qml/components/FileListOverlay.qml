// ============================================================
// src/qml/components/FileListOverlay.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import ThemeModule 1.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "#50000000"
    visible: false
    z: 20

    property string title: "СПИСОК ФАЙЛОВ"
    property string selectedPath: ""   // ← хранит путь выделенного файла

    signal fileSelected(string filePath)
    signal closed()

    // ─── Сортировка: папки перед файлами, по алфавиту ───────
    function sortChildren(node) {
        if (node.children) {
            node.children.sort(function(a, b) {
                if (a.isFile !== b.isFile) {
                    return a.isFile ? 1 : -1
                }
                return a.name.localeCompare(b.name)
            })
            for (var k = 0; k < node.children.length; k++) {
                sortChildren(node.children[k])
            }
        }
    }

    // ─── Построение дерева из плоского списка путей ──────────
    function buildTreeFromPaths(paths) {
        var rootNode = { name: "", isFile: false, children: [], depth: 0, fullPath: "" }

        for (var i = 0; i < paths.length; i++) {
            var parts = paths[i].split('/')
            var current = rootNode
            var currentPath = ""
            for (var j = 0; j < parts.length; j++) {
                var part = parts[j]
                if (part === "") continue
                currentPath += (currentPath ? "/" : "") + part
                var isFile = (j === parts.length - 1)
                var child = current.children.find(function(c) { return c.name === part })
                if (!child) {
                    child = {
                        name: part,
                        isFile: isFile,
                        children: [],
                        fullPath: currentPath,
                        depth: j
                    }
                    current.children.push(child)
                }
                current = child
            }
        }
        sortChildren(rootNode)
        return rootNode.children
    }

    function updateFileList(files) {
        var tree = buildTreeFromPaths(files)
        fileListView.model = tree
    }

    // ─── БЛОКИРОВКА СОБЫТИЙ НА ФОНЕ ──────────────────────────
    MouseArea {
        anchors.fill: parent
        onClicked: {}
        onPressed: {}
    }

    // ─── КАРТОЧКА СПИСКА ──────────────────────────────────────
    Rectangle {
        width: parent.width * 0.6
        height: parent.height * 0.7
        anchors.centerIn: parent
        color: Theme.bgColor
        border.color: Theme.accentDim
        border.width: 2
        radius: 8

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10

            Text {
                text: root.title
                color: Theme.textHighlight
                font {
                    family: Theme.fontFamily
                    pixelSize: 20
                    bold: true
                    letterSpacing: 2
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: Theme.accentDim
                opacity: 0.5
            }

            ScrollView {
                id: fileScrollView
                width: parent.width
                height: parent.height - 80
                clip: true

                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ListView {
                    id: fileListView
                    anchors.fill: parent
                    clip: true
                    model: []

                    delegate: DirectoryItem {
                        width: fileListView.width
                        node: modelData
                        selectedPath: root.selectedPath   // ← передаём выделенный путь

                        onItemClicked: {
                            root.selectedPath = filePath   // ← обновляем выделение
                        }

                        onItemDoubleClicked: {
                            root.fileSelected(filePath)    // ← открываем файл
                            root.visible = false
                        }
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                TacticalButton {
                    buttonText: "ЗАКРЫТЬ"
                    statusColor: "#D4A574"
                    indicatorVisible: false
                    width: 120
                    height: 40
                    onClicked: {
                        root.visible = false
                        root.closed()
                    }
                }
            }
        }
    }
}

//// ============================================================
//// src/qml/components/FileListOverlay.qml
//// ============================================================

//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import ThemeModule 1.0

//Rectangle {
//    id: root
//    anchors.fill: parent
//    color: "#50000000"
//    visible: false
//    z: 20

//    property string title: "СПИСОК ФАЙЛОВ"

//    signal fileSelected(string filePath)
//    signal closed()

//    // ─── Sorting: folders before files, alphabetically ───────
//    function sortChildren(node) {
//        if (node.children) {
//            node.children.sort(function(a, b) {
//                if (a.isFile !== b.isFile) {
//                    return a.isFile ? 1 : -1
//                }
//                return a.name.localeCompare(b.name)
//            })

//            for (var k = 0; k < node.children.length; k++) {
//                sortChildren(node.children[k])
//            }
//        }
//    }

//    function buildTreeFromPaths(paths) {
//        var rootNode = { name: "", isFile: false, children: [], depth: 0 }

//        for (var i = 0; i < paths.length; i++) {
//            var parts = paths[i].split('/')
//            var current = rootNode
//            for (var j = 0; j < parts.length; j++) {
//                var part = parts[j]
//                if (part === "") continue
//                var isFile = (j === parts.length - 1)
//                var child = current.children.find(function(c) { return c.name === part })
//                if (!child) {
//                    child = {
//                        name: part,
//                        isFile: isFile,
//                        children: [],
//                        fullPath: paths[i],
//                        depth: j
//                    }
//                    current.children.push(child)
//                }
//                current = child
//            }
//        }
//        sortChildren(rootNode)
//        return rootNode.children
//    }

//    function updateFileList(files) {
//        var tree = buildTreeFromPaths(files)
//        fileListView.model = tree
//    }

//    // ─── BLOCKING EVENTS ──────────────────────────────────
//    MouseArea {
//        anchors.fill: parent
//        onClicked: {}
//        onPressed: {}
//    }

//    // ─── LIST CARD ──────────────────────────────────────
//    Rectangle {
//        width: parent.width * 0.6
//        height: parent.height * 0.7
//        anchors.centerIn: parent
//        color: Theme.bgColor
//        border.color: Theme.accentDim
//        border.width: 2
//        radius: 8

//        Column {
//            anchors.fill: parent
//            anchors.margins: 20
//            spacing: 10

//            Text {
//                text: root.title
//                color: Theme.textHighlight
//                font {
//                    family: Theme.fontFamily
//                    pixelSize: 20
//                    bold: true
//                    letterSpacing: 2
//                }
//            }

//            Rectangle {
//                width: parent.width
//                height: 1
//                color: Theme.accentDim
//                opacity: 0.5
//            }

//            ScrollView {
//                id: fileScrollView
//                width: parent.width
//                height: parent.height - 80
//                clip: true

//                ScrollBar.vertical.policy: ScrollBar.AsNeeded
//                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

//                ListView {
//                    id: fileListView
//                    anchors.fill: parent
//                    clip: true
//                    model: [] // will be filled dynamically

//                    delegate: DirectoryItem {
//                        width: fileListView.width
//                        node: modelData
//                        onFileSelected: {
//                            root.fileSelected(filePath)
//                            root.visible = false
//                        }
//                    }
//                }
//            }

//            Row {
//                anchors.horizontalCenter: parent.horizontalCenter
//                spacing: 20

//                TacticalButton {
//                    buttonText: "ЗАКРЫТЬ"
//                    statusColor: "#D4A574"
//                    indicatorVisible: false
//                    width: 120
//                    height: 40
//                    onClicked: {
//                        root.visible = false
//                        root.closed()
//                    }
//                }
//            }
//        }
//    }
//}
