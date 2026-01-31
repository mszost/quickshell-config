pragma Singleton

import QtQuick
import Quickshell

import qs.Theme

Singleton {
  id: root

  // ░█▀▀░█▀▀░█▀█░█▀▀░█▀▄░█▀█░█░░
  // ░█░█░█▀▀░█░█░█▀▀░█▀▄░█▀█░█░░
  // ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀
 
  // See ./Theme/Colors.qml for available color palettes
  property string theme: 'gruvbox-material'
  
  // Global enable/disable sound effects
  property bool muteSounds: false
  
  // Global background opacity (range 0.0 - 1.0)
  // Item-specific values (barAlpha, dockAlpha, etc.) will fall back to this if they are unset
  readonly property real alpha: 1.0



  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  readonly property real barAlpha: 0.75
  readonly property real barAlphaFloating: 0.25
  readonly property color barColorBg: Colors.background
  readonly property int barHeight: 35

  // Monitors that the bar should appear on
  readonly property list<string> barMonitors: ['eDP-2', 'DP-10', 'HDMI-1']
  
  // If enabled the bar will switch between 'floating' and 'solid'
  // states depending on the presence of windows in the workspace
  readonly property bool barDynamic: true 
  
  // Whether to show labels for bar widgets. Options: 'show', 'hide', or 'dynamic'
  // Can also be set individually for each widget in ./Widgets/Bar/<widget>
  // readonly property string barLabelStyle: 'dynamic'
  
  // Spacing from the edges of the screen (only applies to floating state)
  property int barVerticalOffset: 7
  property int barHorizontalOffset: 16
  property int barCornerRadius: 10



  // ░█▀▄░█▀█░█▀▀░█░█
  // ░█░█░█░█░█░░░█▀▄
  // ░▀▀░░▀▀▀░▀▀▀░▀░▀

  readonly property real dockAlpha: 0.25

  // Monitors that the dock should appear on
  readonly property list<string> dockMonitors: ['eDP-2', 'DP-10', 'HDMI-1']

  // Spacing from bottom edge of the screen (values > 10px can cause issues)
  readonly property int dockVerticalOffset: 6
  
  // Applications to show on the dock (uses names of .desktop files in ~/.local/share/applications/)
  readonly property list<string> dockApps: [
    'kitty',
    'org.kde.dolphin',
    'firefox',
    'vivaldi-stable',
    'obsidian',
    'code-oss',
    'spotify-launcher',
    'vesktop',
    'steam',
    'org.keepassxc.KeePassXC',
  ]



  // ░█▄█░█▀▀░█▀█░█░█░█▀▀
  // ░█░█░█▀▀░█░█░█░█░▀▀█
  // ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀

  property real menuRowAlpha: 0.66
  property real menuContainerAlpha: 0.25

  // Tabler icon unicode strings for devices in the audio menu
  property var menuAudioIcons: {
    'device.description': '\u0000'
  }



  // ░█▀█░█▀▀░█▀▄
  // ░█░█░▀▀█░█░█
  // ░▀▀▀░▀▀▀░▀▀░

  property real osdAlpha: 0.25
  // Use alternative style for OSDs, inspired by https://github.com/end-4/dots-hyprland
  // property bool osdAltStyle: true
}

