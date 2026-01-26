pragma Singleton

import Quickshell

Singleton {
  id: root

  // ░█▀▀░█▀▀░█▀█░█▀▀░█▀▄░█▀█░█░░
  // ░█░█░█▀▀░█░█░█▀▀░█▀▄░█▀█░█░░
  // ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀
 
  // See Theme/Colors.qml for available color palettes
  readonly property string theme: 'nord'
  // Global background opacity (range 0.0 - 1.0)
  // Item-specific values (barAlpha, dockAlpha, etc.) will fall back to this if they are unset
  readonly property real alpha: 1.0
  // Global enable/disable sound effects
  readonly property bool muteSounds: false


  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  // Bar background opacity
  property real barAlpha: 0.5
  // Monitors that the bar should appear on
  readonly property list<string> barMonitors: ['eDP-2', 'DP-10', 'HDMI-1']


  // ░█▀▄░█▀█░█▀▀░█░█
  // ░█░█░█░█░█░░░█▀▄
  // ░▀▀░░▀▀▀░▀▀▀░▀░▀

  // Dock background opacity 
  property real dockAlpha: 0.5
  // Height offset from the bottom edge of the screen (setting this above ~10px can cause issues)
  property int dockOffset: 60
  // Monitors that the dock should appear on
  readonly property list<string> dockMonitors: ['eDP-2', 'DP-10', 'HDMI-1']
  // Applications to show on the dock (uses names of .desktop files from ~/.local/share/applications/)
  readonly property list<string> dockApps: [
    'kitty',
    'org.kde.dolphin',
    'firefox',
    'vivaldi-stable',
    'obsidian',
    'code-oss',
    'vesktop',
    'steam',
    'org.keepassxc.KeePassXC',
  ]


  // ░█▄█░█▀▀░█▀█░█░█░█▀▀
  // ░█░█░█▀▀░█░█░█░█░▀▀█
  // ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀

  // Menu background opacity
  property real menuAlpha: 0.75


  // ░█▀█░█▀▀░█▀▄
  // ░█░█░▀▀█░█░█
  // ░▀▀▀░▀▀▀░▀▀░

  // OSD background opacity
  property real osdAlpha: 0.75
  // Use alternative style for OSDs, inspired by https://github.com/end-4/dots-hyprland
  // property bool osdAltStyle: true
}

