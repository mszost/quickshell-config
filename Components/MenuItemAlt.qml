// A reusable component for a single row in the menu.
// "Alt" is a stripped version of the regular MenuItem which makes comparatively minimal assumptions about the item.

import QtQuick
import QtQuick.Layouts
import qs.Theme 


Rectangle {
  id: root
    
  property string text: ""
  property int rowHeight: parent.rowHeight  // parent is the ColumnLayout in Menu.qml

  width: parent.width *0.8
  Layout.alignment: Qt.AlignHCenter
  height: rowHeight 
  color: "transparent" //m.containsMouse ? bgHoverColor : bgColor

  Item {
    id: content
  }
}

