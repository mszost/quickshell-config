import QtQuick
import Quickshell
import Quickshell.Hyprland

import qs.Theme
import qs.Theme.Icons
import qs.Components


// BarWidgetRow {
//   id: root
//   icon: '\uE140' // power icon 
//   hoverColor: Colors.red 
//   onClicked: Hyprland.dispatch('exec wlogout')
// }


// Power {
//   strokeColor: Colors.foreground
//   strokeWidth: 2
//   // implicitHeight: 35
//   // implicitWidth:35
// }

BarWidgetSvg {
  id: root
  hoverColor: Colors.red
  icon: SvgPower {
          color: animatedColor
          weight: 2.3
          implicitWidth: 18
          implicitHeight: 18
  }
  // onClicked: 
}


