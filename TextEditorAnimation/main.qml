import QtQuick 2.12
import QtQuick.Window 2.12


Window {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("TextEditorAnimation")

    Rectangle {
        id: rootRect

        anchors.fill: parent
        color: AppThemes.transparentColor

        MouseArea {
            anchors.fill: parent
            onClicked: {
                rootRect.forceActiveFocus()
                textArea.textEditable = false
            }
        }

        DTextArea {
            id: textArea

            anchors.centerIn: parent
        }
    }
}
