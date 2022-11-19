import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

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

    DRect {
        id: textPropertiesRootRect

        width: (textInput.length > 0 &&  root.textEditable)? parent.width : 0
        height: AppThemes.textBoxHeight
        radius: height / 2
        anchors.bottom: textAreaRect.top
        anchors.bottomMargin: (textInput.length &&  root.textEditable) > 0 ? radius : 0
        anchors.horizontalCenter: parent.horizontalCenter
        color: AppThemes.whiteColor
        opacity: 0
        mouseArea.enabled: false

        Row {
            anchors.fill: parent

            Rectangle {
                width: parent.width / 6
                height: parent.height
                radius: textPropertiesRootRect.radius

                DRect {
                    width: AppThemes.colorButtonSize
                    height: width
                    radius: width
                    anchors.centerIn: parent
                    color: newTextColor.text

                    onClicked: {
                        root.textColorEditingEnabled = !root.textColorEditingEnabled
                    }
                }
            }

            TextArea {
                id: newTextColor

                width: parent.width / 2
                height: parent.height
                verticalAlignment: Qt.AlignVCenter
                text: textInput.color
                font.pixelSize: AppThemes.smallFontSize
                visible: root.textColorEditingEnabled
                selectByMouse: true
            }

            Repeater {
                model: textPropertiesModel

                DRect {
                    width: parent.width / (textPropertiesModel.count+1)
                    height: parent.height
                    radius: textPropertiesRootRect.radius
                    visible: !root.textColorEditingEnabled

                    Image {
                        width: model.size
                        height: width
                        anchors.centerIn: parent
                        source: model.propertyEnabled ? model.enabledSource : model.disabledSource
                        mipmap: true
                    }

                    onClicked: {
                        console.log("Property Value Changed")
                        model.propertyEnabled = !model.propertyEnabled
                    }
                }
            }
        }

        DRect {
            id: okRect

            width: AppThemes.circularButtonSize
            height: width
            radius: width
            x: root.textColorEditingEnabled ? parent.width - width - AppThemes.smallMargin : 0
            anchors.verticalCenter: parent.verticalCenter
            color: AppThemes.buttonColor
            opacity: x > width ? 1 : 0
            enabled: x > width

            Label {
                text: qsTr("OK")
                color: AppThemes.whiteColor
                font.family: AppThemes.fontFamilyType
                font.pixelSize: AppThemes.smallFontSize
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

            anchors.fill: parent
            placeholderText: qsTr("Input")
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
                    root.textEditable = true;
                }
            }
        }
    }

    ListModel {
        id: textPropertiesModel

        ListElement {
            size: 20
            disabledSource: "qrc:/icons/textBoldDisabled.png"
            enabledSource: "qrc:/icons/textBoldEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 24
            disabledSource: "qrc:/icons/textItalicDisabled.png"
            enabledSource: "qrc:/icons/textItalicEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 24
            disabledSource: "qrc:/icons/textStrikeDisabled.png"
            enabledSource: "qrc:/icons/textStrikeEnabled.png"
            propertyEnabled: false
        }

        ListElement {
            size: 18
            disabledSource: "qrc:/icons/textUnlock.png"
            enabledSource: "qrc:/icons/textLock.png"
            propertyEnabled: false
        }

        ListElement {
            size: 18
            disabledSource: "qrc:/icons/textUnderLineDisabled.png"
            enabledSource: "qrc:/icons/textUnderLineEnabled.png"
            propertyEnabled: false
        }
    }
}
