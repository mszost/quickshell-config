import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs
import qs.style
import qs.templates
import qs.components.panel

Scope {
  id: root
  
  required property var boundItem
  required property var widgetContainerPos
  
  readonly property int padding: 12
  readonly property real bgAlpha: Config.menuRowAlpha ?? Config.alpha ?? 1.0
  
  property alias isVisible: panel.isVisible
  onIsVisibleChanged: GlobalStates.menuAudioIsOpen = panel.isVisible
  
  Panel {
    id: panel
    boundItem: root.boundItem
    widgetContainerPos: root.widgetContainerPos

    PanelTitle {
      id: titleBlock
      text: 'Audio'
      icon: AudioService.symbol
      serviceBtn.onClicked: AudioService.toggleMute()
      adjustBtn.onClicked: { 
        Hyprland.dispatch('exec pavucontrol')
        root.isVisible = false
      }
    }

    PanelSlider {
      text: 'Master Volume (Out)'
      valueText: `${AudioService.volumeAsInt}%`
      value: AudioService.volume
      onMoved: (sliderValue) => AudioService.setVolume(sliderValue)
      onWheel: (wheel) => {
        if (wheel.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + 0.02)
        if (wheel.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - 0.02)
      }
    }

    // Select from list of available sinks
    PanelRow {
      Text {
        text: 'Output Devices'
        font: Fonts.menuSubheading
        color: Colors.primary
      }

      Repeater {
        model: AudioService.availableSinks

        WrapperMouseArea {
          hoverEnabled: true
          onClicked: AudioService.setPreferredSink(modelData)

          Row {
            id: sinkDeviceRow
            spacing: 5
           
            property color textColor: {
              if (parent.containsMouse) return Colors.secondary
              if (modelData.id == AudioService.activeSinkId) return Colors.foreground
              else return Colors.mOnSurfaceVariant
            }
            Behavior on textColor { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } }

            Text {
              anchors.verticalCenter: parent.verticalCenter
              text: {
                Config.panelAudioDeviceSymbols[modelData.description] 
                || Config.menuAudioDeviceSymbols['_fallback']
              }
              font: Fonts.tabler
              color: parent.textColor
            }

            Text {
              anchors.verticalCenter: parent.verticalCenter
              text: modelData.description
              font: Fonts.menuBody
              color: parent.textColor
            }
          }
        }
      }
    }
  }
}

