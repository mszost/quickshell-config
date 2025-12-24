import QtQuick

import Quickshell

import qs.Components
import qs.Services


BarWidget {
    // text: 'Wi-Fi' 
    icon: '\uEB52' 
    iconSize: 20
    onClicked: console.log(Quickshell.screens[2]) 
}

