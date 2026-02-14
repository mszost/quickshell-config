// Simple widget for system update reminders.

import Quickshell.Hyprland
import qs.style
import qs.components.bar

BarWidget { 
  id: root

  layoutDirection: Qt.RightToLeft
  spacing: 3
  visible: UpdatesService.shouldShowWidget

  text: UpdatesService.numUpdates
  icon: UpdatesService.symbol
  iconWeight: 600

  onClicked: UpdatesService.runCheck()
}

