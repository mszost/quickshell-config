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

  // Get every open window (any workspace) belonging to a DesktopEntry.
  // Uses entryForClass() so windows are matched the same way everywhere.
  function windowsForApp(entry: DesktopEntry): var {
    if (!entry) return []
    return Hyprland.toplevels.values.filter(
      t => entryForClass(t.lastIpcObject.class)?.id === entry.id
    )
  }

  // Get the number of open windows (any workspace) belonging to a DesktopEntry.
  function windowCountForApp(entry: DesktopEntry): int {
    return windowsForApp(entry).length
  }

  // Whether a window lives on a special (scratchpad) workspace. Special workspaces have negative ids.
  function isOnSpecialWorkspace(toplevel: HyprlandToplevel): bool {
    return (toplevel?.workspace?.id ?? toplevel?.lastIpcObject.workspace?.id ?? 0) < 0
  }

  // Whether a window currently has keyboard focus. `activated` is only set by focus-change
  // events, so it's unknown until focus first changes after startup; Hyprland's focus history covers that gap.
  function isWindowFocused(toplevel: HyprlandToplevel): bool {
    return (toplevel?.activated || toplevel?.lastIpcObject.focusHistoryID === 0) ?? false
  }

  // Returns a copy of `toplevels` ordered from most to least recently focused.
  // Windows without a reported focus history are placed last.
  function sortByFocusHistory(toplevels: var): var {
    const rank = t => t.lastIpcObject.focusHistoryID ?? Number.MAX_SAFE_INTEGER
    return Array.from(toplevels).sort((a, b) => rank(a) - rank(b))
  }

  // Moves keyboard focus to a window, switching workspace/monitor (or revealing its special workspace) as needed.
  function focusWindow(toplevel: HyprlandToplevel) {
    if (!toplevel?.address) return
    const selector = windowSelector(toplevel)
    // Lua configs evaluate dispatch requests as Lua; hyprlang configs use the classic dispatcher syntax.
    Hyprland.dispatch(Hyprland.usingLua
      ? `hl.dsp.focus({ window = "${selector}" })`
      : `focuswindow ${selector}`)
  }

  // Hyprland window selector string that uniquely targets a window, e.g. "address:0x55c4c1423f40"
  function windowSelector(toplevel: HyprlandToplevel): string {
    return `address:0x${toplevel.address.replace(/^0x/, '')}`
  }

  readonly property string focusedWindowTitle: Hyprland.activeToplevel?.title ?? ''

  // Refreshes Quickshell's window tracking when Hyprland fires an IPC event that suggests
  // a potential change of the tiled/floating state of a workspace, or of the window focus order.
  // Because lastIpcObject does not update independently, this is required for
  // isWorkspaceTiled() and sortByFocusHistory() to work properly.
  Connections {
    target: Hyprland

    function onRawEvent(event, data) {
      if (['changefloatingmode', 'movewindow', 'openwindow', 'activewindowv2'].includes(event.name)) {
        Hyprland.refreshToplevels() 
      }
    }
  }
}

