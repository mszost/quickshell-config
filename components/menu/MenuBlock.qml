// Generic container for popover subsections/blocks.

import QtQuick
import qs
import qs.style
import qs.modules.core

import QtQuick.Controls 2.15

Pane {
  id: root
  width: parent.width

  property alias colSpacing: column.spacing
  property alias bgColor: bgRect.color

  background: Rectangle {
    id: bgRect
    radius: Config.menu.blockRadius
    color: Qt.alpha(Config.menu.blockBgColor, BarService.shouldFloat ? 0.7 : 1.0)
  }

  contentItem: Column {
    id: column
    spacing: 4
  }
}

