import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

import qs.Theme
import qs.Components
import qs.Services


Scope {
  id: root

  property bool shouldShowOsd: false
  property bool animating: false
  
  Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
  }

	Connections {
		target: Pipewire.defaultAudioSink?.audio ?? null

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: root.shouldShowOsd || root.animating

		PanelWindow {
			// Since the panel's screen is unset, it will be picked by the compositor
			// when the window is created. Most compositors pick the current active monitor.
			anchors.bottom: true
			margins.bottom: screen.height / 5
			exclusiveZone: 0
			mask: Region {} // An empty click mask prevents the window from blocking mouse events.

			implicitWidth: 250
			implicitHeight: 40
      color: 'transparent'

      Rectangle {
				anchors.fill: parent
				radius: 12
        color: Colors.alpha(Colors.background, 0.3)

        // pop in/out animation
        scale: root.shouldShowOsd ? 1 : 0
        Behavior on scale {
          NumberAnimation {
            duration: 200
            easing.type: Easing.OutExpo
            onRunningChanged: root.animating = running
          }
        }

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

          Text {
            color: Colors.foreground
            font: Fonts.barIcon
            text: AudioService.symbol 
          }
          
					Rectangle {
						Layout.fillWidth: true

						implicitHeight: 10
						radius: height/2
						color: Colors.alpha(Colors.foreground,0.5) 

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}

							width: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              radius: parent.radius
              color: Colors.foreground
              Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }
						}
					}
				}
			}
		}
	}
}

