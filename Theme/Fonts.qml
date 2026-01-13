pragma Singleton

import QtQuick

QtObject {
  id: root

  // loading local fonts
  readonly property FontLoader _lucideLoader: FontLoader { source: "../assets/fonts/lucide.ttf" }  
  readonly property FontLoader _tablerLoader: FontLoader { source: "../assets/fonts/tabler-icons-300.ttf" }  


  // properties named after fonts
  readonly property font monospace:    Qt.font({ family: "JetBrainsMono Nerd Font",    pixelSize: 13, weight: 600 }) 
  readonly property font sfProRounded: Qt.font({ family: "SF Pro Rounded",   pixelSize: 12, weight: 600 })
  readonly property font rubik: Qt.font({        family: "Rubik",            pixelSize: 12, weight: 600 })
  readonly property font lucide: Qt.font({       family: _lucideLoader.name, pixelSize: 15, weight: 600 })
  readonly property font tabler: Qt.font({       family: _tablerLoader.name, pixelSize: 18, weight: 600 })


  // properties named after their semantic use
  readonly property font barIcon: tabler
  readonly property font barLabel: sfProRounded

  readonly property font menuHeading: Qt.font({     family: "Rubik",            pixelSize: 16, weight: 600 })
  readonly property font menuHeadingIcon: Qt.font({ family: _tablerLoader.name, pixelSize: 22, weight: 600 })
  readonly property font menuSubheading: Qt.font({  family: "Rubik",            pixelSize: 14, weight: 400 })  
  readonly property font menuBody: Qt.font({        family: "Rubik",            pixelSize: 12, weight: 400 })
}

