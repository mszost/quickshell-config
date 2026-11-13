// Dropdown listing a tray item's own menu entries. Submenus drill down in place, with a back row.

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import qs
import qs.style
import qs.components.menu

MenuWindow {
  id: root
  width: Config.module.tray.menuWidth
  margins: Config.module.tray.menuMargins

  required property SystemTrayItem trayItem

  // Submenu entries opened so far; the last one is displayed. Empty shows the item's root menu.
  property var stack: []

  readonly property var currentMenu: stack.length > 0 ? stack[stack.length - 1] : trayItem.menu

  // Always reopen at the root menu. Reset on open rather than close, so nothing jumps mid-animation.
  onOpenChanged: if (open) stack = []

  function trigger(entry) {
    if (entry.hasChildren) {
      stack = [...stack, entry]
      return
    }
    entry.triggered()
    close()
  }

  function back() {
    stack = stack.slice(0, -1)
  }

  QsMenuOpener {
    id: opener
    menu: root.currentMenu
  }

  MenuBlock {
    visible: root.stack.length > 0

    TrayMenuEntry {
      text: TrayService.label(root.stack[root.stack.length - 1])
      symbol: Icons.chevronLeft
      onClicked: root.back()
    }
  }

  Repeater {
    model: TrayService.groupEntries(opener.children.values)

    MenuBlock {
      id: group
      required property var modelData

      Repeater {
        model: group.modelData

        TrayMenuEntry {
          required property QsMenuEntry modelData

          text: TrayService.label(modelData)
          image: modelData.icon
          symbol: TrayService.checkSymbol(modelData)
          active: modelData.checkState === Qt.Checked
          enabled: modelData.enabled
          hasChildren: modelData.hasChildren
          onClicked: root.trigger(modelData)
        }
      }
    }
  }
}
