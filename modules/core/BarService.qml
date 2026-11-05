pragma Singleton

import QtQuick
import Quickshell
import qs
import qs.modules.hyprland

Singleton {
  id: root

  function shouldFloat(screen) {
    if (!screen) return false
    return Config.bar.alwaysFloating || Config.bar.dynamicFloating
      && !HyprService.isWorkspaceTiled(HyprService.getWorkspaceForScreen(screen))
  }

  function bgColor(screen) {
    const alpha = shouldFloat(screen) ? Config.bar.floatingAlpha : Config.bar.alpha
    return Qt.alpha(Config.bar.color, alpha)
  }
}
