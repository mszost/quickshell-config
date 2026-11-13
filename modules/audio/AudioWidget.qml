import QtQuick
import qs
import qs.style
import qs.views.bar

Widget {
  id: root
  spacing: Config.widget.iconSpacingCompact
  text: AudioService.isMuted ? 'Muted' : AudioService.volumeAsInt + '%'
  icon: AudioService.symbol
  colorStd: AudioService.volumeAsInt > 100 ? Colors.red : Colors.mOnSurface
  menu: AudioMenu { boundWidget: root }
  scrollStep: Config.module.audio.scrollStep
  onScrolled: (delta) => AudioService.adjustVolume(delta)
}
