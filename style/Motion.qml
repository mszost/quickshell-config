pragma Singleton

import Quickshell
import QtQuick
import qs

Singleton {
  function curve(ms, type, overshoot=1.70158) {
    return { duration: ms * Config.globalAnimationSpeed, type, overshoot }
  }

  readonly property var standard: curve(200, Easing.InOutQuad)
  readonly property var fade: curve(300, Easing.InOutQuad)  // mostly used for changing alpha/opacities
}
