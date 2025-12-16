import QtQuick

import Quickshell
import Quickshell.Hyprland

import qs.Theme
import qs.Components


BarWidgetLite {
  id: root
  // text: '\uEB0D' // tabler
  text: '\uE140' // lucide
  textFamily: Fonts.lucide.family
  textSize: Fonts.lucide.pixelSize
  hoverColor: Colors.red 
  onClicked: console.log('SessionWidget clicked!')//Hyprland.dispatch('')


}

