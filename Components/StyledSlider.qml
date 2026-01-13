import QtQuick
import QtQuick.Controls
import qs.Theme

Slider {
  id: root

  // the clickable region of the slider is thicker than it's visual height.
  implicitHeight: 20
  readonly property int visualTrackHeight: 8
  
  handle: Rectangle {
    x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
    anchors.verticalCenter: parent.verticalCenter
    // y: root.topPadding + root.availableHeight / 2 - height / 2
    implicitHeight: visualTrackHeight * 1.75
    implicitWidth: height
    radius: height
    color: root.pressed ? Colors.surfaceBright: Colors.surfaceDim
    border.width: 2
    border.color: Colors.primary
    Behavior on x { NumberAnimation { easing.type: Easing.OutBack } }
  }

  background: Rectangle {
    // y: visualTrackHeight / 2 - height / 2
    anchors.verticalCenter: parent.verticalCenter
    height: visualTrackHeight
    radius: height
    color: Colors.surfaceDim
    Behavior on width { NumberAnimation { easing.type: Easing.OutBack } }
  }

  Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    height: visualTrackHeight
    width: Math.min(Math.max(root.visualPosition * parent.width, 12), parent.width-1)
    color: Colors.primary 
    bottomLeftRadius: height
    topLeftRadius: height
    Behavior on width { NumberAnimation { easing.type: Easing.OutBack } }
  }
}

