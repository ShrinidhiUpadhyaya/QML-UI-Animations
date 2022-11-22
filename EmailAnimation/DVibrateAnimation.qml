import QtQuick 2.12

SequentialAnimation {
    id: root

    property real from: target.x
    property real to: root.from + root.margin
    property real margin: 20
    property real duration: AppThemes.fastAnimationDuration

    property var target;

    property string animProperty: "x"

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.from
        to: root.to
        duration: root.duration
    }

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.to
        to: root.from
        duration: root.duration
    }

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.from
        to: root.to
        duration: root.duration
    }

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.to
        to: root.from
        duration: root.duration
    }

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.from
        to: root.to
        duration: root.duration
    }

    PropertyAnimation {
        target: root.target
        property: root.animProperty
        from: root.to
        to: root.from
        duration: root.duration
    }
}
