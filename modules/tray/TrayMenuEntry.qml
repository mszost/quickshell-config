// A single row in a TrayMenu. Unlike MenuRow, it spans the block's width, and supports app-supplied
// image icons, check/radio state, disabled entries and a submenu indicator.

import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs
import qs.style

MouseArea {
  id: root
  width: parent.width
  implicitHeight: layout.implicitHeight
  hoverEnabled: true
  cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

  required property string text
  property string image: ''        // Icon path/url supplied by the app
  property string symbol: ''       // Tabler glyph, e.g. a checkbox state; shown in place of `image`
  property bool active: false
  property bool hasChildren: false

  readonly property color textColor: {
    if (!enabled) return Qt.alpha(Colors.mOnSurfaceVariant, Config.module.tray.disabledEntryAlpha)
    if (containsMouse) return Colors.secondary
    if (active) return Colors.mOnSurface
    return Colors.mOnSurfaceVariant
  }

  RowLayout {
    id: layout
    anchors { left: parent.left; right: parent.right }
    spacing: Config.menu.rowSpacing

    Text {
      visible: root.symbol !== ''
      text: root.symbol
      font: Config.menu.itemIconFont
      color: root.textColor
    }

    IconImage {
      visible: root.symbol === '' && root.image !== ''
      implicitSize: Config.module.tray.entryIconSize
      source: root.image
      opacity: root.enabled ? 1 : Config.module.tray.disabledEntryAlpha
    }

    Text {
      Layout.fillWidth: true
      text: root.text
      textFormat: Text.PlainText
      elide: Text.ElideRight
      font: Config.menu.itemFont
      color: root.textColor
    }

    Text {
      visible: root.hasChildren
      text: Icons.chevronRight
      font: Config.menu.itemIconFont
      color: root.textColor
    }
  }
}
