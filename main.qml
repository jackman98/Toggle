import QtQuick 2.10
import QtQuick.Controls 2.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480

    flags: switcher.enabledToggle ? Qt.Window | Qt.CustomizeWindowHint : Qt.Window
    title: qsTr("Toggle")

    CustomWindow {
        id: window
        anchors.fill: parent
        visible: switcher.enabledToggle
    }

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: parent.width / 2
        height: width / 2
        color: "#d3cece"
        radius: height / 2

        Label {
            id: stateToggle
            anchors.verticalCenter: background.verticalCenter
            anchors.rightMargin: background.height / 3
            anchors.leftMargin: background.height / 3
            font.pointSize: background.height / 4
            horizontalAlignment: Qt.AlignHCenter
            antialiasing: true
            property real leftTX: (background.height - stateToggle.height) / 2
            property real rightTX: (background.width - stateToggle.height) - leftTX

        }
        Rectangle {
            id: switcher
            anchors.verticalCenter: background.verticalCenter
            height: background.height * 0.9
            width : height
            radius: height / 2
            property bool enabledToggle : false
            property real leftX: (background.height - switcher.height) / 2
            property real rightX: (background.width - switcher.height) - leftX

            state: "off"
            color: "#5eb337"

            states: [
                State {
                    name: "off"
                    PropertyChanges {
                        target: switcher
                        color: "red"
                        x: leftX
                        enabledToggle: false
                    }
                    PropertyChanges {
                        target: stateToggle
                        text: "Off"
                        x: rightTX
                    }
                },
                State {
                    name: "on"
                    PropertyChanges {
                        target: switcher
                        color: "green"
                        x: rightX
                        enabledToggle: true
                    }
                    PropertyChanges {
                        target: stateToggle
                        text: "On"
                        x: leftTX
                    }
                }
            ]

            transitions: [
                Transition {
                    ColorAnimation {
                        duration: 300
                        easing.type: Easing.OutQuint
                    }

                    NumberAnimation {
                        targets: [stateToggle, switcher]
                        property: "x"
                        duration: 300
                        easing.type: Easing.OutQuint
                    }

                    AnchorAnimation {
                        duration: 300
                        easing.type: Easing.OutQuint
                    }
                }
            ]
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                propagateComposedEvents: true
                property real prevX: switcher.x

                onReleased: {
                    if (prevX > mouseX) {
                        parent.state = "off"
                    }
                    else if (prevX < mouseX) {
                        parent.state = "on"
                    }
                    else if (prevX == mouseX) {
                        parent.state = (parent.state == "on") ? "off" : "on"
                    }

                }

                onPressed: {
                    prevX = mouseX
                }
                onMouseXChanged: {
                    var dx = mouseX - prevX

                    if (switcher.x + dx >= switcher.rightX)
                        switcher.x = switcher.rightX
                    else if (switcher.x + dx <= switcher.leftX)
                        switcher.x = switcher.leftX
                    else
                        switcher.x += dx

                }
            }
        }
    }
}
