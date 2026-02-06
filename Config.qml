pragma Singleton

import QtQuick
import Quickshell

import qs.style

Singleton {
  id: root

  // ░█▀▀░█▀▀░█▀█░█▀▀░█▀▄░█▀█░█░░
  // ░█░█░█▀▀░█░█░█▀▀░█▀▄░█▀█░█░░
  // ░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀
 
  // See ./Theme/Colors.qml for available color palettes
  property string theme: 'nord'
  
  // Enable or disable sound effects
  // If you don't want sounds at all, removing the `SoundEffects {}` initialization
  // in ./shell.qml will prevent loading the object entirely, thus saving some memory
  property bool muteSounds: true
  
  // Global background opacity (range 0.0 - 1.0)
  // Item-specific values (barAlpha, dockAlpha, etc.) will fall back to this if they are unset
  readonly property real alpha: 1.0



  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  readonly property real barAlpha: 0.70
  readonly property real barAlphaFloating: 0.5
  readonly property color barColorBg: Colors.background
  readonly property int barHeight: 35

  // Monitors that the bar should appear on
  readonly property list<string> barMonitors: ['eDP-2', 'DP-10', 'HDMI-1']

  // If enabled the bar will switch between 'floating' and 'solid'
  // states depending on the presence of windows in the workspace.
  // Otherwise, the default state is 'solid'
  readonly property bool barDynamic: false
  
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
  readonly property real dockAlphaOutline: 0.5

  // Monitors that the dock should appear on
  readonly property list<string> dockMonitors: ['eDP-2', 'DP-10', 'HDMI-1']

  // Spacing from bottom edge of the screen (values > 10px can cause issues)
  readonly property int dockVerticalOffset: 6
  
  // Applications to show on the dock 
  // Uses names of .desktop files from ~/.local/share/applications/
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
    'vintage-story',
    'org.keepassxc.KeePassXC',
  ]



  // ░█▄█░█▀▀░█▀█░█░█░█▀▀
  // ░█░█░█▀▀░█░█░█░█░▀▀█
  // ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀

  property real menuRowAlpha: 0.5
  property real menuContainerAlpha: 0.75

  // Tabler icons for devices listed in ./Widgets/Menus/AudioMenu.qml
  // In the format of {<device.description>: <unicode string>}
  property var menuAudioDeviceSymbols: {
    'Laptop Speakers': Icons.tabler['laptop'],
    'QC45': Icons.tabler['headphones'],
    'Aux': Icons.tabler['device-speaker'],
    'Buds': Icons.tabler['device-airpods'],
    'Buds 2': Icons.tabler['device-airpods'],
    'USB Audio Headphones': Icons.tabler['usb'],
    '_fallback': Icons.tabler['volume'] // used if the device has no mapping set above
  }



  // ░█▀█░█▀▀░█▀▄
  // ░█░█░▀▀█░█░█
  // ░▀▀▀░▀▀▀░▀▀░

  property real osdAlpha: 0.25
  // Use alternative style for OSDs, inspired by https://github.com/end-4/dots-hyprland
  // property bool osdAltStyle: true
}

