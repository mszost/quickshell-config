import QtQuick
import qs
import qs.views.bar
import qs.style

Widget {
  id: root

  font: Config.module.clock.textFont
  icon: Icons.clock
  text: TimeService.format(Config.module.clock.format)
}
