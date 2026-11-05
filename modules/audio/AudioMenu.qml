import QtQuick
import Quickshell
import Quickshell.Widgets
import qs
import qs.style
import qs.components.menu
import qs.components.bar

MenuWindow { 
  id: root
  module: 'audio'  
  width: 360 * Config.globalUiScale

  MenuTitle {
    text: 'Audio'
    icon: AudioService.symbol
  }

  MenuBlock {
    // bgColor: 'transparent'
  }

  MenuSlider {
    blockLabel: 'Master Volume (Out)'
    valueText: `${AudioService.volumeAsInt}%`
    value: AudioService.volume
    onMoved: (sliderValue) => AudioService.setVolume(sliderValue)
    onWheel: (wheel) => {
      if (wheel.angleDelta.y > 0) AudioService.setVolume(AudioService.volume + 0.02)
      if (wheel.angleDelta.y < 0) AudioService.setVolume(AudioService.volume - 0.02)
    }
  }

  MenuBlock {
    Text {
      text: 'Output Devices'
      font: Fonts.ibmPlexSans
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
            if (modelData.id == AudioService.activeSinkId) return Colors.mOnSurface
            else return Colors.mOnSurfaceVariant
          }
          Behavior on textColor { ColorAnimation { duration: 100; easing.type: Easing.InOutQuad } }

          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Config.module.audio.deviceSymbols[modelData.description] ?? Config.module.audio.deviceSymbols['_fallback']
            font: Fonts.tabler
            color: parent.textColor
          }

          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: modelData.description
            font: Fonts.ibmPlexSans
            color: parent.textColor
          }
        }
      }
    }
  }
}
