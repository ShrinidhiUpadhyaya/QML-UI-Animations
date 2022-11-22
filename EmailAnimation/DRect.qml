import QtQuick 2.0

Rectangle {
    id: root

    property alias mouseArea: mouseArea

    property real animationDuration: AppThemes.animationDuration

    signal clicked()

    implicitWidth: 400
    implicitHeight: 60
    radius: 60
    color: AppThemes.transaprentColor
    border.color: AppThemes.whiteColor

    Behavior on width {
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutQuad

        }
    }

    Behavior on x {
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutQuad

        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutQuad

        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
    }
}
