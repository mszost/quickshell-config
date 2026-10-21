import QtQuick
import qs
import qs.components.bar
import qs.style

Widget {
  id: root

  font: Config.widget.clock.textFont || Config.widget.textFont 
  icon: Icons.clock
  text: TimeService.format(Config.widget.clock.format)
}
