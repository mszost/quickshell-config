import QtQuick
import qs
import qs.style
import qs.components.bar

Widget {
  id: root
  text: CpuTempService.celsiusAsInt + '°C'
  icon: Icons.flame
  spacing: 1
  colorStd: CpuTempService.isCritical ? Colors.red : Colors.mOnSurface
}

