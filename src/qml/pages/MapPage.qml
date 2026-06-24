// ============================================================
// src/qml/pages/MapPage.qml
// ============================================================

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebEngine 1.10
import QtWebChannel 1.0

import ThemeModule 1.0

Rectangle {
    id: root
//    anchors.fill: parent
    color: Theme.bgColor

//v    property string urlPage: "https://yandex.ru/maps/?ll=33.486549%2C44.6057335&z=10"
    property string urlPage: "qrc:/web/index.html"

    WebEngineView {
        id: webView
        anchors.fill: parent
        url: root.urlPage

        onLoadingChanged: {
            if (loadRequest.status === WebEngineView.LoadSucceeded) {
                console.log("Map loaded successfully")
            } else if (loadRequest.status === WebEngineView.LoadFailed) {
                console.warn("Map load failed:", loadRequest.errorString)
            }
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: webView.loadProgress < 100
        visible: webView.loadProgress < 100
        width: 50
        height: 50
    }

    NoConnectionPage {}
}
