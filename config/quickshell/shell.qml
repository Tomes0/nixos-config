//@ pragma UseQApplication

import QtQuick
import Quickshell
import "./modules/bar/"
import "./modules/overlays/"


ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: Bar {}
    }

    Loader {
        active: true
        sourceComponent: WidgetOverlay {}
    }
}