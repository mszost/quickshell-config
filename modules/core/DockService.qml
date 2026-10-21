pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs

Singleton {
  id: root

  // Pinned apps first, then open-but-unpinned apps in window order, one icon per app
  
  // Fetches only unpinned running apps
  // readonly property var computedIds: {
  //   const pinnedIds = [...Config.dock.pinnedApps]
  //   const ids = []
  //   for (const toplevel of Hyprland.toplevels.values) {
  //     const entry = entryForClass(toplevel.lastIpcObject.class)
  //     if (entry && !pinnedIds.includes(entry.id)) ids.push(entry.id)
  //   }
  //   return ids
  // }

    // fetches full list of pinned and running 
  readonly property var computedIds: {
    const ids = [...Config.dock.pinnedApps]
    for (const toplevel of Hyprland.toplevels.values) {
      const entry = entryForClass(toplevel.lastIpcObject.class)
      if (entry && !ids.includes(entry.id)) ids.push(entry.id)
    }
    return ids
  }

  // What the dock actually binds to; only reassigned when the contents really change
  property var appIds: []

  onComputedIdsChanged: {
    // if (JSON.stringify(computedIds) !== JSON.stringify(appIds)) appIds = computedIds
    appIds = computedIds
  }

  // Inverse of HyprService.windowCountForApp's matching: window class -> DesktopEntry
  function entryForClass(windowClass: string): DesktopEntry {
    if (!windowClass) return null
    const wanted = windowClass.toLowerCase()
    return DesktopEntries.applications.values.find(
      e => e.id.toLowerCase() === wanted || (e.startupClass ?? '').toLowerCase() === wanted
    ) ?? DesktopEntries.heuristicLookup(windowClass) ?? null
  }
}
