import QtQuick
import qs.style

// Animates numbers and colors alike, because PropertyAnimation follows the target's type.
// Prefer `Ease` for property changes; use this inside sequences and transitions.
PropertyAnimation {
  id: root

  property var preset: Motion.standard

  // Fall back to the default if a preset name is undefined.
  readonly property var resolved: {
    if (preset) return preset
    console.warn("Anim: undefined preset, using Motion.standard")
    return Motion.standard
  }

  duration: resolved.duration
  easing.type: resolved.type
  easing.overshoot: resolved.overshoot
}

