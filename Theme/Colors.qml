pragma Singleton

import QtQuick

QtObject {
  id: root

  property color debug: "#ff00ff"

  // Gruvbox Material theme
  property color red: "#EA6962"
  property color orange: "#E78A4E"
  property color yellow: "#D8A657" 
  property color green: "#A9B665"
  property color aqua: "#89B482"
  property color blue: "#7DAEA3" 
  property color purple: "#D699B6"
  // Pywal theme
  property color background: Pywal.background
  property color foreground: Pywal.foreground
  property color cursor: Pywal.cursor
  property color color0: Pywal.color0
  property color color1: Pywal.color1
  property color color2: Pywal.color2
  property color color3: Pywal.color3
  property color color4: Pywal.color4
  property color color5: Pywal.color5
  property color color6: Pywal.color6
  property color color7: Pywal.color7
  property color color8: Pywal.color8
  property color color9: Pywal.color9
  property color color10: Pywal.color10
  property color color11: Pywal.color11
  property color color12: Pywal.color12
  property color color13: Pywal.color13
  property color color14: Pywal.color14
  property color color15: Pywal.color15

  function applyAlpha(baseColor, alpha) {
    return Qt.rgba(baseColor.r, baseColor.g, baseColor.b, alpha)
  }

}

