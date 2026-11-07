import QtQuick
import qs.style

// NumberAnimation {
//   property int kind: Motion.Standard
//
//   duration: Motion.durationFor(kind)
//   easing.type: Motion.easingFor(kind)
//   easing.overshoot: Motion.overshootFor(kind)
// }

// Animates numbers and colors alike, because PropertyAnimation follows the target's type.
// Prefer `Ease` for property changes; use this inside sequences and transitions.
PropertyAnimation {
  id: root

  property var preset: Motion.standard

  duration: preset.duration
  easing.type: preset.type
  easing.overshoot: preset.overshoot
}

