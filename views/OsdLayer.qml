import QtQuick
import Quickshell

import qs
import qs.modules.audio
import qs.components.common

Scope {
  id: root

  OnScreenDisplay {
    label: 'Volume'
    level: AudioService.volume
    icon: AudioService.symbol
    shouldShowOsd: !GlobalStates.menuAudioIsOpen
  }
}

