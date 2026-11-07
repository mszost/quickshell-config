import QtQuick
import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  spacing: 1
  font: Config.module.audio.textFont || Config.widget.textFont
  text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  icon: AudioService.symbol
  colorStd: AudioService.volumeAsInt > 100 ? Colors.red : Colors.mOnSurface
  menu: AudioMenu { boundWidget: root }

  // Scroll event handler
  mouseArea.onWheel: (wheelEvent) => {
    const step = Config.module.audio.scrollStep
    if (wheelEvent.angleDelta.y > 0) AudioService.adjustVolume(step)
    if (wheelEvent.angleDelta.y < 0) AudioService.adjustVolume(-step)
  }
}
