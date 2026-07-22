pragma Singleton

import QtQuick
import qs

QtObject {
  id: root

  function alpha(baseColor, alpha) {
    return Qt.rgba(baseColor?.r, baseColor?.g, baseColor?.b, alpha)
  }

  // property list<string> availableThemes: _palettes.keys
  property string activeTheme: Config.theme

  readonly property var _palettes: ({
    'matugen': {
      red: '#ff0000',
      // orange: 
      // yellow:
      // green:
      // teal:
      // blue:
      // purple: 

      background: Matugen.background,
      foreground: Matugen.foreground,
      outline: Matugen.outline,
      outlineVariant: Matugen.outlineVariant,
      shadow: Matugen.shadow,
      scrim: Matugen.scrim,
      // sourceColor: Matugen.sourceColor,

      primary: Matugen.primary,
      mOnPrimary: Matugen.mOnPrimary,
      primaryContainer: Matugen.primaryContainer,
      mOnPrimaryContainer: Matugen.mOnPrimaryContainer,
      inversePrimary: Matugen.inversePrimary,
      primaryFixed: Matugen.primaryFixed,
      primaryFixedDim: Matugen.primaryFixedDim,
      mOnPrimaryFixed: Matugen.mOnPrimaryFixed,
      mOnPrimaryFixedVariant: Matugen.mOnPrimaryFixedVariant,

      secondary: Matugen.secondary,
      mOnSecondary: Matugen.mOnSecondary,
      secondaryContainer: Matugen.secondaryContainer,
      mOnSecondaryContainer: Matugen.mOnSecondaryContainer,
      secondaryFixed: Matugen.secondaryFixed,
      secondaryFixedDim: Matugen.secondaryFixedDim,
      mOnSecondaryFixed: Matugen.mOnSecondaryFixed,
      mOnSecondaryFixedVariant: Matugen.mOnSecondaryFixedVariant,

      tertiary: Matugen.tertiary,
      mOnTertiary: Matugen.mOnTertiary,
      tertiaryContainer: Matugen.tertiaryContainer,
      mOnTertiaryContainer: Matugen.mOnTertiaryContainer,
      tertiaryFixed: Matugen.tertiaryFixed,
      tertiaryFixedDim: Matugen.tertiaryFixedDim,
      mOnTertiaryFixed: Matugen.mOnTertiaryFixed,
      mOnTertiaryFixedVariant: Matugen.mOnTertiaryFixedVariant,

      error: Matugen.error,
      mOnError: Matugen.mOnError,
      errorContainer: Matugen.errorContainer,
      mOnErrorContainer: Matugen.mOnErrorContainer,

      surface: Matugen.surface,
      mOnSurface: Matugen.mOn_surface,
      surfaceDim: Matugen.surfaceDim,
      surfaceBright: Matugen.surfaceBright,
      surfaceContainerLowest: Matugen.surfaceContainerLowest,
      surfaceContainerLow: Matugen.surfaceContainerLow,
      surfaceContainer: Matugen.surfaceContainer,
      surfaceContainerHigh: Matugen.surfaceContainerHigh,
      surfaceContainerHighest: Matugen.surfaceContainerHighest,
      surfaceVariant: Matugen.surfaceVariant,
      mOnSurfaceVariant: Matugen.mOnSurfaceVariant,
      inverseSurface: Matugen.inverseSurface,
      inverseOnSurface: Matugen.inverseOnSurface
    },

    'rumda': {
      background: '#5F4A42',
      foreground: '#FCD7BA',
      outline: '#E9CEBE',
      outlineVariant: '#512324',
      shadow: '#512324',
      scrim: '#512324',

      primary: '#809FBF',

      secondary: '#899797',
      
      surface: '',
      surfaceDim: '#482C28',
      surfaceBright: '',


    },

    'nord': {
      red: '#bf616a',
      orange: '##d08770',
      yellow: '#ebcb8b',
      green: '#a3be8c',
      aqua: '#8fbcbb',
      blue: '#81a1c1',
      purple: '#b48ead',

      background: '#2e3440',  // nord1
      foreground: '#d8dee9',  // nord4
      outline: '#d8dee9',
      outlineVariant: '#4c566a',
      shadow: '#000000',
      scrim: '#2e3440',

      primary: '#8fbcbb',  // nord8
    //   mOnPrimary: 
    //   primaryContainer: 
    //   mOnPrimaryContainer: 
    //   inversePrimary: 
    //   primaryFixed: 
    //   primaryFixedDim: 
    //   mOnPrimaryFixed: 
    //   mOnPrimaryFixedVariant: 

      secondary: '#a3be8c',
    //   mOnSecondary: 
    //   secondaryContainer: 
    //   mOnSecondaryContainer: 
    //   secondaryFixed: 
    //   secondaryFixedDim: 
    //   mOnSecondaryFixed: 
    //   mOnSecondaryFixedVariant: 

    //   tertiary: 
    //   mOnTertiary: 
    //   tertiaryContainer: 
    //   mOnTertiaryContainer: 
    //   tertiaryFixed: 
    //   tertiaryFixedDim: 
    //   mOnTertiaryFixed: 
    //   mOnTertiaryFixedVariant: 

    //   error: 
    //   mOnError: 
    //   errorContainer: 
    //   mOnErrorContainer: 

      surface: '#2e3440',
      mOnSurface: '#d8dee9', 
      surfaceDim: '#1f242e',
      surfaceBright: '#4c566a', // nord3
    //   surfaceContainerLowest: 
    //   surfaceContainerLow: 
    //   surfaceContainer: 
    //   surfaceContainerHigh: 
    //   surfaceContainerHighest: 
    //   surfaceVariant: 
      mOnSurfaceVariant: '#7b8596',
    //   inverseSurface: 
    //   inverseOnSurface: 
    },

    'gruvbox-material': {
      red: "#EA6962",
      orange: "#E78A4E",
      yellow: "#D8A657",
      green: "#A9B665",
      aqua: "#89B482",
      blue: "#7DAEA3",
      purple: "#D699B6",

      background: '#282828',
      foreground: '#ddc7a1',
      outline: '#a89984',
      outlineVariant: '#504945',
      shadow: '#000000',
      scrim: '#252423',

      // primary: '#a9b665',
      // primary: '#89b482',
      primary: "#D8A657",
      mOnPrimary: '#414900',
      primaryContainer: '#32361a',
      mOnPrimaryContainer: '#6E7257',
    //   inversePrimary: 
    //   primaryFixed: 
    //   primaryFixedDim: 
    //   mOnPrimaryFixed: 
    //   mOnPrimaryFixedVariant: 

      secondary: '#E78A4E',
      mOnSecondary: '#623C00',
      secondaryContainer: '#473c29',
      mOnSecondaryContainer: '#827865',
    //   secondaryFixed: 
    //   secondaryFixedDim: 
    //   mOnSecondaryFixed: 
    //   mOnSecondaryFixedVariant: 

      tertiary: '#7daea3',
      mOnTertiary: '#1E463F',
      tertiaryContainer: '#0d3138',
      mOnTertiaryContainer: '#506E75',
    //   tertiaryFixed: 
    //   tertiaryFixedDim: 
    //   mOnTertiaryFixed: 
    //   mOnTertiaryFixedVariant: 

      error: '#ea6962',
      mOnError:  '#6E0008',
      errorContainer: '#3c1f1e',
      mOnErrorContainer: '#7B5D5B', 

      surface: '#282828',
      mOnSurface: '#d4be98',
      surfaceDim: '#141617',
      surfaceBright: '#3c3836',
    //   surfaceContainerLowest: 
    //   surfaceContainerLow: 
    //   surfaceContainer: 
    //   surfaceContainerHigh: 
    //   surfaceContainerHighest: 
    //   surfaceVariant: 
      mOnSurfaceVariant: '#928374'
    //   inverseSurface: 
    //   inverseOnSurface: 
    },

    'kanagawa': {
      background: '#2E2E3A', 
      foreground: '#DBD6B9',
      outline: '#55556D',
      outlineVariant: '#55556D',
      shadow: '#1C1C22',
      scrim: '#1C1C22',
      // sourceColor: '',

      primary: '#97BA6C',
    //   mOnPrimary: 
    //   primaryContainer: 
    //   mOnPrimaryContainer: 
    //   inversePrimary: 
    //   primaryFixed: 
    //   primaryFixedDim: 
    //   mOnPrimaryFixed: 
    //   mOnPrimaryFixedVariant: 

      secondary: '#E5C283',
    //   mOnSecondary: 
    //   secondaryContainer: 
    //   mOnSecondaryContainer: 
    //   secondaryFixed: 
    //   secondaryFixedDim: 
    //   mOnSecondaryFixed: 
    //   mOnSecondaryFixedVariant: 

    //   tertiary: 
    //   mOnTertiary: 
    //   tertiaryContainer: 
    //   mOnTertiaryContainer: 
    //   tertiaryFixed: 
    //   tertiaryFixedDim: 
    //   mOnTertiaryFixed: 
    //   mOnTertiaryFixedVariant: 

      error: '#E72929',
      mOnError: '#DBD6B9',
      errorContainer: '#FF5D62',
      mOnErrorContainer: '#E72929',

      surface: '#2E2E3A',
      mOnSurface: '#DBD6B9',
      surfaceDim: '#23242C',
      surfaceBright: '#393948',
    //   surfaceContainerLowest: 
    //   surfaceContainerLow: 
    //   surfaceContainer: 
    //   surfaceContainerHigh: 
    //   surfaceContainerHighest: 
    //   surfaceVariant: 
    //   mOnSurfaceVariant: 
    //   inverseSurface: 
    //   inverseOnSurface: 
    },
  })


  readonly property color _debug: '#ff00ff'
  readonly property color debug: Colors.alpha(_debug, 0.0)
  readonly property color red: _palettes[activeTheme].red
  // readonly property color red: _palettes[activeTheme].red
  // readonly property color orange: _palettes[activeTheme].orange
  // readonly property color yellow: _palettes[activeTheme].yellow
  // readonly property color green: _palettes[activeTheme].green
  // readonly property color teal: _palettes[activeTheme].teal
  // readonly property color blue: _palettes[activeTheme].blue
  // readonly property color purple: _palettes[activeTheme].purple
  
  readonly property color foreground: _palettes[activeTheme].foreground

  readonly property color primary: _palettes[activeTheme].primary
  // readonly property color mOnPrimary: _palettes[activeTheme].mOnPrimary
  // readonly property color primaryContainer: _palettes[activeTheme].primaryContainer
  // readonly property color mOnPrimaryContainer: _palettes[activeTheme].mOnPrimaryContainer
  // readonly property color inversePrimary: _palettes[activeTheme].inversePrimary
  // readonly property color primaryFixed: _palettes[activeTheme].primaryFixed
  // readonly property color primaryFixedDim: _palettes[activeTheme].primaryFixedDim
  // readonly property color mOnPrimaryFixed: _palettes[activeTheme].mOnPrimaryFixed
  // readonly property color mOnPrimaryFixedVariant: _palettes[activeTheme].mOnPrimaryFixedVariant
  //
  readonly property color secondary: _palettes[activeTheme].secondary
  // readonly property color mOnSecondary: _palettes[activeTheme].mOnSecondary
  // readonly property color secondaryContainer: _palettes[activeTheme].secondaryContainer
  // readonly property color mOnSecondaryContainer: _palettes[activeTheme].mOnSecondaryContainer
  // readonly property color secondaryFixed: _palettes[activeTheme].secondaryFixed
  // readonly property color secondaryFixedDim: _palettes[activeTheme].secondaryFixedDim
  // readonly property color mOnSecondaryFixed: _palettes[activeTheme].mOnSecondaryFixed
  // readonly property color mOnSecondaryFixedVariant: _palettes[activeTheme].mOnSecondaryFixedVariant
  //
  // readonly property color tertiary: _palettes[activeTheme].tertiary
  // readonly property color mOnTertiary: _palettes[activeTheme].mOnTertiary
  // readonly property color tertiaryContainer: _palettes[activeTheme].tertiaryContainer
  // readonly property color mOnTertiaryContainer: _palettes[activeTheme].mOnTertiaryContainer
  // readonly property color tertiaryFixed: _palettes[activeTheme].tertiaryFixed
  // readonly property color tertiaryFixedDim: _palettes[activeTheme].tertiaryFixedDim
  // readonly property color mOnTertiaryFixed: _palettes[activeTheme].mOnTertiaryFixed
  // readonly property color mOnTertiaryFixedVariant: _palettes[activeTheme].mOnTertiaryFixedVariant
  //
  readonly property color error: _palettes[activeTheme].error
  readonly property color mOnError: _palettes[activeTheme].mOnError
  readonly property color errorContainer: _palettes[activeTheme].errorContainer
  readonly property color mOnErrorContainer: _palettes[activeTheme].mOnErrorContainer
  //
  readonly property color surface: _palettes[activeTheme].surface
  // readonly property color mOnSurface: _palettes[activeTheme].mOn_surface
  readonly property color surfaceDim: _palettes[activeTheme].surfaceDim
  readonly property color surfaceBright: _palettes[activeTheme].surfaceBright
  // readonly property color surfaceContainerLowest: _palettes[activeTheme].surfaceContainerLowest
  // readonly property color surfaceContainerLow: _palettes[activeTheme].surfaceContainerLow
  // readonly property color surfaceContainer: _palettes[activeTheme].surfaceContainer
  // readonly property color surfaceContainerHigh: _palettes[activeTheme].surfaceContainerHigh
  // readonly property color surfaceContainerHighest: _palettes[activeTheme].surfaceContainerHighest
  // readonly property color surfaceVariant: _palettes[activeTheme].surfaceVariant
  readonly property color mOnSurfaceVariant: _palettes[activeTheme].mOnSurfaceVariant
  // readonly property color inverseSurface: _palettes[activeTheme].inverseSurface
  // readonly property color inverseOnSurface: _palettes[activeTheme].inverseOnSurface
  //
  readonly property color outline: _palettes[activeTheme].outline
  readonly property color outlineVariant: _palettes[activeTheme].outlineVariant
  readonly property color shadow: _palettes[activeTheme].shadow
  // readonly property color scrim: _palettes[activeTheme].scrim
  // readonly property color sourceColor: _palettes[activeTheme].sourceColor
}

