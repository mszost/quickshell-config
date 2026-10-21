pragma Singleton

import QtQuick
import Quickshell
import qs

Singleton {
  id: root

  // loading local fonts
  readonly property FontLoader _jetbrainsLoader:  FontLoader { source: '../assets/fonts/JetBrainsMonoNerdFont-Regular.ttf' }  
  readonly property FontLoader _ibmPlexLoader:    FontLoader { source: '../assets/fonts/IBMPlexSans-Variable.ttf' }  
  // readonly property FontLoader _rubikLoader:      FontLoader { source: '../assets/fonts/Rubik-Variable.ttf' }  
  // readonly property FontLoader _lucideLoader:     FontLoader { source: '../assets/fonts/lucide.ttf' }  
  readonly property FontLoader _tablerLoader:     FontLoader { source: '../assets/fonts/tabler-icons.ttf' } 
  readonly property FontLoader _cartographLoader: FontLoader { source: '../assets/fonts/CartographCF-Regular.otf' }

  // properties named after fonts
  readonly property font jetbrainsMono:  Qt.font({ family: _jetbrainsLoader.name,  pixelSize: 12, weight: 700 }) 
  readonly property font cartograph: Qt.font({ family: _cartographLoader.name, pixelSize: 12, weight: 500 })
  readonly property font ibmPlexSans:    Qt.font({ family: _ibmPlexLoader.name,    pixelSize: 12, weight: 500 })
  readonly property font tabler:     Qt.font({ family: _tablerLoader.name,     pixelSize: 15, weight: 600 })
}
