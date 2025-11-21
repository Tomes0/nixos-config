import QtQuick
import Quickshell.Hyprland

Item {
    id: root
    implicitWidth: 160
    implicitHeight: 40

    // Background rectangle for the widget
    Rectangle {
        color: "#9f9f9f"
        height: 40
        radius: 20
        anchors.fill: parent
    }

    // Main content row for the monitor, only visible when data is ready
    Row {
        visible: Hyprland.cpu && Hyprland.memory
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 12

        // CPU Monitor
        Column {
            spacing: 2
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: "CPU"
                font.pixelSize: 14
                color: "#222222"
            }

            Rectangle {
                width: 50
                height: 10
                radius: 5
                color: "#555"
                // A semi-transparent overlay to indicate usage
                Rectangle {
                    width: Hyprland.cpu.usage * 50 // Use parent's width for calculation
                    height: 10
                    radius: 5
                    color: "#fff"
                }
            }

            Text {
                text: `${Math.round(Hyprland.cpu.usage * 100)}%`
                font.pixelSize: 14
                color: "#fff"
            }
        }

        // RAM Monitor
        Column {
            spacing: 2
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: "RAM"
                font.pixelSize: 14
                color: "#222222"
            }

            Rectangle {
                width: 50
                height: 10
                radius: 5
                color: "#555"
                // A semi-transparent overlay to indicate usage
                Rectangle {
                    width: Hyprland.memory.usage * 50 // Use parent's width for calculation
                    height: 10
                    radius: 5
                    color: "#fff"
                }
            }

            Text {
                text: `${Math.round(Hyprland.memory.usage * 100)}%`
                font.pixelSize: 14
                color: "#fff"
            }
        }
    }
}
