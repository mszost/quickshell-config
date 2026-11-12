import QtQuick
import QtMultimedia
import Quickshell
import qs
import qs.modules.audio

Item {
  id: root

  Timer {
    id: cooldown
    interval: Config.volumeSoundCooldown
    repeat: false
  }

  // Play on volume change
  SoundEffect {
    source: '../../assets/sounds/audio-volume-change.wav'
    muted: !Config.playSoundEffects

    volume: AudioService.volume * Config.soundEffectVolume
    onVolumeChanged: {
      if (!cooldown.running) {
        play()
        cooldown.start()
      }
    }
  }
}
