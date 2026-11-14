pragma Singleton

import QtQuick
import Quickshell
import qs
import qs.modules.hyprland

Singleton {
  id: root

  function shouldFloat(screen) {
    if (!screen) return false
    if (Config.bar.alwaysFloating) return true
    if (!Config.bar.dynamicFloating) return false
    const tiled = HyprService.tiledWindowCount(HyprService.getWorkspaceForScreen(screen))
    return Config.bar.floatOnMultipleTiled ? tiled !== 1 : tiled === 0
  }

  function bgColor(screen) {
    const alpha = shouldFloat(screen) ? Config.bar.floatingAlpha : Config.bar.alpha
    return Qt.alpha(Config.bar.color, alpha)
  }
}
