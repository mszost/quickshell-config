/* 
 See https://tabler.io/icons for the available icon set and the corresponding unicode strings. 

 Very new icons might not be available yet - the font this project uses was compiled
 from release v3.36.1: https://github.com/tabler/tabler-icons/releases/tag/v3.36.1
 
 Note that the keys for some icons do not match if the original naming was weird
*/

pragma Singleton

import Quickshell

Singleton {
  readonly property string alertTriangle: '\uEA06' 
  readonly property string adjustments: '\uEA03'
  
  readonly property string power: '\uEB0D'
  readonly property string logout: '\uEBA8'
  readonly property string reload: '\uF3AE'
  readonly property string zzz: '\uF228'
  
  readonly property string battery0: '\uEA34'
  readonly property string battery1: '\uEA2F'
  readonly property string battery2: '\uEA30'
  readonly property string battery3: '\uEA31'
  readonly property string battery4: '\uEA32'
  readonly property string batteryOff: '\uED1C'
  readonly property string batteryCharging: '\uEA33'
  readonly property string batteryCritical: '\uFF1D'  // battery-exclamation
  readonly property string batteryPlugged: '\uEF3B'   // battery-charging-2
  readonly property string batterySpark: '\uFFBD'

  readonly property string wifi0: '\uF9E6'  // world-question
  readonly property string wifi1: '\uEBA3'  // wifi-0
  readonly property string wifi2: '\uEBA4'  // wifi-1
  readonly property string wifi3: '\uEBA5'  // wifi-2
  readonly property string wifi4: '\uEB52'  // wifi
  readonly property string wifiOff: '\uECFA'
  readonly property string router: '\uEB18' 
  readonly property string ethernet: '\uEB9D'  // sitemap 
  readonly property string worldX: '\uF9EB' 
  
  readonly property string volume0: '\uEB50'                      // volume-3
  readonly property string volume1: String.fromCodePoint(0x1019d)  // volume-4
  readonly property string volume2: '\uEB4F'                       // volume-2
  readonly property string volume3: '\uEB51'                      // volume
  readonly property string volumeMute: '\uF1C3'                      // volume-off
  
  readonly property string usb: '\uF00C'
  readonly property string laptop: '\uEB64'
  readonly property string headphones: '\uEABD'
  readonly property string airpods: '\uF5A9'  // device-airpods
  readonly property string speaker: '\uEA8B'  // device-speakers
  
  readonly property string sun: '\uEB30'
  readonly property string sunTemperature: '\uFDA4'
  readonly property string cloudDownload: '\uEA71'
}

