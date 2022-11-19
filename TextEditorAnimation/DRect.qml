import QtQuick 2.12

Rectangle {
    id: root

    property alias mouseArea: mouseArea

    signal clicked()

    Behavior on width {
        NumberAnimation {
            duration: AppThemes.animationDuration
        }
    }

    Behavior on x {
        NumberAnimation {
            duration: AppThemes.animationDuration
        }
    }

    Behavior on anchors.bottomMargin {
        NumberAnimation {
            duration: AppThemes.animationDuration
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
