// ============================================================
// src/qml/components/TacticalCorners.qml
// ============================================================

import QtQuick 2.15
import ThemeModule 1.0

Item {
    id: root

    property int cornerSize: 25
    property int cornerThickness: 3
    property color cornerColor: Theme.accentColor

    // ─── ВЕРХНИЙ ЛЕВЫЙ УГОЛ ──────────────────────────────
    Rectangle {
        width: root.cornerSize
        height: root.cornerThickness
        anchors.top: parent.top
        anchors.left: parent.left
        color: root.cornerColor
    }
    Rectangle {
        width: root.cornerThickness
        height: root.cornerSize
        anchors.top: parent.top
        anchors.left: parent.left
        color: root.cornerColor
    }

    // ─── ВЕРХНИЙ ПРАВЫЙ УГОЛ ─────────────────────────────
    Rectangle {
        width: root.cornerSize
        height: root.cornerThickness
        anchors.top: parent.top
        anchors.right: parent.right
        color: root.cornerColor
    }
    Rectangle {
        width: root.cornerThickness
        height: root.cornerSize
        anchors.top: parent.top
        anchors.right: parent.right
        color: root.cornerColor
    }

    // ─── НИЖНИЙ ЛЕВЫЙ УГОЛ ──────────────────────────────
    Rectangle {
        width: root.cornerSize
        height: root.cornerThickness
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: root.cornerColor
    }
    Rectangle {
        width: root.cornerThickness
        height: root.cornerSize
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        color: root.cornerColor
    }

    // ─── НИЖНИЙ ПРАВЫЙ УГОЛ ─────────────────────────────
    Rectangle {
        width: root.cornerSize
        height: root.cornerThickness
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: root.cornerColor
    }
    Rectangle {
        width: root.cornerThickness
        height: root.cornerSize
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: root.cornerColor
    }
}