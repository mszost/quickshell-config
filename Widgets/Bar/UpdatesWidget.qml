// Simple widget for system update reminders.
// See Services/UpdatesService.qml

import Quickshell.Hyprland

import qs.Services
import qs.Components
import qs.Theme


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

