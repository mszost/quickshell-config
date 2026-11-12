// A dropdown window attached to a bar Widget. Foundation for all menus.

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.style
import qs.components.common
import qs.modules.core

Scope {
  id: root

  required property Item boundWidget
  property int width: Config.menu.width

  default property alias content: column.data

  readonly property QtObject barWindow: boundWidget.QsWindow.window
  readonly property var screen: barWindow?.screen ?? null
  readonly property bool shouldFloat: BarService.shouldFloat(screen)
  readonly property bool open: MenuService.activeMenu === root

  // Visually attached to the bottom of the bar, near the parent Widget's pill
  readonly property int yOffset: Config.widget.pillHeight + ((Config.bar.height - Config.widget.pillHeight) / 2)
  readonly property int xOffset: {
    const radius = shouldFloat ? Config.bar.floatingRadius : Config.bar.radius
    const margin = shouldFloat ? Config.bar.floatingMarginX : Config.bar.marginX
    return -1 * (radius + margin + Config.menu.anchorOffsetX)
  }
  readonly property int displacement: -1 * popup.implicitHeight

  function toggle() {
    MenuService.toggle(root)
  }

  function close() {
    MenuService.close(root)
  }

  PopupWindow {
    id: popup
    anchor {
      item: root.boundWidget
      gravity: Edges.Bottom | Edges.Center
      rect.y: root.yOffset
      rect.x: root.xOffset
    }
    implicitWidth: root.width
    implicitHeight: bgRect.implicitHeight
    visible: reveal.shown
    color: 'transparent'

    // The bar is included so that other widgets stay clickable while a menu is open.
    HyprlandFocusGrab {
      id: grab
      windows: root.barWindow ? [popup, root.barWindow] : [popup]
      active: root.open
      onCleared: root.close()
    }

    Reveal {
      id: reveal
      active: root.open
      enter: Config.menu.revealMotion
    }

    Rectangle {
      id: bgRect
      y: root.displacement * (1 - reveal.progress) 
      implicitWidth: parent.width
      implicitHeight: column.height + (Config.menu.margins * 2)
      bottomLeftRadius: Config.menu.radius
      bottomRightRadius: Config.menu.radius
      color: Config.menu.bgColor ?? BarService.bgColor(root.screen)
      border.color: Config.menu.borderColor
      focus: true

      Keys.onEscapePressed: root.close()

      Column {
        id: column
        anchors {
          left: parent.left
          right: parent.right
          top: parent.top
          margins: Config.menu.margins
        }
        spacing: Config.menu.contentSpacing
      }
    }
  }
}
