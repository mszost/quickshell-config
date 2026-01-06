import Quickshell
import Quickshell.Hyprland
import QtQuick.Controls

Scope {
  FloatingWindow {
    id: window

    Button {
      anchors.centerIn: parent
      text: grab.active ? "Remove exclusive focus" : "Take exclusive focus"
      onClicked: grab.active = !grab.active
    }

    HyprlandFocusGrab {
      id: grab
      windows: [ window ]
    }
  }
}
