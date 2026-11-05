pragma Singleton

import QtQuick
import Quickshell
import qs

Singleton {
  id: root

  // loading local fonts
  readonly property FontLoader jetbrainsLoader:   FontLoader { source: '../assets/fonts/JetBrainsMonoNerdFont-Regular.ttf' }  
  readonly property FontLoader ibmPlexSansLoader: FontLoader { source: '../assets/fonts/IBMPlexSans-Variable.ttf' }  
  readonly property FontLoader rubikLoader:       FontLoader { source: '../assets/fonts/Rubik-Variable.ttf' }  
  readonly property FontLoader tablerLoader:      FontLoader { source: '../assets/fonts/tabler-icons.ttf' } 
  readonly property FontLoader cartographLoader:  FontLoader { source: '../assets/fonts/CartographCF-Regular.otf' }

  // properties named after fonts
  readonly property font jetbrainsMono:  Qt.font({ family: jetbrainsLoader.name,   pixelSize: 12, weight: 700 }) 
  readonly property font cartograph:     Qt.font({ family: cartographLoader.name,  pixelSize: 12, weight: 500 })
  readonly property font ibmPlexSans:    Qt.font({ family: ibmPlexSansLoader.name, pixelSize: 12, weight: 500 })
  readonly property font tabler:         Qt.font({ family: tablerLoader.name,      pixelSize: 15, weight: 600 })
}
