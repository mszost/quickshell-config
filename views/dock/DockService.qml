pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.modules.hyprland

Singleton {
  id: root

  readonly property QtObject cfg: Config.dock

  // Desktop ids of apps with an open window that aren't pinned or blacklisted,
  // in the order their windows appear in Hyprland's toplevel list.
  readonly property list<string> unpinnedOpenApps: {
    const seen = new Set()
    for (const toplevel of Hyprland.toplevels.values) {
      const entry = HyprService.entryForClass(toplevel.lastIpcObject.class)
      if (entry && !cfg.pinnedApps.includes(entry.id) && !cfg.blacklistedApps.includes(entry.id)) {
        seen.add(entry.id)
      }
    }
    return Array.from(seen)
  }

  // Whether the dock should exist on a given ShellScreen
  function isEnabledOn(screen): bool {
    if (!screen) return false
    return cfg.monitors.includes('*') || cfg.monitors.includes(screen.name)
  }

  // Whether the dock should auto-hide on a given ShellScreen (ignoring hover)
  function shouldHide(screen): bool {
    if (!cfg.dynamicHiding || !screen) return false
    const wsId = HyprService.getWorkspaceForScreen(screen)
    return HyprService.isWorkspaceTiled(wsId) || !HyprService.isWorkspaceFocused(wsId)
  }

  function entryForId(id: string): DesktopEntry {
    return DesktopEntries.applications.values.find(e => e.id === id) ?? null
  }

  function windowCount(entry: DesktopEntry): int {
    return HyprService.windowCountForApp(entry)
  }

  // Starts a new instance of the app, regardless of whether one is already running
  function launch(entry: DesktopEntry) {
    entry?.execute()
  }

  // Primary action: focus one of the app's windows, or launch it if none are open
  function activate(entry: DesktopEntry) {
    const target = windowToFocus(HyprService.windowsForApp(entry))
    if (target) {
      HyprService.focusWindow(target)
    } else {
      launch(entry)
    }
  }

  // Of an app's windows, those eligible for focus. Scratchpad windows are only used when the app has no others.
  function focusCandidates(windows: var): var {
    const regular = windows.filter(t => !HyprService.isOnSpecialWorkspace(t))
    return regular.length > 0 ? regular : windows
  }

  // Picks which of an app's windows to focus (null if it has none). Normally the most recently used one.
  // If the app already has focus, the least recently used one instead: each click then brings
  // up the window that's been waiting longest, cycling through all of them in turn.
  function windowToFocus(windows: var): HyprlandToplevel {
    const ordered = HyprService.sortByFocusHistory(focusCandidates(windows))
    if (ordered.length === 0) return null
    const appIsFocused = windows.some(t => HyprService.isWindowFocused(t))
    return appIsFocused ? ordered[ordered.length - 1] : ordered[0]
  }
}
