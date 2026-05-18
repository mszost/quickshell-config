// Generic container for panel blocks. Base for PanelTitle, PanelSlider,
// or can be used on its own for components that require more flexibility.

import QtQuick
import qs
import qs.style

import QtQuick.Controls 2.15

Pane {
  id: root
  width: parent.width
  padding: 12

  property alias colSpacing: column.spacing

  background: Rectangle {
    radius: 12
    color: Colors.alpha(Colors.background, Config.panelBlockAlpha)
  }

  contentItem: Column {
    id: column
    width: root.availableWidth
    spacing: 4
  }
}

