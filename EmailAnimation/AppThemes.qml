pragma Singleton

import QtQuick 2.12

Item {
    id: root

    readonly property real iconSize: 24
    readonly property real margin: 16
    readonly property real fontSize: 16
    readonly property real smallFontSize: 12
    readonly property real largeFontSize: 24
    readonly property real labelSize: 15

    readonly property real longAnimationDuration: 400
    readonly property real animationDuration: 200
    readonly property real fastAnimationDuration: 100
    readonly property real delayDuration: 500

    readonly property string transaprentColor: "transparent"
    readonly property string whiteColor: "white"
    readonly property string textColor: "white"
    readonly property string secondaryTextColor: "#696969"
    readonly property string windowBackgroundColor: "#1F1F1F"
    readonly property string buttonColor: "#2A2A2A"

    function setIconSource(string) {
        return "qrc:/icons/" + string;
    }
}
