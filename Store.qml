pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs

// Persistent runtime state, saved to a JSON file and restored across shell reloads and restarts.
// Unlike Config, this is written by the shell itself, not the user.
//
// Each feature owns one section (a JsonObject), exposed here as a property. Read values with
// bindings (`Store.hyprsunset.gamma`) and assign to them to save (`Store.hyprsunset.gamma = 80`).
// To add a section, declare it in the adapter and alias it below. Keys missing from the file keep
// their declared defaults, so sections and keys can be added without migrating existing files.
Singleton {
  id: root

  readonly property string path: Config.storePath || Quickshell.statePath('state.json')

  readonly property alias hyprsunset: adapter.hyprsunset

  FileView {
    id: file
    path: root.path
    blockLoading: true  // Load before anything binds, so defaults never flash or overwrite the file
    atomicWrites: true
    printErrors: false  // A missing file is expected on first run; other errors are logged below

    onAdapterUpdated: saveTimer.restart()
    onLoadFailed: (error) => {
      if (error === FileViewError.FileNotFound) writeAdapter()
      else console.warn(`Store: failed to load ${root.path} (${FileViewError.toString(error)})`)
    }
    onSaveFailed: (error) => console.warn(`Store: failed to save ${root.path} (${FileViewError.toString(error)})`)

    JsonAdapter {
      id: adapter

      property JsonObject hyprsunset: JsonObject {
        property bool enabled: false
        property int temperature: Config.module.hyprsunset.defaultTemperature
        property int gamma: Config.module.hyprsunset.defaultGamma
      }
    }
  }

  // Batches rapid changes (e.g. dragging a slider) into one write.
  Timer {
    id: saveTimer
    interval: Config.storeSaveDelay
    onTriggered: file.writeAdapter()
  }
}
