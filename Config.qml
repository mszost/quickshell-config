pragma Singleton

import QtQuick
import Quickshell
import qs.style

Singleton {
  id: root

  readonly property string theme: 'gruvbox-material'
  readonly property bool playSoundEffects: true
  readonly property real soundEffectVolume: 0.25  // Relative to the current output volume
  readonly property int volumeSoundCooldown: 100  // Minimum ms between volume-change sounds
  readonly property real globalUiScale: 1.0
  readonly property real globalAnimationSpeed: 1.0  // Higher is faster; durations are divided by this

  property alias s: root.globalUiScale

  // Uncomment to set custom accents (overrides theme colors).
  // readonly property color accentColorPrimary: '#FFFFFF'
  // readonly property color accentColorSecondary: '#FFFFFF'


  // ░█▀▄░█▀█░█▀▄
  // ░█▀▄░█▀█░█▀▄
  // ░▀▀░░▀░▀░▀░▀

  property QtObject bar: QtObject { 
    // See `views/bar/WidgetRegistry.qml` for names of available widgets.
    readonly property list<string> widgetsLeft: ['clock', 'cputemp']
    readonly property list<string> widgetsCenter: ['workspaces']
    readonly property list<string> widgetsRight: ['tray', 'network', 'brightness', 'audio', 'battery', 'session']

    readonly property list<string> monitors: ['eDP-2', 'DP-10', 'DP-1', 'HDMI-1']
    
    // dynamicFloating: bar switches between floating / edge-attached on presence of tiled windows on the workspace.
    // alwaysFloating: optionally force the floating state regardless of the value of dynamicFloating 
    readonly property bool dynamicFloating: false
    readonly property bool alwaysFloating: true

    // Styling
    readonly property color color: Colors.surface
    readonly property real alpha: 0.7
    readonly property real floatingAlpha: 0.4

    // Dimensions
    readonly property int height: s*31
    readonly property int marginX: s*0  // Left-right margins when tiled
    readonly property int marginY: s*0  // Top-bottom margins when tiled
    readonly property int radius: s*0   // Corner radius when tiled

    readonly property int floatingMarginX: s*20  // Left-right margins when floating
    readonly property int floatingMarginY: s*4   // Top-bottom margins when floating
    readonly property int floatingRadius: s*12   // Corner radius when floating

    readonly property int widgetMarginsX: s*10 // Inner widget margins from left and right bar edges
  }

  property QtObject widget: QtObject {
    readonly property color textColor: Colors.mOnSurface
    readonly property color pillColor: Colors.surfaceBright
    readonly property real pillAlpha: 1.0
    readonly property int pillHeight: s*21
    readonly property int pillSpacing: s*5         // Spacing between each widget pill.
    readonly property int pillPaddingX: s*14
    readonly property int iconSpacing: s*2         // Gap between a widget's icon and its label
    readonly property int iconSpacingCompact: s*1  // Used by widgets whose icon has its own padding

    readonly property font textFont: Qt.font({ family: Fonts.cartographLoader.name, pixelSize: s*12, weight: 500 })
    readonly property font iconFont: Qt.font({ family: Fonts.tablerLoader.name,     pixelSize: s*15, weight: 600 })
  }


  // ░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀
  // ░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█
  // ░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀

  property QtObject module: QtObject { 
    property QtObject audio: QtObject {
      readonly property real scrollStep: 0.02  // Volume percentage per scroll tick

      // device.description for names
      readonly property var deviceSymbols: {
        'Laptop Speakers': Icons.laptop,
        'QC45': Icons.headphones,
        'Aux': Icons.speaker,
        'Buds': Icons.airpods,
        'Buds 2': Icons.airpods,
        'USB Audio Headphones': Icons.usb,
        '_fallback': Icons.volume3  // used if the device has no mapping set above
      }
    }

    property QtObject battery: QtObject {
      readonly property int criticalBlinkRate: 300 / globalAnimationSpeed
      readonly property real criticalBlinkAlpha: 0.35  // Text alpha during the dim half of the blink
    }

    property QtObject brightness: QtObject {
      readonly property string deviceClass: 'backlight'
      readonly property string device: ''       // Empty = first device in the class
      readonly property int pollInterval: 1000  // In ms; picks up changes made outside the shell
      readonly property real scrollStep: 0.01   // Fraction of full brightness per scroll tick
      readonly property real minBrightness: 0
      readonly property string menuLabel: ''  // Slider label in the menu. Empty = device name
    }

    property QtObject clock: QtObject {
      readonly property string format: 'h:mm AP  •  ddd, MMM. d'
      // All implementors of `Widget.qml` can have textFont overwritten in this way.
      readonly property font textFont: Qt.font({ family: Fonts.ibmPlexSansLoader.name, pixelSize: s*12, weight: 500 }) 
    }

    property QtObject cpuTemp: QtObject {
      readonly property string sensorPath: '/sys/class/thermal/thermal_zone0/temp'
      readonly property int pollInterval: 2000
      readonly property int criticalThreshold: 85  // °C; widget text turns red at or above
    }

    property QtObject network: QtObject {
      readonly property font textFont: Fonts.ibmPlexSans 
      readonly property int pollInterval: 30000   
      readonly property int eventDebounce: 250  // Delay after an `nmcli monitor` event before refreshing
      readonly property int signalHigh: 50      // Strength above this shows full bars
      readonly property int signalMedium: 25    // Strength above this shows medium bars
    }

    property QtObject session: QtObject {
      readonly property string shutdownCmd: 'shutdown now'
      readonly property string rebootCmd: 'reboot'
      readonly property string suspendCmd: 'systemctl suspend'
      readonly property string logoutCmd: 'hyprshutdown'
    }

    property QtObject tray: QtObject {
      // Per-button action: 'menu' (dropdown), 'activate' (app's primary action, usually opens its window),
      // 'secondary' (app-defined, often unused) or 'none'. 'menu' falls back to 'activate' for items
      // without a menu, and 'activate' falls back to 'menu' for menu-only items.
      readonly property string leftClick: 'menu'
      readonly property string rightClick: 'activate'
      readonly property string middleClick: 'secondary'

      readonly property list<string> blacklist: ['vicinae']  // Item ids to hide (see `SystemTrayItem.id`)
      readonly property bool hidePassive: false     // Hide items that report themselves as passive/idle

      readonly property int iconSize: s*14
      readonly property int iconSpacing: s*8
      readonly property real iconHoverAlpha: 0.7      // Icon opacity while hovered

      readonly property int menuWidth: s*240
      readonly property int menuMargins: s*8         // Overrides Config.menu.margins
      readonly property int entryIconSize: s*15        // Icons supplied by the app for individual entries
      readonly property real disabledEntryAlpha: 0.5
    }
    
    property QtObject workspaces: QtObject {
      readonly property int dotHeight: s*9
      readonly property int dotWidth: dotHeight
      readonly property int dotSpacing: s*4
      readonly property real focusedDotScaleX: 3.0  // Width of the focused dot is multiplied by this
      readonly property bool showWorkspaceId: false  // Display each workspace's numerical id inside its dot
      readonly property bool showSpecialWorkspaces: false
    }
  }


  // ░█▀▄░█▀█░█▀▀░█░█
  // ░█░█░█░█░█░░░█▀▄
  // ░▀▀░░▀▀▀░▀▀▀░▀░▀

  property QtObject dock: QtObject {
    // Behavior
    readonly property list<string> monitors: ['eDP-2', 'DP-10', 'HDMI-1']
    readonly property bool dynamicHiding: true
    readonly property int hideDelay: 360

    // Content (pulls from .desktop files in ~/.local/share/applications/ and /usr/share/applications)
    readonly property list<string> pinnedApps: [
      'kitty', 'org.kde.dolphin', 'zen', 'obsidian',
      'code-oss', 'com.anthropic.Claude', 'org.darktable.darktable', 
      'spotify-launcher', 'steam', 'org.keepassxc.KeePassXC',
    ]
    readonly property list<string> blacklistedApps: ['xdg-desktop-portal-gtk']
    readonly property string fallbackIcon: 'kitty'

    // Styling
    readonly property color bgColor: Colors.surface
    readonly property color borderColor: Colors.outline
    readonly property real alpha: 0.66

    // Container dimensions
    readonly property int height: s*70
    readonly property int iconSpacing: height / 7        // Spacing between icons within their row
    readonly property int iconRowPadding: height * 0.15  // Padding around the entire icon row
    readonly property int bottomMargin: s*10             // Distance from the bottom edge of the screen
    readonly property int radius: height * 0.33

    // Invisible padding above the dock within which the mouse is still considered to be hovering.
    // Setting this <= the overshoot of revealMotion will cause the dock to clip it's bounds.
    readonly property real hoverZoneMargin: s*25

    // Trigger dimensions
    readonly property bool showTrigger: true
    readonly property int triggerHeight: s*6
    readonly property int triggerWidth: s*300
    readonly property color triggerColor: Colors.mOnSurface
    readonly property real triggerAlpha: 0.25

    // Dots below each icon for running instances
    readonly property color dotColor: Colors.primary
    readonly property int dotSize: s*4
    readonly property int dotSpacing: s*2  // Spacing between dots within their row
    readonly property int dotGap: s*-1     // Spacing between dot row and app icon
    readonly property int maxDots: 4
    
    // Vertical line between the pinned and open-but-unpinned apps
    readonly property int separatorLineWidth: s*2
    readonly property real separatorLineHeight: 0.75  // Fraction, relative to icon size
    
    // Properties for the focused icon scaling animation
    readonly property real maxGrowth: 1.35
    readonly property real growthRadius: 1.2  // Columns away from the pointer that should be scaled.
    readonly property real pushRadius: 2.15   // Columns from the pointer beyond which icons don't move.
    readonly property real pushDistance: s*3  // Max sideways displacement (pixels)

    // Animation curves
    readonly property var revealMotion: Motion.curve(250, Easing.InOutCirc) // Container slide-up from screen bottom
    readonly property var zoomMotion:   Motion.curve(500, Easing.OutExpo)   // Icon scaling
    readonly property var pushMotion:   Motion.curve(500, Easing.OutExpo)   // Icon horizontal displacement
  }


  // ░█▄█░█▀▀░█▀█░█░█░█▀▀
  // ░█░█░█▀▀░█░█░█░█░▀▀█
  // ░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀

  property QtObject menu: QtObject {
    // Window
    readonly property int width: s*360
    readonly property int radius: s*15
    readonly property int margins: s*16        // Margins around content blocks within the PopupWindow
    readonly property int anchorOffsetX: s*15  // For setting a minimum distance from bar edges
    
    readonly property var bgColor: undefined   // Undefined uses the color (including alpha) of the parent bar.
    readonly property color borderColor: Colors.outline

    // Blocks
    readonly property color blockBgColor: Colors.surfaceBright
    readonly property real blockAlpha: 1.0
    readonly property real blockFloatingAlpha: 0.75
    readonly property int blockRadius: s*10
    readonly property int blockPadding: s*12
    readonly property int blockSpacing: s*4

    readonly property int contentSpacing: s*10 // Gap between blocks
    readonly property int titleSpacing: s*3    // Gap between title text and icon
    readonly property int rowSpacing: s*5

    // Sliders
    readonly property int sliderHeight: s*30         // Interactable height, larger than the track
    readonly property int sliderTrackHeight: s*8
    readonly property int sliderSpacing: s*5         // Gap between the slider and its value
    readonly property int sliderLabelSpacing: s*2    // Gap between the label and the slider
    readonly property int sliderHandleBorder: s*2
    readonly property real sliderHandleScale: 1.725  // Handle size relative to the track height
    readonly property var sliderMotion: Motion.curve(300, Easing.OutCirc)

    // Fonts
    readonly property font titleBlockTextFont: Qt.font({ family: Fonts.rubikLoader.name,       pixelSize: s*16, weight: 600 })
    readonly property font titleBlockIconFont: Qt.font({ family: Fonts.tablerLoader.name,      pixelSize: s*19, weight: 600 })
    readonly property font labelFont:          Qt.font({ family: Fonts.ibmPlexSansLoader.name, pixelSize: s*12, weight: 500 })
    readonly property font valueFont:          Qt.font({ family: Fonts.jetbrainsLoader.name,   pixelSize: s*12, weight: 700 })
    readonly property font itemFont:           Qt.font({ family: Fonts.ibmPlexSansLoader.name, pixelSize: s*12, weight: 500 })
    readonly property font itemIconFont:       Qt.font({ family: Fonts.tablerLoader.name,      pixelSize: s*15, weight: 600 })

    // Animation curves
    readonly property var revealMotion: Motion.curve(200, Easing.InOutCirc) // Slide down from bar bottom
  }
}

