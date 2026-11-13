pragma Singleton

import QtQuick
import Quickshell

// Tracks the open menu. Only one can be open at a time, across all screens.
Singleton {
  id: root

  property QtObject activeMenu: null

  function toggle(menu) {
    activeMenu = activeMenu === menu ? null : menu
  }

  function close(menu) {
    if (activeMenu === menu) activeMenu = null
  }

  function closeActive() {
    activeMenu = null
  }

  function isOpenOn(screen) {
    return activeMenu !== null && activeMenu.screen === screen
  }
}
