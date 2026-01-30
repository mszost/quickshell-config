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
    wsId -= 1
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
    wsId -= 1
    const workspace = Hyprland.workspaces.values[wsId]
    return workspace?.toplevels.values.some(w => w.lastIpcObject.floating === false) ?? null
  }

  // Refreshes Quickshell when Hyprland fires an IPC event that suggests a potential change 
  // of the workspace's tiling/floating state. Because lastIpcObject does not update independently.
  // This is required for workspaceHasTiledWindows() to work properly. 
  Connections {
    target: Hyprland

    function onRawEvent(event, data) {
      if (['changefloatingmode', 'movewindow', 'openwindow'].includes(event.name)) {
        Hyprland.refreshToplevels() 
      }
    }
  }
}

