pragma Singleton

import QtQuick
import Quickshell
import qs.style

Singleton {
  id: root

  readonly property string theme: 'creamy-forest'
  readonly property bool playSoundEffects: true
  readonly property real globalUiScale: 1.0
  readonly property real globalAnimationSpeed: 0.8

  property font fontMono: Fonts.jetbrainsMono //Fonts.cartograph
  property font fontSans: Fonts.ibmPlexSans

  // Uncomment to set custom accents (overrides theme colors).
  // readonly property color accentColorPrimary: '#FFFFFF'
  // readonly property color accentColorSecondary: '#FFFFFF'


  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  property QtObject bar: QtObject { 
    // See `components/bar/WidgetRegistry.qml` for names of available widgets.
    readonly property list<string> widgetsLeft: ['clock', '_debug']
    readonly property list<string> widgetsCenter: ['workspaces']
    readonly property list<string> widgetsRight: ['brightness', 'audio', 'battery', 'session']

    // Behavior
    readonly property list<string> monitors: ['eDP-2', 'DP-10', 'DP-1', 'HDMI-1']
    // If enabled the bar will switch between floating and edge-attached
    // states when there are tiled windows present on the workspace.
    readonly property bool dynamicFloating: true

    // Styling
    readonly property color color: Colors.surface
    readonly property real alpha: 0.8
    readonly property real floatingAlpha: 0.4

    // Dimensions
    readonly property int height: globalUiScale * 31
    readonly property int marginX: globalUiScale * 0
    readonly property int marginY: globalUiScale * 0
    readonly property int radius: globalUiScale * 0

    readonly property int floatingMarginY: globalUiScale * 8
    readonly property int floatingMarginX: globalUiScale * 20
    readonly property int floatingRadius: globalUiScale * 10

    readonly property int widgetSpacing: globalUiScale * 5
    readonly property int widgetMarginsX: globalUiScale * 10

  }


  // ░█▀▄░█▀█░█▀▀░█░█
  // ░█░█░█░█░█░░░█▀▄
  // ░▀▀░░▀▀▀░▀▀▀░▀░▀

  property QtObject dock: QtObject {
    // Behavior
    readonly property list<string> monitors: ['eDP-2', 'DP-10', 'HDMI-1']
    readonly property bool dynamicHiding: true
    readonly property int hideDelay: 330

    // Content (pulls from .desktop files in ~/.local/share/applications/ and /usr/share/applications)
    readonly property list<string> pinnedApps: [
      'kitty', 'org.kde.dolphin', 'zen', 'vivaldi-stable', 'obsidian',
      'code-oss', 'org.darktable.darktable', 'spotify-launcher', 'vesktop',
      'steam', 'vintage-story', 'org.keepassxc.KeePassXC',
    ]
    readonly property list<string> blacklistedApps: ['xdg-desktop-portal-gtk']
    readonly property string fallbackIcon: 'zen' //todo

    // Styling
    readonly property color bgColor: Colors.surface
    readonly property color borderColor: Colors.outline
    readonly property real alpha: 0.75

    // Container dimensions
    readonly property int height: globalUiScale * 65
    readonly property int iconSpacing: height / 6           // Spacing between icons within their row
    readonly property int iconRowPadding: height * 0.15     // Padding around the entire icon row
    readonly property int bottomMargin: globalUiScale * 10  // Distance from the bottom edge of the screen
    readonly property int radius: height * 0.3

    // Trigger dimensions
    readonly property bool showTrigger: true
    readonly property int triggerHeight: globalUiScale * 6
    readonly property int triggerWidth: globalUiScale * 300
    readonly property color triggerColor: Colors.mOnSurface
    readonly property real triggerAlpha: 0.33

    // Dots for running instances
    readonly property color dotColor: Colors.primary
    readonly property int dotSize: globalUiScale * 4
    readonly property int dotSpacing: globalUiScale * 2  // Spacing between dots within their row
    readonly property int dotGap: globalUiScale * -1     // Spacing between dot row and app icon
    readonly property int maxDots: 4
    
    // Vertical line between the pinned and open-but-unpinned apps
    readonly property int separatorLineWidth: 2  

    // Setting hoverZoneMargin <= easing.overshoot of the dock's slide 
    // animation will cause the dock to clip it's bounds
    readonly property real hoverZoneMargin: globalUiScale * 25

    // Properties for the focused icon scaling animation
    readonly property real maxGrowth: 1.4
    readonly property real growthRadius: 1.10     // Columns away from the pointer that should be scaled.
    readonly property real pushRadius: 2.15       // Columns from the pointer beyond which icons don't move.
    readonly property real pushDistance: globalUiScale * 4  // peak sideways displacement (pixels)
  }


  // ░█░█░▀█▀░█▀▄░█▀▀░█▀▀░▀█▀░█▀▀
  // ░█▄█░░█░░█░█░█░█░█▀▀░░█░░▀▀█
  // ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀

  property QtObject widget: QtObject {
    readonly property color textColor: Colors.mOnSurface
    readonly property font textFont: Fonts.cartograph
    readonly property color pillColor: Colors.surfaceBright
    readonly property int pillHeight: globalUiScale * 21
    readonly property int pillPaddingX: globalUiScale * 16

    property QtObject audio: QtObject {}

    property QtObject battery: QtObject {
      readonly property int criticalBlinkRate: globalAnimationSpeed * 300
    }

    property QtObject brightness: QtObject {}

    property QtObject clock: QtObject {
      readonly property string format: 'h:mm AP  •  ddd, MMM. d'
      // All widgets that implement `Widget.qml` can be modified in this way.
      readonly property font textFont: Fonts.ibmPlexSans  
    }

    property QtObject network: QtObject {}

    property QtObject session: QtObject {}

    property QtObject tray: QtObject {}

    
    property QtObject workspaces: QtObject {
      readonly property int iconHeight: globalUiScale * 10
      readonly property int iconWidth: iconHeight
      readonly property int iconSpacing: globalUiScale * 4
      readonly property real focusedIconScaleX: 3.0
      readonly property bool showWorkspaceId: true
      readonly property bool showSpecialWorkspaces: false
    }
  }
}

