pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland


QtObject {
    id: root

    // --- Configuration ---
    // Change this to change the minimum number of circles shown
    property int minWorkspaces: 6

    // --- State ---
    // The ID of the currently active workspace
    readonly property int focusedId: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1

    // Calculate how many circles we need to draw.
    // Logic: Look at all active workspaces, find the highest ID, 
    // and compare it to our minimum.
    readonly property int count: {
        let maxId = 0
        
        // Hyprland.workspaces is a Map. We iterate the values to find the highest ID.
        // Note: We use .values() to get the workspace objects
        for (let ws of Hyprland.workspaces.values()) {
            if (ws.id > maxId) maxId = ws.id
        }

        return Math.max(maxId, minWorkspaces)
    }

    // --- Helper Functions ---

    // Check if a specific workspace ID has windows on it
    function isOccupied(id) {
        // Since Hyprland.workspaces is a Map, we can check existence directly
        return Hyprland.workspaces.has(id)
    }

    // Switch to a workspace
    function dispatch(id) {
        Hyprland.dispatch(`workspace ${id}`)
    }
}
