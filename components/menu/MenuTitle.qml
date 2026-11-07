import QtQuick
import QtQuick.Layouts
import qs
import qs.style

MenuBlock {
  id: root

  required property string text
  property string icon

  RowLayout {
    width: parent.width
    spacing: Config.menu.titleSpacing

    Text {
      text: root.icon
      font: Config.menu.titleBlockIconFont
      color: Colors.primary
    }

    Text {
      Layout.fillWidth: true
      text: root.text
      font: Config.menu.titleBlockTextFont
      color: Colors.mOnSurface
    }
  }
}
