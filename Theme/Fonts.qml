pragma Singleton

import QtQuick

QtObject {
  id: root

  // semantic properties
  readonly property font barIcon: tabler
  readonly property font barText: sfProRounded


  // font definitions
  readonly property font lucide: Qt.font({
    family: _lucideLoader.name,
    pixelSize: 14,
    weight: 900
  })

  readonly property font tabler: Qt.font({
    family: _tablerLoader.name,
    pixelSize: 24,
  })

  readonly property font sfProRounded: Qt.font({
    family: "SF Pro Rounded",
    pixelSize: 12,
    weight: 600
     })


  // loading local fonts
  readonly property FontLoader _lucideLoader: FontLoader { source: "/home/msz/.config/quickshell/assets/fonts/lucide.ttf" }  
  readonly property FontLoader _tablerLoader: FontLoader { source: "/home/msz/.config/quickshell/assets/fonts/tabler-icons-300.ttf" }  
  // readonly property FontLoader _tablerLoader: FontLoader { source: "/home/msz/.config/quickshell/assets/fonts/tabler-icons.ttf" }  
}


