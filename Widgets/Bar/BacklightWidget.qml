import Quickshell.Hyprland

import qs.Components
import qs.Theme

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
