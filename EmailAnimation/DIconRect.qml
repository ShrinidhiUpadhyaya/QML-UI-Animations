import QtQuick 2.12

DRect {
    id: emailIconRect

    property alias source: icon.source
    property alias iconAnimation: iconAnimation

    width: height
    height: parent.height
    radius: height
    anchors.verticalCenter: parent.verticalCenter
    color: AppThemes.transaprentColor
    border.color: AppThemes.whiteColor
//    x: root.currentMode === 0 ? 0 : (root.width*2)
//    opacity: (x >= (root.width- (width/2))) ? 0 : 1
    mouseArea.enabled: false
    animationDuration: AppThemes.longAnimationDuration

    Image {
        id: icon

        width: AppThemes.iconSize
        height: width
        anchors.verticalCenter: parent.verticalCenter
        x: (parent.width / 2) - (width / 2)
//        source: AppThemes.setIconSource("emailIcon.png")
    }

    DVibrateAnimation {
        id: iconAnimation

        target: icon
//        running: root.errorMode
        margin: 5
        duration: AppThemes.animationDuration
    }
}
