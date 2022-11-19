pragma Singleton

import QtQuick 2.12
import QtQuick.Window 2.12


Item {
    id: root

    property string fontFamilyType: fontType.name

    property string textSelectionColor: "#464646"
    property string whiteColor: "white"
    property string transparentColor: "transparent"
    property string textBoxFontColor: "#8550D4"
    property string shadowColor: "#C5C5C5"
    property string buttonColor: "#309EEB"

    property real animationDuration: 200
    property real inputFontSize: 24
    property real circularButtonSize: 32
    property real textBoxHeight: 40

    FontLoader {
        id: fontType

        source: "qrc:/font/NexaBold.otf"
    }
}
