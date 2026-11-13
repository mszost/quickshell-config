pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
  id: root

  function workspaceById(wsId: int): HyprlandWorkspace {
    return Hyprland.workspaces.values.find(ws => ws.id === wsId) ?? null
  }

  function isWorkspaceOccupied(wsId: int): bool {
    return (workspaceById(wsId)?.toplevels.values.length ?? 0) > 0
  }

  function isWorkspaceTiled(wsId: int): bool {
    return workspaceById(wsId)?.toplevels.values.some(w => w.lastIpcObject.floating === false) ?? false
  }
  
  function isWorkspaceFocused(wsId: int): bool {
    return wsId === (Hyprland.focusedWorkspace?.id ?? 0)
  }
  
  // Accepts an instance of Quickshell.ShellScreen or an integer corresponding to an index in the Hyprland monitors list.
  function getWorkspaceForScreen(screen): int {
    if (typeof screen === 'object') {
      return Hyprland.monitorFor(screen).activeWorkspace?.id ?? 0
    } 
    else if (typeof screen === 'number') {
      return Hyprland.monitors.values[screen]?.activeWorkspace?.id ?? 0
    }
    return 0
  }

  function isScreenOccupied(screen): bool {
    return isWorkspaceOccupied(getWorkspaceForScreen(screen))
  }

  // Get the corresponding DesktopEntry object for a window
  function entryForClass(windowClass: string): DesktopEntry {
    if (!windowClass) return null
    const wanted = windowClass.toLowerCase()
    return DesktopEntries.applications.values.find(
      e => e.id.toLowerCase() === wanted || (e.startupClass ?? '').toLowerCase() === wanted
    ) ?? DesktopEntries.heuristicLookup(windowClass) ?? null
  }

  // Get the number of open windows (any workspace) belonging to a DesktopEntry.
  // Uses entryForClass() so windows are matched the same way everywhere.
  function windowCountForApp(entry: DesktopEntry): int {
    if (!entry) return 0
    return Hyprland.toplevels.values.filter(
      t => entryForClass(t.lastIpcObject.class)?.id === entry.id
    ).length
  }

  readonly property string focusedWindowTitle: Hyprland.activeToplevel?.title ?? ''

  // Refreshes Quickshell's window tracking when Hyprland fires an IPC event that suggests 
  // a potential change of the tiled/floating state of a workspace. Because lastIpcObject 
  // does not update independently, this is required for isWorkspaceTiled() to work properly. 
  Connections {
    target: Hyprland

    function onRawEvent(event, data) {
      if (['changefloatingmode', 'movewindow', 'openwindow'].includes(event.name)) {
        Hyprland.refreshToplevels() 
      }
    }
  }
}

