import QtQuick
import Quickshell

import qs.Components


BarWidgetRow {
    text: 'Red5Blue'
    icon: '\uE1AE' // network icon 
    iconWeight: 600
    iconSize: 15
    // layoutDirection: Qt.RightToLeft
    onClicked: console.log(Quickshell.screens[2]) 
}
