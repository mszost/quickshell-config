import QtQuick
import qs.style

ColorAnimation {
  property int kind: Motion.Fade

  duration: Motion.durationFor(kind)
  easing.type: Motion.easingFor(kind)
}
