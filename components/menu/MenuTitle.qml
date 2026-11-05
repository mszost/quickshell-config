import QtQuick
import QtQuick.Layouts
import qs
import qs.style

MenuBlock {
  id: root

  required property string text
  property string icon

  RowLayout {
    id: content
    anchors {
      left: parent.left
      right: parent.right
      margins: 2 * Config.globalUiScale
    }
    spacing: 2 * Config.globalUiScale

    Text {
      text: root.icon
      color: Colors.primary
      font: Config.menu.titleBlockIconFont 
    }

    Text {
      Layout.fillWidth: true
      text: root.text
      color: Colors.mOnSurface
      font: Config.menu.titleBlockTextFont
    }
  }
}
