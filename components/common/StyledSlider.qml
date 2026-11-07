import QtQuick
import QtQuick.Controls
import qs
import qs.style
import qs.components.common

Slider {
  id: root
  implicitHeight: Config.menu.sliderHeight
  padding: 0

  handle: Rectangle {
    id: handleRect
    x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
    anchors.verticalCenter: parent.verticalCenter
    implicitHeight: Config.menu.sliderTrackHeight * Config.menu.sliderHandleScale
    implicitWidth: implicitHeight
    radius: height
    color: root.pressed ? Colors.surfaceBright : Colors.surfaceDim
    border.width: Config.menu.sliderHandleBorder
    border.color: Colors.primary
    
    // Does not animate when pressed so that the cursor tracks perfectly while dragging
    Ease on x {
      enabled: !root.pressed
      preset: Config.menu.sliderMotion 
    }
  }

  background: Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    height: Config.menu.sliderTrackHeight
    radius: height
    color: Colors.surfaceDim

    // Follows the handle, which ends up drawn on top of it.
    Rectangle {
      anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
      }
      width: handleRect.x + handleRect.width / 2
      topLeftRadius: parent.radius
      bottomLeftRadius: parent.radius
      color: Colors.primary
    }
  }
}
