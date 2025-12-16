import QtQuick

import Quickshell
import qs.Windows
// import qs.Components

import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Controls

Scope {
  Bar {}
  OsdVolume {}
  // Overview {}

  // FloatingWindow {
  //   id: window
  //
  //   Button {
  //     anchors.centerIn: parent
  //     text: grab.active ? "Remove exclusive focus" : "Take exclusive focus"
  //     onClicked: grab.active = !grab.active
  //   }
  //
  //   HyprlandFocusGrab {
  //     id: grab
  //     windows: [ window ]
  //   }
  // }
}

