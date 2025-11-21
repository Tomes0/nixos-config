import QtQuick
import Quickshell.Hyprland

Item {
    id: root
    implicitWidth: 100
    implicitHeight: 40

    // Background for the widget
    Rectangle {
        color: "#aa9f9f9f"
        height: 40
        radius: 20
        anchors.fill: parent
    }

    Row {
        anchors.centerIn: parent
        spacing: 8

        // Battery icon using a simple rectangle
        Rectangle {
            width: 32
            height: 16
            radius: 4
            border.width: 2
            border.color: Hyprland.battery.capacity < 15 ? "red" : "#222"
            color: "transparent"

            // The colored battery level inside
            Rectangle {
                width: parent.width * Hyprland.battery.capacity / 100
                height: parent.height
                radius: 2
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                color: Hyprland.battery.capacity > 60 ? "green" :
                       Hyprland.battery.capacity > 20 ? "orange" : "red"
            }

            // Small "cap" for the battery icon
            Rectangle {
                width: 4
                height: 8
                radius: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
                anchors.leftMargin: 2
                color: Hyprland.battery.capacity < 15 ? "red" : "#222"
            }

            // Charging indicator (lightning bolt icon)
            Text {
                visible: Hyprland.battery.status === "Charging"
                text: "⚡"
                font.pixelSize: 14
                anchors.centerIn: parent
            }
        }

        // Percentage text
        Text {
            text: `${Hyprland.battery.capacity}%`
            font.pixelSize: 18
            color: "#fff"
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
