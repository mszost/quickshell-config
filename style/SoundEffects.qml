import QtQuick
import QtMultimedia
import Quickshell
import qs
import qs.modules.audio

Item {
id: root

  Timer {
    id: cooldown
    interval: 100
    repeat: false
  }

  // Play on volume change
  SoundEffect {
    source: '../assets/sounds/audio-volume-change.wav'
    muted: Config.muteSounds

    property int volume: AudioService.volumeAsInt
    onVolumeChanged: {
      if (!cooldown.running) { // force wait of 100ms between each play
        play()
        cooldown.start()
      }
    }
  }
}

