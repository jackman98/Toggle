import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    flags: switcher.enabledToggle ? Qt.FramelessWindowHint : 0
    title: qsTr("Hello World")
    property real previousX
    property real previousY

    Rectangle {
        height: 20
        width: parent.width
        Rectangle {
            id: exit
            height: parent.height
            width: height
            border.color: "green"
        }
        Rectangle {
            id: exit2
            height: parent.height
            width: height
            border.color: "green"
        }
        border.color: "yellow"
        MouseArea {
            anchors.fill: parent
            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }
            onMouseXChanged: {
                var dx = mouseX - previousX
                mainWindow.setX(mainWindow.x + dx)
                console.log("x: ", mainWindow.x)
            }
            onMouseYChanged: {
                var dy = mouseY - previousY
                mainWindow.setY(mainWindow.y + dy)
                console.log("y: ", mainWindow.y)
            }
        }
    }

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: parent.width / 2
        height: width / 2
        color: "#d3cece"
        radius: height / 2
        Text {
            id: stateToggle
            anchors.verticalCenter: background.verticalCenter
            anchors.rightMargin: background.height / 3
            anchors.leftMargin: background.height / 3
            elide: Text.ElideMiddle
            font.pointSize: background.height / 3
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
                    }
                    AnchorChanges {
                        target: stateToggle

                        anchors.left: undefined
                        anchors.right: background.right
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
                    }
                    AnchorChanges {
                        target: stateToggle
                        anchors.left: background.left
                        anchors.right: undefined
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
