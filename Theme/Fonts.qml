pragma Singleton

import QtQuick

QtObject {
  id: root

  // loading local fonts
  // readonly property FontLoader _geistLoader: FontLoader { source: "../assets/fonts/Geist-Variable.ttf" }  
  // readonly property FontLoader _workSansLoader: FontLoader { source: "../assets/fonts/WorkSans-Variable.ttf" }  
  // readonly property FontLoader _justSansLoader: FontLoader { source: "../assets/fonts/JUST Sans Regular.otf" }  
  // readonly property FontLoader _givonicLoader: FontLoader { source: "../assets/fonts/Givonic-Regular.otf" }  

  // readonly property FontLoader _vigaLoader: FontLoader { source: "../assets/fonts/Viga-Regular.ttf" }  
  // readonly property FontLoader _interLoader: FontLoader { source: "../assets/fonts/Inter-Variable.ttf" }  
  // readonly property FontLoader _interTightLoader: FontLoader { source: "../assets/fonts/InterTight-Variable.ttf" }  
  readonly property FontLoader _jetbrainsLoader:  FontLoader { source: "../assets/fonts/JetBrainsMono-variable.ttf" }  
  readonly property FontLoader _ibmPlexLoader: FontLoader { source: "../assets/fonts/IBMPlexSans-Variable.ttf" }  
  readonly property FontLoader _rubikLoader:   FontLoader { source: "../assets/fonts/Rubik-Variable.ttf" }  
  readonly property FontLoader _lucideLoader:  FontLoader { source: "../assets/fonts/lucide.ttf" }  
  readonly property FontLoader _tablerLoader:  FontLoader { source: "../assets/fonts/tabler-icons-300.ttf" }  


  // properties named after fonts
  // readonly property font geist:      Qt.font({ family: _geistLoader.name,      pixelSize: 12, weight: 700 })
  // readonly property font workSans:   Qt.font({ family: _workSansLoader.name,   pixelSize: 14, weight: 600 })
  // readonly property font givonic:    Qt.font({ family: _givonicLoader.name,    pixelSize: 13, weight: 700 })
  // readonly property font inter:      Qt.font({ family: _interLoader.name,      pixelSize: 12, weight: 700 })
  // readonly property font interTight: Qt.font({ family: _interTightLoader.name, pixelSize: 12, weight: 700 })

  readonly property font jetbrains: Qt.font({ family: _jetbrainsLoader.name, pixelSize: 13, weight: 700 }) 
  readonly property font ibmPlex:   Qt.font({ family: _ibmPlexLoader.name,   pixelSize: 13, weight: 500 })
  readonly property font rubik:     Qt.font({  family: _rubikLoader.name,    pixelSize: 12, weight: 600 })
  readonly property font lucide:    Qt.font({ family: _lucideLoader.name,    pixelSize: 14, weight: 700 })
  readonly property font tabler:    Qt.font({ family: _tablerLoader.name,    pixelSize: 18, weight: 600 })

  // readonly property font sfProRounded: Qt.font({ family: "SF Pro Rounded",   pixelSize: 12, weight: 600 })


  // properties named after their semantic use
  readonly property font barIcon: tabler
  readonly property font barLabel: ibmPlex

  readonly property font osdLabel: ibmPlex 
  readonly property font osdIcon: Qt.font({ family: _tablerLoader.name, pixelSize: 24, weight: 600})

  readonly property font menuHeading:     Qt.font({ family: _rubikLoader.name,   pixelSize: 18, weight: 600 })
  readonly property font menuHeadingIcon: Qt.font({ family: _tablerLoader.name,  pixelSize: 22, weight: 600 })
  readonly property font menuSubheading:  Qt.font({ family: _ibmPlexLoader.name, pixelSize: 14, weight: 500 })  
  readonly property font menuBody: ibmPlex 
}

