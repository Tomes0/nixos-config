import QtQuick

Item {
    id: root
    implicitWidth: 150
    implicitHeight: 40

    // Background for the widget
    Rectangle {
        color: "#000"
        height: 40
        radius: 20
        topLeftRadius: 0
        topRightRadius: 0
        anchors.fill: parent
    }

    Column {
        anchors.centerIn: parent
        spacing: 2
        
        Text {
            id: timeText
            text: "Loading..."
            font.pixelSize: 18
            color: "#fff"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: dateText
            text: "Loading..."
            font.pixelSize: 14
            color: "#eee"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // Timer to update the clock every second
    Timer {
        id: clockTimer
        interval: 1000
        repeat: true
        running: true

        onTriggered: {
            const now = new Date()
            timeText.text = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
            dateText.text = now.toLocaleDateString([], { weekday: 'short', month: 'short', day: 'numeric' })
        }
    }
}
