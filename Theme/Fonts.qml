pragma Singleton

import QtQuick

QtObject {
  id: root

  // semantic properties
  readonly property font barIcon: _lucide
  readonly property font barText: _sfProRounded


  // font definitions
  readonly property font _lucide: Qt.font({
    family: _lucideLoader.name,
    pixelSize: 14,
    weight: 900
  })

  readonly property font _sfProRounded: Qt.font({
    family: "SF Pro Rounded",
    pixelSize: 12,
    weight: 600
     })


  // loading local fonts
  readonly property FontLoader _lucideLoader: FontLoader { source: "/home/msz/.config/quickshell/assets/fonts/lucide.ttf" }  
}
