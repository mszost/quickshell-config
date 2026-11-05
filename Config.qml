pragma Singleton

import QtQuick
import Quickshell
import qs.style

Singleton {
  id: root

  readonly property string theme: 'cream'
  // readonly property string theme: 'nord'
  readonly property bool playSoundEffects: true
  readonly property real globalUiScale: 1.0
  readonly property real globalAnimationSpeed: 1.0

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
    readonly property list<string> widgetsLeft: ['clock', 'cputemp']
    readonly property list<string> widgetsCenter: ['workspaces']
    readonly property list<string> widgetsRight: ['network', 'brightness', 'audio', 'battery', 'session']

    readonly property list<string> monitors: ['eDP-2', 'DP-10', 'DP-1', 'HDMI-1']
    
    // dynamicFloating: bar will switch between floating and edge-attached 
    //   states depending on the presence of tiled windows on the workspace.
    // alwaysFloating: will override whatever dynamicFloating might is set to.
    readonly property bool dynamicFloating: false
    readonly property bool alwaysFloating: false

    // Styling
    readonly property color color: Colors.surface
    readonly property real alpha: 0.5
    readonly property real floatingAlpha: 0.3

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
    readonly property real alpha: 0.5

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
    readonly property real maxGrowth: 1.35
    readonly property real growthRadius: 1.2                // Columns away from the pointer that should be scaled.
    readonly property real pushRadius: 2.15                 // Columns from the pointer beyond which icons don't move.
    readonly property real pushDistance: globalUiScale * 3  // Max sideways displacement (pixels)
    readonly property real growthAnimDuration: globalAnimationSpeed * 500
    readonly property real pushAnimDuration: globalAnimationSpeed * 500

  }


  // ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀
  // ░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█
  // ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀

  property QtObject widget: QtObject {
     readonly property color textColor: Colors.mOnSurface
    // readonly property font textFont: Fonts.cartograph
    readonly property color pillColor: Colors.surfaceBright
    readonly property real pillAlpha: 1.0
    readonly property int pillHeight: globalUiScale * 21
    readonly property int pillPaddingX: globalUiScale * 16

    readonly property font textFont: Qt.font({ family: Fonts.cartographLoader.name, pixelSize: globalUiScale*12, weight: 500 })
    readonly property font iconFont: Qt.font({ family: Fonts.tablerLoader.name,     pixelSize: globalUiScale*15, weight: 600 })
  }


  property QtObject module: QtObject { 
    property QtObject audio: QtObject {
       // device.description for names
      readonly property var deviceSymbols: {
        'Laptop Speakers': Icons.laptop,
        'QC45': Icons.headphones,
        'Aux': Icons.speaker,
        'Buds': Icons.airpods,
        'Buds 2': Icons.airpods,
        'USB Audio Headphones': Icons.usb,
        '_fallback': Icons.volume3 // used if the device has no mapping set above
      }
    }

    property QtObject battery: QtObject {
      readonly property int criticalBlinkRate: globalAnimationSpeed * 300
    }

    property QtObject brightness: QtObject {
      readonly property string deviceClass: 'backlight'
      readonly property string device: ''       // Empty = first device in the class
      readonly property int pollInterval: 1000  // In ms; picks up changes made outside the shell
      readonly property real scrollStep: 0.01  // Fraction of full brightness per scroll tick
      readonly property real minBrightness: 0
    }

    property QtObject clock: QtObject {
      readonly property string format: 'h:mm AP  •  ddd, MMM. d'
      // All implementors of `Widget.qml` can have textFont overridden in this way.
      readonly property font textFont: Qt.font({ family: Fonts.ibmPlexSansLoader.name, pixelSize: globalUiScale*12, weight: 500 }) 
    }

    property QtObject cpuTemp: QtObject {
      readonly property string sensorPath: '/sys/class/thermal/thermal_zone0/temp'
      readonly property int pollInterval: 2000
      readonly property int criticalThreshold: 85  // °C; widget text turns red at or above
    }

    property QtObject network: QtObject {
      readonly property font textFont: Fonts.ibmPlexSans 
      readonly property int pollInterval: 30000   
      readonly property int eventDebounce: 250    // Delay after an `nmcli monitor` event before refreshing
      readonly property int signalHigh: 50        // Strength above this shows full bars
      readonly property int signalMedium: 25      // Strength above this shows medium bars
    }

    property QtObject session: QtObject {
      readonly property string shutdownCmd: 'shutdown now'
      readonly property string rebootCmd: 'reboot'
      readonly property string suspentCmd: 'systemctl suspent'
      readonly property string logoutCmd: 'hyprshutdown'
    }

    property QtObject tray: QtObject {}
    
    property QtObject workspaces: QtObject {
      readonly property int iconHeight: globalUiScale * 9
      readonly property int iconWidth: iconHeight
      readonly property int iconSpacing: globalUiScale * 4
      readonly property real focusedIconScaleX: 3.0
      readonly property bool showWorkspaceId: false
      readonly property bool showSpecialWorkspaces: false
    }
  }

  // ░█▄█░█▀▀░█▀█░█░█░█▀▀
  // ░█░█░█▀▀░█░█░█░█░▀▀█
  // ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀
  property QtObject menu: QtObject {
    readonly property int margins: globalUiScale * 16 // Margins around content within the PopupWindow
    readonly property int radius: globalUiScale * 15

    // readonly property color bgColor:  // Uses background color (including alpha) of the parent bar by default.
    readonly property color blockBgColor: Colors.surfaceBright

    readonly property int blockRadius: globalUiScale * 10

    readonly property font titleBlockTextFont: Qt.font({ family: Fonts.rubikLoader.name, pixelSize: 16 * globalUiScale, weight: 600 })
    readonly property font titleBlockIconFont: Qt.font({ family: Fonts.tablerLoader.name, pixelSize: 19 * globalUiScale, weight: 600 })

    // readonly property int screenEdgesMargin: 50 // Minimum px buffer from left/right screen edges
  }
}

