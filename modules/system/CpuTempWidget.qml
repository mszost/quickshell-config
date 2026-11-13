import QtQuick
import qs
import qs.style
import qs.views.bar

Widget {
  id: root
  text: CpuTempService.celsiusAsInt + '°C'
  icon: Icons.flame
  spacing: Config.widget.iconSpacingCompact
  colorStd: CpuTempService.isCritical ? Colors.red : Colors.mOnSurface
}

