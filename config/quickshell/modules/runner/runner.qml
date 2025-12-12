import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Scope {
    HyprlandFocusGrab {
        id: grab
        windows: [ window ]
    }

    PanelWindow {
        color: "transparent"
        id: window
        anchors {
            top: true
            left: true
            right: true
            bottom: true
        }
        focusable: true
        onVisibleChanged: {
            if (window.visible)
            {
                grab.active = true
                searchInput.forceActiveFocus()
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }

        Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0)

            Rectangle {
                id: mainRect
                implicitHeight: 400
                implicitWidth: 600
                anchors.centerIn: parent
                color: "#282a36"
                radius: 12
                border.color: '#828282'
                border.width: 1

                // Prevent click propagation to background
                MouseArea {
                    anchors.fill: parent
                    onClicked: {}
                }

                Rectangle {
                    id: searchBar
                    anchors {
                        top: mainRect.top
                        left: mainRect.left
                        right: mainRect.right
                        margins: 15
                    }
                    height: 70
                    color: '#6272a4'
                    radius: 8

                    TextInput {
                        id: searchInput
                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            margins: 15
                        }
                        clip: true
                        height: 70
                        font.pixelSize: 35
                        font.family: "JetBrains Mono"
                        color: "#f8f8f2"
                    }
                }


                ListView {
                    id: appList
                    anchors {
                        top: searchBar.bottom
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                        margins: 15
                    }
                    clip: true
                    spacing: 10

                    //readonly property list<DesktopEntry> list: 

                    model: Array.from(DesktopEntries.applications.values)
                    .filter(entry => {
                        if (searchInput.text === "") {
                            return true;
                        }
                        if (entry.noDisplay) {
                            return false;
                        }

                        const searchLower = searchInput.text.toLowerCase();
                        return entry.name.toLowerCase().includes(searchLower) ||
                               entry.execString.toLowerCase().includes(searchLower);
                    })
                    //.sort((a, b) => a.name.localeCompare(b.name))

                    delegate: Item {
                        required property var modelData
                        required property var index
                        width: appList.width
                        height: 50

                        Rectangle {
                            height: parent.height
                            width: parent.width
                            color: '#343d58'
                            radius: 5
                            MouseArea {
                                id: appButton
                                anchors.fill: parent
                                onClicked: 
                                {
                                    Hyprland.dispatch("exec " + modelData.command)
                                    Qt.quit()
                                }

                                Rectangle {
                                    id: icon
                                    width: 40
                                    height: 40
                                    anchors.left: appButton.left
                                    anchors.verticalCenter: appButton.verticalCenter
                                    anchors.leftMargin: 10
                                    anchors.rightMargin: 10
                                    color: "transparent"

                                    Loader {
                                        active: !!modelData.icon
                                        sourceComponent: Image {
                                            id: appIcon
                                            source: Quickshell.iconPath(modelData.icon, true)
                                            width: 40
                                            height: 40
                                            asynchronous: true

                                        }
                                    }
                                    Loader {
                                        active: !modelData.icon
                                        sourceComponent: Rectangle {
                                            id: iconPlaceholder
                                            width: parent.width
                                            height: parent.height
                                            color: "white"
                                        }
                                    }
                                }

                                Text {
                                    id: itemText
                                    width: 500
                                    clip: true
                                    text: modelData.name
                                    color: "white"
                                    font.pixelSize: 20
                                    anchors {
                                        left: icon.right
                                        verticalCenter: appButton.verticalCenter
                                        verticalCenterOffset: -10
                                        leftMargin: 10
                                        rightMargin: 10
                                    }
                                }

                                Text {
                                    id: execText
                                    width: 500
                                    clip: true
                                    text: modelData.execString
                                    color: "#bbbbbb"
                                    font.pixelSize: 14
                                    anchors {
                                        leftMargin: 10
                                        rightMargin: 10
                                        top: itemText.bottom
                                        left: icon.right
                                    }
                                }
                            }

                        }

                    }
                }
            }


            Keys.onPressed: (event) => {
            switch (event.key) {
            case Qt.Key_Escape:
            Qt.quit()
            break;
        }


    }



}
}
}