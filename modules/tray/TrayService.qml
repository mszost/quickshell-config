pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import qs

// Exposes StatusNotifier (system tray) items and the logic for interacting with them and their menus.
Singleton {
  id: root

  readonly property QtObject cfg: Config.module.tray

  readonly property var items: SystemTray.items.values.filter(item =>
    !cfg.blacklist.includes(item.id)
    && !(cfg.hidePassive && item.status === Status.Passive)
  )

  // Some apps ship icons from a private directory, reported as `image://icon/<name>?path=<dir>`,
  // which the icon provider can't resolve. Point straight at the file instead.
  function iconSource(item) {
    const icon = item?.icon ?? ''
    if (!icon.includes('?path=')) return icon
    const [name, path] = icon.split('?path=')
    return `file://${path}/${name.slice(name.lastIndexOf('/') + 1)}`
  }

  function actionFor(button) {
    if (button === Qt.RightButton) return cfg.rightClick
    if (button === Qt.MiddleButton) return cfg.middleClick
    return cfg.leftClick
  }

  // Runs the configured action for a mouse button on a tray item. `menu` is the item's MenuWindow.
  function handleClick(item, button, menu) {
    let action = actionFor(button)
    if (action === 'menu' && !item.hasMenu) action = 'activate'
    if (action === 'activate' && item.onlyMenu && item.hasMenu) action = 'menu'

    if (action === 'menu') {
      menu.toggle()
      return
    }
    menu.close()
    if (action === 'activate') item.activate()
    else if (action === 'secondary') item.secondaryActivate()
  }

  function scroll(item, wheelEvent) {
    const horizontal = wheelEvent.angleDelta.x !== 0
    item.scroll(horizontal ? wheelEvent.angleDelta.x : wheelEvent.angleDelta.y, horizontal)
  }

  // Splits a menu's entries into groups at each separator, so each group can render as its own block.
  function groupEntries(entries) {
    const groups = [[]]
    for (const entry of entries) {
      if (entry.isSeparator) groups.push([])
      else groups[groups.length - 1].push(entry)
    }
    return groups.filter(group => group.length > 0)
  }

  // dbusmenu labels mark keyboard mnemonics with underscores (`_File`), and `__` is a literal underscore.
  function label(entry) {
    return (entry?.text ?? '').replace(/_(.)/g, '$1')
  }

  function checkSymbol(entry) {
    const checked = entry.checkState === Qt.Checked
    if (entry.buttonType === QsMenuButtonType.CheckBox) return checked ? Icons.squareCheck : Icons.square
    if (entry.buttonType === QsMenuButtonType.RadioButton) return checked ? Icons.circleDot : Icons.circle
    return ''
  }
}
