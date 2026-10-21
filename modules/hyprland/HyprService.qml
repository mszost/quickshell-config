pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
  id: root

  function isWorkspaceOccupied(wsId: int): bool {
    for (let i = 0; i < Hyprland.workspaces.values.length; ++i) {
      if (Hyprland.workspaces.values[i].id === wsId) {
        return Hyprland.workspaces.values[i].toplevels.values.length > 0;
      }
    }
    return false;
  } 

  function isWorkspaceTiled(wsId: int): bool {
    for (let i = 0; i < Hyprland.workspaces.values.length; ++i) {
      if (Hyprland.workspaces.values[i].id === wsId) {
        return Hyprland.workspaces.values[i].toplevels.values.some(w => w.lastIpcObject.floating === false);
      }
    }
    return false;
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

  // Get the number of open windows (any workspace) belonging to a DesktopEntry
  function windowCountForApp(entry: DesktopEntry): int {
    if (!entry) return 0
    const classes = [entry.id, entry.startupClass].filter(c => c).map(c => c.toLowerCase())
    return Hyprland.toplevels.values.filter(
      t => classes.includes((t.lastIpcObject.class ?? '').toLowerCase())
    ).length
  }

  // Desktop ids of apps that have an open window but aren't in `pinnedIds`,
// in the order their windows appear in Hyprland's toplevel list.
function unpinnedOpenApps(pinnedIds: var): var {
  const result = []
  for (const t of Hyprland.toplevels.values) {
    const cls = (t.lastIpcObject.class ?? '').toLowerCase()
    if (!cls) continue
    const entry = DesktopEntries.applications.values.find(
      e => [e.id, e.startupClass].some(c => c && c.toLowerCase() === cls)
    )
    if (!entry || pinnedIds.includes(entry.id) || result.includes(entry.id)) continue
    result.push(entry.id)
  }
  return result
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

