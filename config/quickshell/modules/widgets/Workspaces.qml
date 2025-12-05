import QtQuick 2.15
import QtQuick.Layouts 1.15
import Quickshell.Hyprland

Item {
    id: root
    implicitWidth: wsRow.implicitWidth + 4
    implicitHeight: 40

    Rectangle {
        color: '#aa000000'
        height: 40
        bottomRightRadius: 20
        anchors.fill: parent

        Row {
            id: wsRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Repeater {
                id: workspaces
                model: Hyprland.workspaces

                Rectangle {
                    width: 36
                    height: 36
                    radius: 18
                    color: modelData.active ? "#fff" : "#555"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.active ? null : Hyprland.dispatch("workspace " + modelData.name)
                    }

                    Text {
                        text: modelData.name
                        anchors.centerIn: parent
                        color: modelData.active ? "#000" : "#fff"
                        font.pixelSize: 18
                    }
                }
            }
        }
    }
}
