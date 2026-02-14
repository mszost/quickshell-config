pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
  id: root

  // Provides fast lookup for workspace-related functions. 
  // Building this is expensive, but it is reevaluated far less
  // frequently than function calls are made, so it's worth it.
  readonly property var _wsCache: {
    const occupied = new Set()
    const tiled = new Set()
    for (const ws of Hyprland.workspaces.values) {
      if (ws.toplevels.values.length > 0) {
        occupied.add(ws.id)
        if (ws.toplevels.values.some(w => w.lastIpcObject.floating === false)) {
          tiled.add(ws.id)
        }
      }
    }
    return { occupied, tiled }
  }

  function isWsOccupied(wsId: int): bool {
    return _wsCache.occupied.has(wsId)
  } 

  function isWsTiled(wsId: int): bool {
    return _wsCache.tiled.has(wsId)
  }
  
  function isWsFocused(wsId: int): bool {
    return wsId === Hyprland.focusedWorkspace?.id ?? false
  }
  
  // Accpets an instance of Quickshell.ShellScreen or an integer corresponding to an index in the Hyprland monitors list.
  function getWsForScreen(screen): bool {
    if (typeof screen === 'object') {
      return Hyprland.monitorFor(screen).activeWorkspace?.id ?? null
    } 
    else if (typeof screen === 'number') {
      return Hyprland.monitors.values[screen].activeWorkspace?.id ?? 0
    }
  }

  function isScreenOccupied(screen): bool {
    return isWsOccupied(getWsForScreen(screen))
  }

  readonly property string focusedWindowTitle: Hyprland.activeToplevel?.title ?? ''

  // Refreshes Quickshell's window tracking when Hyprland fires an IPC event that suggests 
  // a potential change of the tiled/floating state of a workspace. Because lastIpcObject 
  // does not update independently, this is required for isWsTiled() to work properly. 
  Connections {
    target: Hyprland

    function onRawEvent(event, data) {
      if (['changefloatingmode', 'movewindow', 'openwindow'].includes(event.name)) {
        Hyprland.refreshToplevels() 
      }
    }
  }
}

