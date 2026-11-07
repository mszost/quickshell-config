import QtQuick
import qs.style

// Reusable Behavior: `Ease on x { preset: Motion.preset }`
//
// For direction-dependent timing, choose the preset from `targetValue`, which is set before
// the animation starts. A binding on the state driving the change reads a stale value:
//   Ease on radius { preset: targetValue > 0 ? Motion.settle : Motion.snap }
Behavior {
  id: root

  property var preset: Motion.standard

  Anim { preset: root.preset }
}
