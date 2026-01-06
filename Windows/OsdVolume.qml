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

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	// The OSD window will be created and destroyed based on shouldShowOsd.
	// PanelWindow.visible could be set instead of using a loader, but using
	// a loader will reduce the memory overhead when the window isn't open.
	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {
			// Since the panel's screen is unset, it will be picked by the compositor
			// when the window is created. Most compositors pick the current active monitor.

			anchors.bottom: true
			margins.bottom: screen.height / 5
			exclusiveZone: 0

			implicitWidth: 250
			implicitHeight: 40
			color: 'transparent'

			// An empty click mask prevents the window from blocking mouse events.
			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: 12
				color: Colors.alpha(Colors.background, 0.3)

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

          Text {
            color: Colors.foreground
            font: Fonts.barIcon
            // `text` should match `icon` in Widgets/Bar/VolumeWidget.qml, but I couldn't get a
            // reference to work, so this is just a duplicated block for now.
            text: {  
              if (AudioService.isMuted) return '\uF1C3'
              if (AudioService.volumeAsInt > 45) return '\uEB51'
              if (AudioService.volumeAsInt > 0)  return '\uEB4F'
              else return '\uEB50'
            } 
          }
          
					Rectangle {
						// Stretches to fill all left-over space
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
              Behavior on width { NumberAnimation { duration: 200; easing.type: Linear } }
						}
					}
				}
			}
		}
	}
}

