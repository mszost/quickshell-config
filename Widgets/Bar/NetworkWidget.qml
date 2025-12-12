import QtQuick
import Quickshell

import qs.Components


BarWidget {
    text: 'Red5Blue'
    icon: '\uEB52' 
    iconSize: 18
    onClicked: console.log(Quickshell.screens[2]) 
}
