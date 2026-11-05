// A dropdown/popover window that serves as foundation for menus.

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style
import qs.modules.core
import qs.components.bar

Scope {
  id: root

  required property Widget boundWidget
  required property string module
  required property int width

  default property alias content: column.data
  readonly property var screen: QsWindow.window?.screen ?? null
  
  // Visually attached to the bottom of the bar, near the parent Widget's pill
  readonly property int yOffset: Config.widget.pillHeight + ((Config.bar.height - Config.widget.pillHeight) / 2)

  readonly property int xOffset: -1 * (Config.bar.floatingRadius + Config.bar.floatingMarginX + 10)

  readonly property int displacement: -1 * popup.implicitHeight

  property bool open: false
  
  property real revealProgress: open ? 1 : 0
  Behavior on revealProgress { NumberAnimation { easing.type: Easing.InOutCirc; duration: 150 } }

  PopupWindow {
    id: popup
    anchor {
      item: root.boundWidget
      // edges: Edges.Center
      gravity: Edges.Bottom | Edges.Center
      rect.y: root.yOffset
      rect.x: root.xOffset
    }
    implicitWidth: root.width
    implicitHeight: bgRect.implicitHeight
    color: 'transparent'//Qt.alpha('lime', 0.1)

    visible: open || root.revealProgress > 0

    HyprlandFocusGrab {
      id: grab
      windows: [popup]
      active: root.open
      onActiveChanged: { if (!active) root.open = false }
    }

    Rectangle {
      id: bgRect
      implicitWidth: parent.width
      implicitHeight: column.height + (Config.menu.margins * 2)
      bottomLeftRadius: Config.menu.radius
      bottomRightRadius: Config.menu.radius
      color: Config.menu.bgColor ?? BarService.bgColor(screen) 
      border.color: Colors.outline

      y: displacement * (1-revealProgress)
      
      focus: true 
      Keys.onEscapePressed: root.open = false

      Column {
        id: column
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: Config.menu.margins
        }
        spacing: 10 * Config.globalUiScale
      }
    }
  }
}

