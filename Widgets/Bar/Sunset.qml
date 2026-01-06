import QtQuick

import Quickshell.Hyprland

import qs.Components
import qs.Theme

// This widget is simple enough that i decided to forego a service file for it. 
// All it does it toggle Hyprsunset and keep track of the on/off state.

BarWidgetLite { 
  id: root
  text: filterState ? '\ueaf8' : "\ueb30"
  textFamily: Fonts.tabler.family
  textSize: 17
  onClicked: filterState = toggleFilter()

  property bool filterState: false

  function toggleFilter(): bool {
    if (filterState) {
      Hyprland.dispatch('exec killall hyprsunset');
    } else {
      Hyprland.dispatch('exec hyprsunset -t 3700');
    }
    return !filterState
  }
}
