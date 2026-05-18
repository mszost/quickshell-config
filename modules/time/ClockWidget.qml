import qs.components.bar 
import qs.style

BarWidget {
  id: root
  text: ClockService.datetime 
  layoutDirection: Qt.RightToLeft
  spacing: 5
  icon: Icons.clock
}

