/* 
 See https://tabler.io/icons for the available icon set and the corresponding unicode strings. 

 Very new icons might not be available yet - the font this project uses was compiled
 from release v3.36.1: https://github.com/tabler/tabler-icons/releases/tag/v3.36.1
 
 Note that the keys for some icons do not match if the original naming was weird
*/

pragma Singleton

import Quickshell

Singleton {
  property var tabler: {
    'alert-triangle': '\uEA06',
    'adjustments': '\uEA03',


    'battery-3': '\uEA34',
    'battery-1': '\uEA2F',
    'battery-2': '\uEA30',
    'battery-3': '\uEA31',
    'battery-4': '\uEA32',
    'battery-off': '\uED1C',
    'battery-charging': '\uEA33',
    'battery-charging-2': '\uEF3B',
    'battery-exclamation': '\uFF1D',
    'battery-spark': '\uFFBD',

    'wifi': '\uEB52',
    'wifi-2': '\uEBA5',
    'wifi-1': '\uEBA4',
    'wifi-0': '\uEBA3',
    'wifi-off': '\uECFA',
    'router': '\uEB18',
    'sitemap': '\uEB9D',
    'world-x': '\uF9EB',
    'world-question': '\uF9E6',

    'volume-high': '\uEB51',                      // tabler's `volume`
    'volume-mid': '\uEB4F',                       // tabler's `volume-2`
    'volume-low': String.fromCodePoint(0x1019d),  // tabler's `volume-4`
    'volume-zero': '\uEB50',                      // tabler's `volume-3`
    'volume-mute': '\uF1C3',                      // tabler's `volume-off`

    'usb': '\uF00C',
    'laptop': '\uEB64',
    'headphones': '\uEABD',
    'device-airpods': '\uF5A9',
    'device-speaker': '\uEA8B',

    'cloud-download': '\uEA71',

    'sun': '\uEB30',
    'temperature-sun': '\uFDA4',
  }
}

