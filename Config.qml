pragma Singleton

import Quickshell

Singleton {
  id: root

  /* --- General --- */

  // See Theme/Colors.qml for available color palettes
  readonly property string theme: 'gruvbox-material'
  // Global background opacity (range 0.0 - 1.0)
  // Item-specific values (barAlpha, dockAlpha, etc.) will fall back to this if they are unset
  readonly property real alpha: 1.0
  // Global enable/disable sound effects
  readonly property bool muteSounds: true



  /* --- Bar --- */

  // Bar background opacity
  property real barAlpha: 0.75
  // Monitors that the bar should appear on
  readonly property list<string> barMonitors: ['eDP-2', 'DP-10', 'HDMI-1']



  /* --- Dock --- */

  // Dock background opacity 
  property real dockAlpha: 0.5
  // Monitors that the dock should appear on
  readonly property list<string> dockMonitors: ['eDP-2', 'DP-10', 'HDMI-1']
  // Appliccations for the dock, uses names of .desktop files from ~/.local/share/applications/
  readonly property list<string> dockApps: [
    'kitty',
    'org.gnome.Nautilus',
    'firefox',
    'vivaldi-stable',
    'obsidian',
    'code-oss',
    'spotify',
    'vesktop',
    'steam',
    'org.keepassxc.KeePassXC',
  ]



  /* --- Menus --- */

  // Menu background opacity
  property real menuAlpha: 0.75



  /* --- OSDs --- */
  
  // OSD background opacity
  property real osdAlpha: 0.75
}

