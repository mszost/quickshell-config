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

  function launch(entry: DesktopEntry) {
    entry?.execute()
  }
}
