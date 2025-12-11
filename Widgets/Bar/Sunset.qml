import QtQuick
import Quickshell.Hyprland

import qs.Components

// This widget is simple enough that i decided to forego a service file for it. 
// All it does it toggle Hyprsunset and keep track of the on/off state.

BarWidget { 
  id: root
  text: filterState ? "" : ""
  onClicked: filterState = toggleFilter()

  property bool filterState: false

  function toggleFilter(): bool {
    if (filterState) {
      Hyprland.dispatch('exec killall hyprsunset');
      return false;
    } else {
      Hyprland.dispatch('exec hyprsunset -t 3700');
      return true;
    }
  }
}

