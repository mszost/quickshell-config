// Generic container for menu subsections, with an optional label.

import QtQuick
import QtQuick.Controls
import Quickshell
import qs
import qs.style

Pane {
  id: root
  width: parent.width
  padding: Config.menu.blockPadding
  spacing: Config.menu.blockSpacing

  property string label: ''

  background: Rectangle {
    radius: Config.menu.blockRadius
    color: Qt.alpha(Config.menu.blockBgColor, root.QsWindow.window?.shouldFloat ? Config.menu.blockFloatingAlpha : Config.menu.blockAlpha)
  }

  contentItem: Column {
    spacing: root.spacing

    Text {
      visible: root.label !== ''
      text: root.label
      font: Config.menu.labelFont
      color: Colors.primary
    }
  }
}
