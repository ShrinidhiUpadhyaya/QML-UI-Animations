import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Email Animation")

    Rectangle {
        id: rootWindowRect

        anchors.fill: parent
        color: AppThemes.windowBackgroundColor

        property bool verificationCompleted: false

        DRect {
            id: signUpButton

            width: 250
            anchors.centerIn: parent

            Label {
                text: qsTr("Sign Up")
                anchors.centerIn: parent
                color: AppThemes.textColor
                font.pixelSize: AppThemes.largeFontSize
            }

            onClicked: {
                signUpButton.visible = false
                emailField.visible = true
            }
        }

        Label {
            text: qsTr("Welcome")
            opacity: rootWindowRect.verificationCompleted ? 1 : 0
            anchors.centerIn: parent
            scale: rootWindowRect.verificationCompleted ? 1 : 0.2
            color: AppThemes.textColor
            font.pixelSize: AppThemes.largeFontSize

            Behavior on opacity {
                NumberAnimation {
                    duration: AppThemes.longAnimationDuration
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on scale {
                NumberAnimation {
                    duration: AppThemes.longAnimationDuration
                    easing.type: Easing.InOutQuad
                }
            }
        }

        DEmailField {
            id: emailField

            visible: false

            onCompleted:{
                console.log("Completed")
                rootWindowRect.verificationCompleted = true
            }
        }
    }
}
