import QtQuick 2.15
import QtQuick.Window 2.15

import "pages" as Pages

Window {
    id: window
    visible: true
    width: 960
    height: 600
    title: qsTr("Qt 5.15.2 GLB Model Loader")
    color: "transparent"

    Pages.MainPage {
        anchors.fill: parent
    }
 }
