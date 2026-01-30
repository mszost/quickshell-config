pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland


Singleton {
  id: root

  readonly property string focusedWindowTitle: Hyprland.activeToplevel?.title ?? ''
  // readonly property bool focusedWorkspaceOccupied: isWorkspaceOccupied(Hyprland.focusedWorkspace?.id ?? -1)
  
  // Accpets an instance of Quickshell.ShellScreen or an integer corresponding to the monitor ID in Hyprland
  function getWsForScreen(screen) {
    if (typeof screen === 'object') {
      return Hyprland.monitorFor(screen).activeWorkspace?.id ?? null
    } 
    else if (typeof screen === 'number') {
      return Hyprland.monitors.values[screen].activeWorkspace?.id ?? 0
    }
  }

  function isWsOccupied(wsId: int): bool {
    const windowsOnThisWorkspace = Hyprland.workspaces.values[wsId]?.toplevels.values ?? []
    return windowsOnThisWorkspace.length > 0 
  }  

  function isWsFocused(wsId: int): bool {
    return wsId === Hyprland.focusedWorkspace?.id ?? false
  }


  function isScreenOccupied(screen) {
    return isWsOccupied(getWsForScreen(screen))
  }

  // True if the workspace has a tiled window present on it
  function isWsTiled(wsId: int): bool {
    const workspace = Hyprland.workspaces.values[wsId]
    return workspace?.toplevels.values.some(w => w.lastIpcObject.floating === false) ?? null
  }

  // Refreshes Quickshell when a window's floating/tiled state is changed,
  // because lastIpcObject does not update on it's own. This is required for
  // workspaceHasTiledWindows() to work properly. 
  Connections {
    target: Hyprland

    function onRawEvent(event, data) {
      // 'movewindow' fires when a window moves to a new workspace (which may change the window's tiled status)
      if (event.name  === 'changefloatingmode' || event.name  === 'movewindow') {
        Hyprland.refreshToplevels() 
      }
    }
  }
}

