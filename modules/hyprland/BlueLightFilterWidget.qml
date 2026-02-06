import Quickshell.Hyprland

import qs.style
import qs.components.bar

BarWidget { 
  id: root
  icon: filterState ? Icons.tabler['temperature-sun'] : Icons.tabler['sun']
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
