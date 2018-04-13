import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Rectangle {
    id: window
    property real previousX
    property real previousY
    property real previousWX
    property real previousWY
    visible: false
    property color mainColor: "green"
    border.color: mainColor
    Rectangle {
        height: 40
        width: parent.width

        Text {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                right: controlButtons.left
            }

            text: mainWindow.title
            font.family: "Times New Roman"
            font.pointSize: 18
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

        }

        border.color: window.mainColor
        RowLayout {
            id: controlButtons
            z: 1
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }

            spacing: 3

            Button {
                id: hide
                Layout.fillHeight: true
                implicitWidth: height
                Layout.margins: 5

                background: Rectangle {
                    color: "yellow"
                }

                onClicked: {
                    mainWindow.showMinimized()
                }
            }
            Button {
                id: maximized
                z: 1
                Layout.fillHeight: true
                implicitWidth: height
                Layout.margins: 5

                background: Rectangle {
                    color: "blue"
                }

                onClicked: {
                    mainWindow.showMaximized()
                }
            }
            Button {
                id: exit
                Layout.fillHeight: true
                implicitWidth: height
                Layout.margins: 5

                background: Rectangle {
                    color: "red"
                }

                onClicked: {
                    mainWindow.close()
                }
            }
        }


        MouseArea {
            anchors.fill: parent
            property int offsetX: 0
            property int offsetY: 0

            onPressed: {
                offsetX = mainWindow.x - myMouse.x
                offsetY = mainWindow.y - myMouse.y
            }

            onMouseXChanged: {
                mainWindow.setX(myMouse.x + offsetX)
            }
            onMouseYChanged: {
                mainWindow.setY(myMouse.y + offsetY)
            }
        }
    }


    //        MouseArea {
    //            id: topResize
    //            height: 5
    //            cursorShape: Qt.SizeVerCursor
    //            anchors {
    //                left: parent.left
    //                right: parent.right
    //                top: parent.top
    //            }
    //            onPressed: {
    //                previousY = mouseY
    //            }
    //            onMouseYChanged: {
    //                var dy = mouseY - previousY
    //                mainWindow.setY(mainWindow.y + dy)
    //                mainWindow.setHeight(mainWindow.height - dy)
    //            }
    //        }

    //        MouseArea {
    //            id: bottomResize
    //            height: 5
    //            cursorShape: Qt.SizeVerCursor
    //            anchors {
    //                left: parent.left
    //                right: parent.right
    //                bottom: parent.bottom
    //            }
    //            onPressed: {
    //                previousY = mouseY
    //            }
    //            onMouseYChanged: {
    //                var dy = mouseY - previousY
    //                mainWindow.setHeight(mainWindow.height + dy)
    //            }
    //        }

    //        MouseArea {
    //            id: leftResize
    //            width: 5
    //            cursorShape: Qt.SizeHorCursor
    //            anchors {
    //                left: parent.left
    //                bottom: parent.bottom
    //                top: parent.top
    //            }
    //            onPressed: {
    //                previousX = mouseX
    //            }
    //            onMouseXChanged: {
    //                var dx = mouseX - previousX
    //                mainWindow.setX(mainWindow.x + dx)
    //                mainWindow.setWidth(mainWindow.width - dx)
    //            }
    //        }

    //        MouseArea {
    //            id: rightResize
    //            width: 5
    //            cursorShape: Qt.SizeHorCursor
    //            anchors {
    //                right: parent.right
    //                top: parent.top
    //                bottom: parent.bottom
    //            }
    //            onPressed: {
    //                previousX = mouseX
    //            }
    //            onMouseXChanged: {
    //                var dx = mouseX - previousX
    //                mainWindow.setWidth(mainWindow.width + dx)
    //            }
    //        }
}
