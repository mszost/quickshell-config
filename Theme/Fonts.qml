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
    pixelSize: 15,
    weight: 600
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

  readonly property font rubik: Qt.font({
    family: "Rubik",
    pixelSize: 12,
    weight: 400
  })


  // loading local fonts
  readonly property FontLoader _lucideLoader: FontLoader { source: "../assets/fonts/lucide.ttf" }  
  readonly property FontLoader _tablerLoader: FontLoader { source: "../assets/fonts/tabler-icons-300.ttf" }  
}

