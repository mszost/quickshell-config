import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Controls

import qs.Services
import qs.Theme


Scope {

  FloatingWindow {
    id: window

    Column {
     anchors.centerIn:parent 
      Text { text: `wifi:  ${NetworkService.wifi}` }
    }
    
    // Button {
    //   anchors.centerIn: parent
    //   text: grab.active ? "Remove exclusive focus" : "Take exclusive focus"
    //   onClicked: grab.active = !grab.active
    // }

    // HyprlandFocusGrab {
    //   id: grab
    //   windows: [ window ]
    // }
  }
}
