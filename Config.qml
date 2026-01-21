pragma Singleton

import Quickshell

Singleton {
  id: root

  // See Theme/Colors.qml
  readonly property string theme: 'nord'

  // Background transparency (range 0.0 - 1.0)
  readonly property real alpha: 1.0
}
