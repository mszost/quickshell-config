// A clickable row with an icon and a label, for lists of options within a MenuBlock.

import QtQuick
import Quickshell.Widgets
import qs
import qs.style
import qs.components.common

WrapperMouseArea {
  id: root
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  required property string icon
  required property string text
  property bool active: false

  property color textColor: {
    if (containsMouse) return Colors.secondary
    if (active) return Colors.mOnSurface
    return Colors.mOnSurfaceVariant
  }
  // Behavior on textColor { ColorAnim {} }

  Row {
    spacing: Config.menu.rowSpacing

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.icon
      font: Config.menu.itemIconFont
      color: root.textColor
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.text
      font: Config.menu.itemFont
      color: root.textColor
    }
  }
}
