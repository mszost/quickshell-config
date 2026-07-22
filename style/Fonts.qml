pragma Singleton

import QtQuick

QtObject {
  id: root

  // loading local fonts
  readonly property FontLoader _jetbrainsLoader:  FontLoader { source: '../assets/fonts/JetBrainsMono-variable.ttf' }  
  readonly property FontLoader _ibmPlexLoader:    FontLoader { source: '../assets/fonts/IBMPlexSans-Variable.ttf' }  
  readonly property FontLoader _rubikLoader:      FontLoader { source: '../assets/fonts/Rubik-Variable.ttf' }  
  readonly property FontLoader _lucideLoader:     FontLoader { source: '../assets/fonts/lucide.ttf' }  
  readonly property FontLoader _tablerLoader:     FontLoader { source: '../assets/fonts/tabler-icons.ttf' } 
  readonly property FontLoader _cartographLoader: FontLoader { source: '../assets/fonts/CartographCF-Regular.otf' }

  // properties named after fonts
  readonly property font jetbrains:  Qt.font({ family: _jetbrainsLoader.name,  pixelSize: 12, weight: 700 }) 
  readonly property font cartograph: Qt.font({ family: _cartographLoader.name, pixelSize: 12, weight: 400 })
  readonly property font ibmPlex:    Qt.font({ family: _ibmPlexLoader.name,    pixelSize: 12, weight: 500 })
  readonly property font rubik:      Qt.font({ family: _rubikLoader.name,      pixelSize: 12, weight: 600 })
  readonly property font lucide:     Qt.font({ family: _lucideLoader.name,     pixelSize: 14, weight: 700 })
  readonly property font tabler:     Qt.font({ family: _tablerLoader.name,     pixelSize: 13, weight: 600 })

  // properties named after their semantic use
  readonly property font barIcon: tabler
  readonly property font barLabel: cartograph

  readonly property font osdLabel: ibmPlex 
  readonly property font osdIcon: Qt.font({ family: _tablerLoader.name, pixelSize: 24, weight: 600})

  readonly property font menuHeading:     Qt.font({ family: _rubikLoader.name,   pixelSize: 16, weight: 600 })
  readonly property font menuHeadingIcon: Qt.font({ family: _tablerLoader.name,  pixelSize: 22, weight: 600 })
  readonly property font menuSubheading:  Qt.font({ family: _ibmPlexLoader.name, pixelSize: 13, weight: 500 })  
  readonly property font menuBody: ibmPlex 
}

