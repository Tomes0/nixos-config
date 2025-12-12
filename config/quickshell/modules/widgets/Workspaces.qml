import QtQuick 2.15
import QtQuick.Layouts 1.15
import Quickshell.Hyprland

Item {
    id: root
    // Calculates the necessary width based on the content
    implicitWidth: wsRow.implicitWidth + 4
    implicitHeight: 40

    Rectangle {
        color: '#aa000000' // Semi-transparent black background
        height: 40
        radius: 20 // Rounded corners for the container
        anchors.fill: parent

        Row {
            id: wsRow
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8 // Increased spacing for better separation

            Repeater {
                id: workspaces
                model: Hyprland.workspaces

                Rectangle {
                    width: 36 
                    height: 36
                    radius: 18
                    
                    // Use a dark color for inactive and the purple highlight for active
                    color: modelData.active ? "#fff" : "#44475a" 
                    
                    // FIX: Add a Behavior to smoothly transition the color property.
                    Behavior on color {
                        ColorAnimation { duration: 150 } // 150ms transition
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: modelData.active ? null : Hyprland.dispatch("workspace " + modelData.name)
                    }

                    Text {
                        text: modelData.name
                        anchors.centerIn: parent
                        color: modelData.active ? "#282a36" : "#f8f8f2"
                        font.pixelSize: 18
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 } // 150ms transition
                        }
                    }
                }
            }
        }
    }
}