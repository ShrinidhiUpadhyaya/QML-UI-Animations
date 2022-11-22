import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import AppThemes 1.0

DRect {
    id: root

    width: emailIcon.width + nextRect.width + 32 + root.extraWidth
    x: parent.width / 2 - (width / 2)
    anchors.verticalCenter: parent.verticalCenter
    clip: true

    property bool errorMode: false
    property int currentMode: 0
    property real extraWidth: emailTextArea.width

    signal completed()

    DVibrateAnimation {
        target: root
        running: root.errorMode
    }

    Timer {
        interval: AppThemes.delayDuration
        running: root.currentMode === 1
        onTriggered: {
            root.extraWidth = passwordTextArea.width
        }
    }

    Timer {
        interval: AppThemes.delayDuration
        running: root.currentMode === 2
        onTriggered: {
            root.opacity = 0
            root.completed()
        }
    }

    DIconRect {
        id: emailIcon

        x: root.currentMode === 0 ? 0 : (root.width*2)
        opacity: (x >= (root.width- (width/2))) ? 0 : 1
        source: AppThemes.setIconSource("emailIcon.png")
        iconAnimation.running: root.errorMode
    }

    DIconRect {
        id: passwordIcon

        source: AppThemes.setIconSource("passwordIcon.png")
        iconAnimation.running: root.errorMode
        x: root.currentMode < 2 ? 0 : (root.width*2)
        opacity: ((x >= root.width - (width/2)) || root.currentMode == 0 ) ? 0 : 1
    }

    ColumnLayout {
        id: emailLayout

        height: parent.height - AppThemes.margin
        anchors.left: emailIcon.right
        anchors.leftMargin: AppThemes.margin
        anchors.right: nextRect.left
        anchors.rightMargin: AppThemes.margin
        anchors.verticalCenter: parent.verticalCenter
        visible: root.currentMode === 0
        spacing: 0

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: AppThemes.labelSize
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Email")
            color: AppThemes.secondaryTextColor
            font.pixelSize: AppThemes.smallFontSize
            leftInset: 2
        }

        TextField {
            id: emailTextArea

            Layout.minimumWidth: 50
            Layout.maximumWidth: 200
            Layout.fillHeight: true
            color: AppThemes.textColor
            font.pixelSize: AppThemes.fontSize
            horizontalAlignment: Text.AlignLeft
            leftPadding: 0
            validator: RegExpValidator {
                regExp: /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/
            }

            background: Rectangle {
                color: AppThemes.transaprentColor
            }
        }
    }

    ColumnLayout {
        id: passwordLayout

        height: parent.height - AppThemes.margin
        anchors.left: passwordIcon.right
        anchors.leftMargin: AppThemes.margin
        anchors.right: nextRect.left
        anchors.rightMargin: AppThemes.margin
        anchors.verticalCenter: parent.verticalCenter
        visible: root.currentMode === 1
        spacing: 0

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: false
            Layout.preferredHeight: AppThemes.labelSize
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Password")
            color: AppThemes.secondaryTextColor
            font.pixelSize: AppThemes.smallFontSize
            leftInset: 2
        }

        TextField {
            id: passwordTextArea
            Layout.minimumWidth: 100
            Layout.maximumWidth: 200
            Layout.fillHeight: true
            color: AppThemes.textColor
            font.pixelSize: AppThemes.fontSize
            horizontalAlignment: Text.AlignLeft
            leftPadding: 0
            echoMode: TextInput.Password

            background: Rectangle {
                color: AppThemes.transaprentColor
            }
        }
    }

    Rectangle {
        id: nextRect

        width: height
        height: parent.height
        anchors.right: parent.right
        color: AppThemes.transaprentColor
        visible: root.currentMode < 2

        DRect {
            width: height
            height: parent.height / 2
            radius: height
            anchors.centerIn: parent
            color: AppThemes.buttonColor
            border.color: AppThemes.transaprentColor

            Image {
                id: arrowIcon

                width: AppThemes.iconSize
                height: width
                anchors.verticalCenter: parent.verticalCenter
                x: (parent.width / 2) - (width/2)
                source: AppThemes.setIconSource("arrowIcon.png")
                mipmap: true
                rotation: 90
            }

            DVibrateAnimation {
                target: arrowIcon
                running: root.errorMode
                margin: 2
                duration: AppThemes.animationDuration
            }

            onClicked: {
                root.logic()
            }
        }
    }

    function logic() {
        if(root.currentMode === 0) {
            if(emailTextArea.acceptableInput) {
                root.currentMode = Math.max(1,root.currentMode + 1);
            } else {
                root.errorMode = false;
                root.errorMode = true;
            }
        } else if(root.currentMode === 1) {
            root.currentMode = Math.min(2,root.currentMode + 1);
        }
    }
}
