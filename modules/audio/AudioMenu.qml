import QtQuick
import Quickshell.Services.Pipewire
import qs
import qs.components.menu

MenuWindow {
  id: root

  MenuTitle {
    text: 'Audio'
    icon: AudioService.symbol
  }

  MenuSlider {
    label: 'Master Volume (Out)'
    valueText: `${AudioService.volumeAsInt}%`
    value: AudioService.volume
    scrollStep: Config.module.audio.scrollStep
    onMoved: (sliderValue) => AudioService.setVolume(sliderValue)
  }

  MenuBlock {
    label: 'Output Devices'

    Repeater {
      model: AudioService.availableSinks

      MenuRow {
        required property PwNode modelData

        icon: AudioService.symbolFor(modelData)
        text: modelData.description
        active: AudioService.isActiveSink(modelData)
        onClicked: AudioService.setPreferredSink(modelData)
      }
    }
  }
}
