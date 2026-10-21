import QtQuick
import qs.style

NumberAnimation {
  property int kind: Motion.Standard

  duration: Motion.durationFor(kind)
  easing.type: Motion.easingFor(kind)
  easing.overshoot: Motion.overshootFor(kind)
}
