pragma Singleton

import QtQuick
import Quickshell
import qs.style

Singleton {
  id: root

  // ░█▀▀░█▀▀░█▀█░█▀▀░█▀▄░█▀█░█░░
  // ░█░█░█▀▀░█░█░█▀▀░█▀▄░█▀█░█░░
  // ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀
 
  // See ./Style/Colors.qml for available color palettes
  property string theme: 'nord'
  
  // Enable or disable sound effects
  // If you don't want sounds at all, removing the `SoundEffects {}` initialization
  // in ./shell.qml will prevent loading the object entirely, thus saving some memory
  property bool muteSounds: false
  
  // Global background opacity (range 0.0 - 1.0)
  // Item-specific values (barAlpha, dockAlpha, etc.) will fall back to this if they are unset
  readonly property real alpha: 1.0



  // ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀░█▀▀
  // ░█▄█░░█░░█░█░█░█░█▀▀░░█░░▀▀█
  // ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀

  readonly property bool workspacesShowId: true


  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  readonly property real barAlpha: 1
  readonly property real barAlphaFloating: 1
  readonly property color barColorBg: Colors.surfaceDim
  readonly property int barHeight: 27
  readonly property int barPillHeight: 21
  readonly property int barWidgetSpacing: 6

  // Monitors that the bar should appear on
  readonly property list<string> barMonitors: ['eDP-2', 'DP-10', 'DP-1', 'HDMI-1']

  // If enabled the bar will switch between 'floating' and 'solid'
  // states depending on the presence of windows in the workspace.
  // Otherwise, the default state is 'solid'
  readonly property bool barDynamic: false
  
  // Whether to show labels for bar widgets. Options: 'show', 'hide', or 'dynamic'
  // readonly property string barLabelStyle: 'dynamic'
  
  // Spacing from the edges of the screen (only applies to floating state)
  property int barVerticalOffset: 5
  property int barHorizontalOffset: 16
  property int barCornerRadius: 11



  // ░█▀▄░█▀█░█▀▀░█░█
  // ░█░█░█░█░█░░░█▀▄
  // ░▀▀░░▀▀▀░▀▀▀░▀░▀

  readonly property real dockAlpha: 0.80
  readonly property real dockAlphaOutline: 0.80
  readonly property color dockColorBg: Colors.surfaceDim

  // Monitors that the dock should appear on
  readonly property list<string> dockMonitors: ['eDP-2', 'DP-10', 'DP-1', 'HDMI-1']

  // Spacing from bottom edge of the screen (values > 10px can cause issues)
  readonly property int dockVerticalOffset: 6
  
  // Applications to show on the dock 
  // Uses names of .desktop files from ~/.local/share/applications/
  readonly property list<string> dockApps: [
    'kitty',
    'org.kde.dolphin',
    'zen',
    'vivaldi-stable',
    'obsidian',
    'code-oss',
    'spotify-launcher',
    'vesktop',
    'steam',
    'org.keepassxc.KeePassXC',
  ]



  // ░█▀█░█▀█░█▀█░█▀▀░█░░░█▀▀
  // ░█▀▀░█▀█░█░█░█▀▀░█░░░▀▀█
  // ░▀░░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀

  readonly property real panelContainerAlpha: 1.0
  readonly property real panelBlockAlpha: 1.0

  readonly property int panelRadius: 12

  // Tabler icons for devices which are listed by ./modules/audio/AudioPanel.qml
  // Uses device.description for names
  readonly property var panelAudioDeviceSymbols: {
    'Laptop Speakers': Icons.laptop,
    'QC45': Icons.headphones,
    'Aux': Icons.speaker,
    'Buds': Icons.airpods,
    'Buds 2': Icons.airpods,
    'USB Audio Headphones': Icons.usb,
    '_fallback': Icons.volume3 // used if the device has no mapping set above
  }



  // ░█▀█░█▀▀░█▀▄
  // ░█░█░▀▀█░█░█
  // ░▀▀▀░▀▀▀░▀▀░

  property real osdAlpha: 0.80
  // Use alternative style for OSDs, inspired by https://github.com/end-4/dots-hyprland
  // property bool osdAltStyle: true
}

