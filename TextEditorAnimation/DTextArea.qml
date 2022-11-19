import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

import AppThemes 1.0

Item {
    id: root

    property bool textEditable: true
    property bool textColorEditingEnabled: false
    property bool textBold: textPropertiesModel.count > 0 ? textPropertiesModel.get(0).propertyEnabled : false
    property bool textItalic: textPropertiesModel.count > 0 ? textPropertiesModel.get(1).propertyEnabled : false
    property bool textStrikeOut: textPropertiesModel.count > 0 ? textPropertiesModel.get(2).propertyEnabled : false
    property bool textReadOnly: textPropertiesModel.count > 0 ? textPropertiesModel.get(3).propertyEnabled : false
    property bool textUnderline: textPropertiesModel.count > 0 ? textPropertiesModel.get(4).propertyEnabled : false

    implicitWidth: 250
    implicitHeight: 100

    focus: true

    DRect {
        id: textPropertiesRootRect

        width: (textInput.length > 0 &&  textEditable)? parent.width : 0
        height: AppThemes.textBoxHeight
        radius: height / 2
        anchors.bottom: textAreaRect.top
        anchors.bottomMargin: (textInput.length &&  textEditable) > 0 ? 20 : 0
        anchors.horizontalCenter: parent.horizontalCenter
        color: AppThemes.whiteColor
        opacity: 0
        mouseArea.enabled: false

        Row {
            anchors.fill: parent

            Rectangle {
                height: parent.height
                width: parent.width / 6
                radius: textPropertiesRootRect.radius

                DRect {
                    width: 16
                    height: 16
                    radius: 16
                    color: newTextColor.text

                    anchors.centerIn: parent

                    onClicked: {
                        console.log("clicked")
                        root.textColorEditingEnabled = !root.textColorEditingEnabled
                    }
                }
            }

            TextArea {
                id: newTextColor

                height: parent.height
                width: parent.width / 2
                text: textInput.color
                verticalAlignment: Qt.AlignVCenter
                visible: root.textColorEditingEnabled
            }

            Repeater {
                model: textPropertiesModel

                DRect {
                    height: parent.height
                    width: parent.width / 6
                    radius: textPropertiesRootRect.radius
                    visible: !root.textColorEditingEnabled

                    Image {
                        width: model.size
                        height: width
                        anchors.centerIn: parent
                        mipmap: true
                        source: model.propertyEnabled ? model.enabledSource : model.disabledSource
                    }


                    onClicked: {
                        console.log("Property Value Changed")
                        model.propertyEnabled = !model.propertyEnabled
                    }
                }
            }

//            DRect {
//                height: parent.height
//                width: parent.width / 6
//                radius: 20
//                visible: !root.textColorEditingEnabled

//                Image {
//                    width: 20
//                    height: 20
//                    anchors.centerIn: parent
//                    mipmap: true
//                    source: root.textBold ? "qrc:/icons/textBoldEnabled.png" : "qrc:/icons/textBoldDisabled.png"
//                }


//                onClicked: {
//                    console.log("Bold Clicked")
//                    root.textBold = !root.textBold
//                }
//            }

//            DRect {
//                height: parent.height
//                width: parent.width / 6
//                radius: 20
//                visible: !root.textColorEditingEnabled

//                Image {
//                    width: 24
//                    height: 24
//                    anchors.centerIn: parent
//                    mipmap: true
//                    source: root.textItalic ? "qrc:/icons/textItalicEnabled.png" : "qrc:/icons/textItalicDisabled.png"
//                }

//                onClicked: {
//                    root.textItalic = !root.textItalic
//                }
//            }

//            DRect {
//                height: parent.height
//                width: parent.width / 6
//                radius: 20
//                visible: !root.textColorEditingEnabled

//                Image {
//                    width: 24
//                    height: 24
//                    anchors.centerIn: parent
//                    mipmap: true
//                    source: root.textStrikeOut ? "qrc:/icons/textStrikeEnabled.png" : "qrc:/icons/textStrikeDisabled.png"
//                }

//                onClicked: {
//                    root.textStrikeOut = !root.textStrikeOut
//                }
//            }

//            DRect {
//                height: parent.height
//                width: parent.width / 6
//                radius: 20
//                visible: !root.textColorEditingEnabled

//                Image {
//                    width: 18
//                    height: 18
//                    anchors.centerIn: parent
//                    mipmap: true
//                    source:  root.textReadOnly ? "qrc:/icons/textLock.png" : "qrc:/icons/textUnlock.png"
//                }

//                onClicked: {
//                    root.textReadOnly = !root.textReadOnly
//                }
//            }

//            DRect {
//                height: parent.height
//                width: parent.width / 6
//                radius: 20
//                visible: !root.textColorEditingEnabled

//                Image {
//                    width: 18
//                    height: 18
//                    anchors.centerIn: parent
//                    mipmap: true
//                    source: root.textUnderline ? "qrc:/icons/textUnderLineEnabled.png" : "qrc:/icons/textUnderLineDisabled.png"
//                }

//                onClicked: {
//                    root.textUnderline = !root.textUnderline
//                }
//            }

        }

        DRect {
            id: okRect

            width: AppThemes.circularButtonSize
            height: AppThemes.circularButtonSize
            radius: AppThemes.circularButtonSize
            x: root.textColorEditingEnabled ? parent.width - width - 2 : 0
            color: AppThemes.buttonColor
            anchors.verticalCenter: parent.verticalCenter
            opacity: x > width ? 1 : 0
            enabled: x > width

            Label {
                text: "OK"
                color: AppThemes.whiteColor
                font.family: AppThemes.fontFamilyType
                anchors.centerIn: parent
            }

            onClicked: {
                root.textColorEditingEnabled = !root.textColorEditingEnabled
                textInput.color = newTextColor.text
            }
        }

    }

    DropShadow {
        anchors.fill: textPropertiesRootRect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: AppThemes.shadowColor
        source: textPropertiesRootRect
    }

    Rectangle {
        id: textAreaRect

        width: parent.width
        height: AppThemes.textBoxHeight
        radius: 2
        color: AppThemes.transparentColor
        border.color: AppThemes.textBoxFontColor
        anchors.centerIn: parent

        TextArea {
            id: textInput

            placeholderText: qsTr("Input")
            anchors.fill: parent
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            selectByMouse: true
            selectedTextColor: AppThemes.whiteColor
            selectionColor: AppThemes.textSelectionColor
            font.pixelSize: AppThemes.inputFontSize
            font.underline: root.textUnderline
            font.bold: root.textBold
            font.italic: root.textItalic
            font.strikeout: root.textStrikeOut
            readOnly: root.textReadOnly

            onActiveFocusChanged: {
                if(textInput.activeFocus) {
                    root.textEditable = true
                }
            }
        }
    }

    ListModel {
        id: textPropertiesModel

        ListElement {
            size: 20
            disabledSource:"qrc:/icons/textBoldDisabled.png"
            enabledSource:"qrc:/icons/textBoldEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 24
            disabledSource:"qrc:/icons/textItalicDisabled.png"
            enabledSource:"qrc:/icons/textItalicEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 24
            disabledSource:"qrc:/icons/textStrikeDisabled.png"
            enabledSource:"qrc:/icons/textStrikeEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 18
            disabledSource:"qrc:/icons/textUnlock.png"
            enabledSource:"qrc:/icons/textLock.png"
            propertyEnabled: false
        }

        ListElement {
            size: 18
            disabledSource:"qrc:/icons/textUnderLineDisabled.png"
            enabledSource:"qrc:/icons/textUnderLineEnabled.png"
            propertyEnabled: false
        }
    }
}
