// modules/overlays/WidgetOverlay.qml
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Hyprland 


PanelWindow {
    id: overlay
    visible: false
    
    color: "transparent"
    //HyprlandWindow.opacity: 0.6

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.3)
    }

    Text {
        anchors.centerIn: parent
        text: "Overlay Active"
        color: "white"
        font.pixelSize: 48
        opacity: 0.9
    }

    Behavior on visible {
        NumberAnimation { property: "opacity"; duration: 200 }
    }

    IpcHandler {

        target: "widget-overlay" 
        
        function toggleOverlay() {
            overlay.visible = !overlay.visible
       }
    }
}