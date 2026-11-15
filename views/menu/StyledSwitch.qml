// A toggle switch: a pill-shaped track that contains a sliding handle.

import QtQuick
import QtQuick.Controls
import qs
import qs.style
import qs.components

Switch {
  id: root
  implicitWidth: Config.menu.switchWidth
  implicitHeight: Config.menu.switchHandleSize + (Config.menu.switchTrackPadding * 2)
  padding: 0
  spacing: 0

  indicator: Rectangle {
    id: track
    x: root.leftPadding
    anchors.verticalCenter: parent.verticalCenter
    implicitWidth: root.availableWidth
    implicitHeight: root.availableHeight
    radius: height
    color: root.checked ? Colors.primary : Colors.surfaceDim

    Ease on color { preset: Config.menu.switchMotion }

    Rectangle {
      x: Config.menu.switchTrackPadding + root.visualPosition * (track.width - width - (Config.menu.switchTrackPadding * 2))
      anchors.verticalCenter: parent.verticalCenter
      implicitWidth: Config.menu.switchHandleSize
      implicitHeight: implicitWidth
      radius: height
      color: root.pressed ? Colors.surfaceBright : Colors.surfaceDim
      border.width: Config.menu.switchHandleBorder
      border.color: root.checked ? Colors.surfaceDim : Colors.outline

      Ease on border.color { preset: Config.menu.switchMotion }

      // Does not animate when pressed so that the cursor tracks perfectly while dragging
      Ease on x {
        enabled: !root.pressed
        preset: Config.menu.switchMotion
      }
    }
  }

  contentItem: Item {}

  HoverHandler {
    cursorShape: Qt.PointingHandCursor
  }
}
