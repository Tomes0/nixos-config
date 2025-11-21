import QtQuick
import Quickshell
import "../widgets/"

PanelWindow {
    id: mainPanel

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 48

    margins {
        top: 0
        left: 0
        right: 0
    }

    color: '#aa000000'

    
    Loader {
        anchors.left: parent.left
        active: true
        sourceComponent: Workspaces {}
    }

    Loader {
        anchors.horizontalCenter: parent.horizontalCenter
        active: true
        sourceComponent: ClockWidget {}
    }
}
