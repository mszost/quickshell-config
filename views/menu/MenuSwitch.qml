// A MenuBlock row with a text label on the left and a StyledSwitch on the right.

import QtQuick
import QtQuick.Layouts
import qs
import qs.style

MenuBlock {
  id: root

  required property string text
  required property bool checked
  property string icon: ''

  signal toggled(bool checked)

  RowLayout {
    width: parent.width
    spacing: Config.menu.rowSpacing

    Text {
      visible: root.icon !== ''
      text: root.icon
      font: Config.menu.itemIconFont
      color: Colors.mOnSurface
    }

    Text {
      Layout.fillWidth: true
      text: root.text
      font: Config.menu.itemFont
      color: Colors.mOnSurface
      elide: Text.ElideRight
    }

    StyledSwitch {
      checked: root.checked
      // Clicking breaks the binding; restore it so the owner's state stays the source of truth.
      onToggled: {
        root.toggled(checked)
        checked = Qt.binding(() => root.checked)
      }
    }
  }
}
