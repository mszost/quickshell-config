import QtQuick

import Quickshell.Hyprland

import qs.Components
import qs.Theme


BarWidgetLite { 
  id: root
  text: '\ueb01'
  textFamily: Fonts.tabler.family
  textSize: 17
  onClicked: Hyprland.dispatch('exec hyprpicker') 
}

