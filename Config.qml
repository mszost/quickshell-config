pragma Singleton

import Quickshell

Singleton {
  id: root

  // See Theme/Colors.qml for available color palettes
  readonly property string theme: 'nord'

  // Global background transparency (range 0.0 - 1.0)
  readonly property real alpha: 1.0

  // Global enable/disable sound effects
  readonly property bool muteSounds: false
}
