import QtQuick

import Quickshell

import qs.Components
import qs.Services


BarWidget {
    icon: '\uEB52' 
    iconSize: 20
    onClicked: console.log(Quickshell.screens[2]) 
}

