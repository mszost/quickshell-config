import QtQuick
import Quickshell
import qs
import qs.Services
import qs.Components

Scope {
  id: root

  OnScreenDisplay {
    level: AudioService.volume
    icon: AudioService.symbol
    shouldShowOsd: !GlobalStates.audioMenuOpen
  }
}

