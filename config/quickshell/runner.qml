import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.System

// The Root Scope
Scope {
    // Defines the floating window
    ShellWindow {
        id: window
        
        // Window Configuration
        width: 600
        height: 400
        
        // Anchor to center of the screen
        anchors {
            center: true
        }

        // Close on start? No, but we want it to close if we click outside usually.
        // For a runner, we usually keep it open until ESC is pressed.

        color: "transparent"

        // The background container
        Rectangle {
            anchors.fill: parent
            color: "#282a36" // Dark background
            radius: 12
            border.color: "#bd93f9" // Purple border
            border.width: 2
            clip: true

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                // --- SEARCH BAR ---
                Rectangle {
                    Layout.fillWidth: true
                    height: 50
                    color: "#44475a"
                    radius: 8

                    TextInput {
                        id: searchInput
                        anchors.fill: parent
                        anchors.margins: 15
                        verticalAlignment: TextInput.AlignVCenter
                        
                        font.pixelSize: 20
                        font.family: "JetBrains Mono" // Or any monospace font
                        color: "#f8f8f2"
                        
                        text: ""
                        focus: true // Grab focus on launch

                        // Placeholder text
                        Text {
                            anchors.fill: parent
                            text: "Run command..."
                            color: "#6272a4"
                            visible: !searchInput.text && !searchInput.inputMethodComposing
                            font: searchInput.font
                            verticalAlignment: TextInput.AlignVCenter
                        }

                        // Key Handling
                        Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_Down) {
                                appList.incrementCurrentIndex();
                            } else if (event.key === Qt.Key_Up) {
                                appList.decrementCurrentIndex();
                            } else if (event.key === Qt.Key_Escape) {
                                Qt.quit();
                            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                // If list has focus/selection, run that. 
                                // Otherwise run raw text.
                                if (appList.count > 0) {
                                    launcher.execute(appsModel.get(appList.currentIndex).exec)
                                } else {
                                    launcher.execute(searchInput.text)
                                }
                            }
                        }
                        
                        onTextChanged: {
                            // Simple filter logic
                            // In a real app, you'd reload the model here
                            appsModel.updateFilter(text)
                            appList.currentIndex = 0
                        }
                    }
                }

                // --- RESULTS LIST ---
                ListView {
                    id: appList
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    
                    model: appsModel
                    spacing: 5

                    highlight: Rectangle {
                        color: "#bd93f9"
                        radius: 5
                        opacity: 0.8
                    }
                    highlightMoveDuration: 100

                    delegate: Item {
                        width: ListView.view.width
                        // height: 40  <-- Removed this duplicate assignment
                        
                        // Visibility check for filtering
                        visible: model.visible
                        height: visible ? 40 : 0

                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            
                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 10
                                spacing: 10

                                // App Icon (Using a placeholder shape or text)
                                Rectangle {
                                    width: 24
                                    height: 24
                                    radius: 4
                                    color: model.colorCode
                                }

                                Text {
                                    text: model.name
                                    color: ListView.isCurrentItem ? "#282a36" : "#f8f8f2"
                                    font.pixelSize: 16
                                    font.bold: true
                                    Layout.fillWidth: true
                                }
                                
                                Text {
                                    text: model.exec
                                    color: ListView.isCurrentItem ? "#44475a" : "#6272a4"
                                    font.pixelSize: 12
                                    Layout.alignment: Qt.AlignRight
                                    Layout.rightMargin: 10
                                }
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: appList.currentIndex = index
                                onClicked: launcher.execute(model.exec)
                            }
                        }
                    }
                }
            }
        }
    }

    // --- LOGIC & DATA ---

    // 1. Process Executor
    // We use a helper object to spawn processes
    QtObject {
        id: launcher
        
        function execute(cmd) {
            console.log("Executing:", cmd)
            
            // In Quickshell, we use the Process service
            // This is a simplified way to just spawn a detached process
            var proc = System.execute(cmd)
            
            Qt.quit() // Close the runner
        }
    }

    // 2. Data Model
    // In a production app, you would parse /usr/share/applications/*.desktop
    // For this prototype, we hardcode a list + simple search filter
    ListModel {
        id: appsModel
        
        // Initial Data Loading
        Component.onCompleted: {
            append({ name: "Firefox", exec: "firefox", colorCode: "#ff5555", visible: true })
            append({ name: "Terminal", exec: "kitty", colorCode: "#50fa7b", visible: true }) // Adjust 'kitty' to your terminal
            append({ name: "File Manager", exec: "thunar", colorCode: "#f1fa8c", visible: true }) // Adjust 'thunar'
            append({ name: "Discord", exec: "discord", colorCode: "#8be9fd", visible: true })
            append({ name: "VS Code", exec: "code", colorCode: "#bd93f9", visible: true })
            append({ name: "Spotify", exec: "spotify", colorCode: "#ff79c6", visible: true })
        }

        function updateFilter(query) {
            for(var i = 0; i < count; i++) {
                var item = get(i);
                if (query === "") {
                    setProperty(i, "visible", true);
                } else {
                    var match = item.name.toLowerCase().includes(query.toLowerCase()) || 
                                item.exec.toLowerCase().includes(query.toLowerCase());
                    setProperty(i, "visible", match);
                }
            }
        }
    }
}