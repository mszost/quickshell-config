import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.style

WrapperMouseArea {
  id: iconArea
  child: appIcon
  resizeChild: false
  Layout.preferredWidth: 55  // Actual displayed resolution, downscaled from appIcon.sourceSize 
  Layout.preferredHeight: 55
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor
  onClicked: { 
    clickAnimation.restart()
    DesktopEntries.byId(appId).execute()
  }

  required property string appId

  Image {
    id: appIcon
    anchors.fill: parent
    // Wait for the full application list to load (prevents a race condition)
    source: (DesktopEntries.applications.values, DesktopEntries.byId(appId)?.icon ?? '') 
    sourceSize.width: 128  // Render resolution
    mipmap: true
    scale: iconArea.containsMouse ? 1.15 : 1.0
    visible: true

    // Hover animation 
    Behavior on scale { NumberAnimation { 
      duration: 300
      easing.type: Easing.OutBack
    }} 

    // Click animation
    SequentialAnimation on scale {
      id: clickAnimation
      running: false
      NumberAnimation { to: 0.90; duration: 90 }
      NumberAnimation { to: 1.15; duration: 90 }
    }
  }
}
