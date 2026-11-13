import QtQuick
import qs
import qs.style
import qs.views.bar

Widget {
  id: root
  visible: BrightnessService.available
  spacing: Config.widget.iconSpacingCompact
  text: BrightnessService.percent + '%'
  icon: BrightnessService.symbol
  menu: BrightnessMenu { boundWidget: root }
  scrollStep: Config.module.brightness.scrollStep
  onScrolled: (delta) => BrightnessService.adjust(delta)
}
