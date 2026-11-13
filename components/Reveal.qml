import QtQuick
import qs.style

// Drives an element that opens and closes. `progress` runs from 0 (closed) to 1 (open),
// and `shown` stays true until the closing animation finishes.
QtObject {
  id: root

  property bool active: false
  property var enter: Motion.standard
  property var exit: enter

  property real progress: active ? 1 : 0
  Ease on progress { preset: targetValue > 0 ? root.enter : root.exit }

  readonly property bool shown: active || progress > 0
}
