pragma Singleton

import QtQuick
import Quickshell
import qs
import qs.components.common

Singleton {
  enum Kind { Standard, Snap, Fade, Bounce, Liquid }
  // Bounce/Firm: fast bounceyness with shallow overshoot
  // Liquid: slow bouncyness with deeper overshoot

  property real scale: Config.globalAnimationSpeed

  readonly property int veryFast: 50
  readonly property int fast: 100 * scale
  readonly property int normal: 200 * scale
  readonly property int slow: 300 * scale
  readonly property int verySlow: 420 * scale
  readonly property int turtle: 1200 * scale

  function durationFor(kind) {
    switch (kind) {
    case Motion.Snap:     return fast;
    case Motion.Fade:     return fast;
    case Motion.Bounce:   return slow;
    case Motion.Liquid:   return turtle;
    default:              return normal;
    }
  }

  function easingFor(kind) {
    switch (kind) {
      case Motion.Snap:     return Easing.OutCubic;
      case Motion.Bounce:   return Easing.OutBack;
      case Motion.Liquid:   return Easing.InOutBack
      default:              return Easing.InOutQuad;
    }
  }

  function overshootFor(kind) {
    switch (kind) {
      case Motion.Bouncy: return 2.8;
      case Motion.Liquid: return 3.5;
      default:            return 1.70158; // 1.70158 is Qt's default
    }
  }
}
