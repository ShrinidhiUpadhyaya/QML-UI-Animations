import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: rootRect

        anchors.fill: parent
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Clicked")
                rootRect.forceActiveFocus()
                textArea.textEditable = false
            }
        }

        DTextArea {
            id: textArea

            width: 250
            height: 100
            anchors.centerIn: parent
        }
    }
}
