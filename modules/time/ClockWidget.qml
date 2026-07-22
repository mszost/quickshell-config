import qs.components.bar 
import qs.style

BarWidget {
  id: root
  text: ClockService.datetime 
  textFamily: Fonts.ibmPlex.family
  textWeight: Fonts.ibmPlex.weight
  layoutDirection: Qt.RightToLeft
  spacing: 5
  icon: Icons.clock
}

