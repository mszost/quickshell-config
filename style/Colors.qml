pragma Singleton

import QtQuick
import Quickshell
import qs

Singleton {
  id: root

  readonly property string activePalette: Config.theme
  
  readonly property var _palettes: ({
    // 'matugen': {
    //   red: '#ff0000',
    //   // orange: 
    //   // yellow:
    //   // green:
    //   // teal:
    //   // blue:
    //   // purple: 
    //
    //   background: Matugen.background,
    //   foreground: Matugen.foreground,
    //   outline: Matugen.outline,
    //   outlineVariant: Matugen.outlineVariant,
    //   shadow: Matugen.shadow,
    //   scrim: Matugen.scrim,
    //   // sourceColor: Matugen.sourceColor,
    //
    //   primary: Matugen.primary,
    //   mOnPrimary: Matugen.mOnPrimary,
    //   primaryContainer: Matugen.primaryContainer,
    //   mOnPrimaryContainer: Matugen.mOnPrimaryContainer,
    //   inversePrimary: Matugen.inversePrimary,
    //   primaryFixed: Matugen.primaryFixed,
    //   primaryFixedDim: Matugen.primaryFixedDim,
    //   mOnPrimaryFixed: Matugen.mOnPrimaryFixed,
    //   mOnPrimaryFixedVariant: Matugen.mOnPrimaryFixedVariant,
    //
    //   secondary: Matugen.secondary,
    //   mOnSecondary: Matugen.mOnSecondary,
    //   secondaryContainer: Matugen.secondaryContainer,
    //   mOnSecondaryContainer: Matugen.mOnSecondaryContainer,
    //   secondaryFixed: Matugen.secondaryFixed,
    //   secondaryFixedDim: Matugen.secondaryFixedDim,
    //   mOnSecondaryFixed: Matugen.mOnSecondaryFixed,
    //   mOnSecondaryFixedVariant: Matugen.mOnSecondaryFixedVariant,
    //
    //   tertiary: Matugen.tertiary,
    //   mOnTertiary: Matugen.mOnTertiary,
    //   tertiaryContainer: Matugen.tertiaryContainer,
    //   mOnTertiaryContainer: Matugen.mOnTertiaryContainer,
    //   tertiaryFixed: Matugen.tertiaryFixed,
    //   tertiaryFixedDim: Matugen.tertiaryFixedDim,
    //   mOnTertiaryFixed: Matugen.mOnTertiaryFixed,
    //   mOnTertiaryFixedVariant: Matugen.mOnTertiaryFixedVariant,
    //
    //   error: Matugen.error,
    //   mOnError: Matugen.mOnError,
    //   errorContainer: Matugen.errorContainer,
    //   mOnErrorContainer: Matugen.mOnErrorContainer,
    //
    //   surface: Matugen.surface,
    //   mOnSurface: Matugen.mOn_surface,
    //   surfaceDim: Matugen.surfaceDim,
    //   surfaceBright: Matugen.surfaceBright,
    //   surfaceContainerLowest: Matugen.surfaceContainerLowest,
    //   surfaceContainerLow: Matugen.surfaceContainerLow,
    //   surfaceContainer: Matugen.surfaceContainer,
    //   surfaceContainerHigh: Matugen.surfaceContainerHigh,
    //   surfaceContainerHighest: Matugen.surfaceContainerHighest,
    //   surfaceVariant: Matugen.surfaceVariant,
    //   mOnSurfaceVariant: Matugen.mOnSurfaceVariant,
    //   inverseSurface: Matugen.inverseSurface,
    //   inverseOnSurface: Matugen.inverseOnSurface
    // },
    //
    // 'rumda': {
    //   background: '#5F4A42',
    //   foreground: '#FCD7BA',
    //   outline: '#E9CEBE',
    //   outlineVariant: '#512324',
    //   shadow: '#512324',
    //   scrim: '#512324',
    //
    //   primary: '#809FBF',
    //
    //   secondary: '#899797',
    //
    //   surface: '',
    //   surfaceDim: '#482C28',
    //   surfaceBright: '',
    // },

    'nord': {
      red: '#bf616a',
      orange: '##d08770',
      yellow: '#ebcb8b',
      green: '#a3be8c',
      cyan: '#8fbcbb',
      blue: '#81a1c1',
      purple: '#b48ead',

      background: '#2e3440',  // nord1
      foreground: '#d8dee9',  // nord4
      outline: '#4c566a',
      outlineVariant: '#d8dee9',
      shadow: '#000000',
      scrim: '#2e3440',

      primary: '#8fbcbb',  // nord8
      secondary: '#a3be8c',

      surface:  '#1f242e',
      mOnSurface: '#d8dee9', 
      surfaceDim: '#191B20',
      surfaceBright: '#2e3440',  // nord3
      mOnSurfaceVariant: '#7b8596' // '#4c566a',

    },

    'gruvbox-material': {
      red: "#EA6962",
      orange: "#E78A4E",
      yellow: "#D8A657",
      green: "#A9B665",
      cyan: "#89B482",
      blue: "#7DAEA3",
      purple: "#D699B6",

      background: '#282828',
      foreground: '#ddc7a1',
      outline: '#3c3836',
      outlineVariant: '#a89984',
      shadow: '#000000',
      scrim: '#252423',

      // primary: '#a9b665',
      // primary: '#89b482',
      primary: "#D8A657",
      mOnPrimary: '#414900',
      primaryContainer: '#32361a',
      mOnPrimaryContainer: '#6E7257',
      secondary: '#E78A4E',
      mOnSecondary: '#623C00',
      secondaryContainer: '#473c29',
      mOnSecondaryContainer: '#827865',
      tertiary: '#7daea3',
      mOnTertiary: '#1E463F',
      tertiaryContainer: '#0d3138',
      mOnTertiaryContainer: '#506E75',


      error: '#ea6962',
      mOnError:  '#6E0008',
      errorContainer: '#3c1f1e',
      mOnErrorContainer: '#7B5D5B', 

      surface: '#141617',
      mOnSurface: '#d4be98',
      surfaceDim: '#141617',
      surfaceBright: '#282828', //'#3c3836',
      mOnSurfaceVariant: '#928374'
    },

    'kanagawa': {
      red: "#EA6962",
      background: '#2E2E3A', 
      foreground: '#DBD6B9',
      outline: '#55556D',
      outlineVariant: '#55556D',
      shadow: '#1C1C22',
      scrim: '#1C1C22',
      primary: '#97BA6C',
      secondary: '#E5C283',
      error: '#E72929',
      mOnError: '#DBD6B9',
      errorContainer: '#FF5D62',
      mOnErrorContainer: '#E72929',
      surface: '#2E2E3A',
      mOnSurface: '#DBD6B9',
      surfaceDim: '#23242C',
      surfaceBright: '#393948',
  },

  'jade': { 
    surface: '#081512',
    mOnSurface: '#8CDE94', 
    surfaceDim: '#000000',
    surfaceBright: '#0F251F', //'#166050',
    mOnSurfaceVariant: '#7b8596',

    red: '#FF0000',
    orange: '#FF6B3D',
    yellow: '#EAC786',
    green: '#42BE65',
    cyan: '#22D3EE',
    blue: '#3584E4',
    purple: '#B877DB',

    outline: '#0F251F',
    outlineVariant: '#4c566a',
    shadow: '#000000',
    scrim: '#2e3440',

    primary: '#8CDE94',
    secondary: '#F6C177',
  },

  'solarized-light': { 
    surfaceDim: '#EEE8D5',
    mOnSurface: '#002B36', 
    surface: '#D3CCB3',
    surfaceBright: '#FDF6E3',
    mOnSurfaceVariant: '#7b8596',

    red: '#DC322F',
    orange: '#CB4B16',
    yellow: '#B58900',
    green: '#859900',
    cyan: '#22D3EE',
    blue: '#3584E4',
    purple: '#B877DB',

    outline: '#0F251F',
    outlineVariant: '#4c566a',
    shadow: '#000000',
    scrim: '#2e3440',

    primary: '#D33682',
    secondary: '#6C71C4',
  },
})

  readonly property color brightGreen: '#4eed8e'

  readonly property color red: _palettes[activePalette].red
  readonly property color orange: _palettes[activePalette].orange
  readonly property color yellow: _palettes[activePalette].yellow
  // readonly property color green: _palettes[activePalette].green
  // readonly property color teal: _palettes[activePalette].teal
  // readonly property color blue: _palettes[activePalette].blue
  // readonly property color purple: _palettes[activePalette].purple
  
  // readonly property color foreground: _palettes[activePalette].foreground

  readonly property color primary: Config.accentColorPrimary || _palettes[activePalette].primary
  // readonly property color mOnPrimary: _palettes[activePalette].mOnPrimary
  // readonly property color primaryContainer: _palettes[activePalette].primaryContainer
  // readonly property color mOnPrimaryContainer: _palettes[activePalette].mOnPrimaryContainer
  // readonly property color inversePrimary: _palettes[activePalette].inversePrimary
  // readonly property color primaryFixed: _palettes[activePalette].primaryFixed
  // readonly property color primaryFixedDim: _palettes[activePalette].primaryFixedDim
  // readonly property color mOnPrimaryFixed: _palettes[activePalette].mOnPrimaryFixed
  // readonly property color mOnPrimaryFixedVariant: _palettes[activePalette].mOnPrimaryFixedVariant
  //
  readonly property color secondary: Config.accentColorSecondary || _palettes[activePalette].secondary
  // readonly property color mOnSecondary: _palettes[activePalette].mOnSecondary
  // readonly property color secondaryContainer: _palettes[activePalette].secondaryContainer
  // readonly property color mOnSecondaryContainer: _palettes[activePalette].mOnSecondaryContainer
  // readonly property color secondaryFixed: _palettes[activePalette].secondaryFixed
  // readonly property color secondaryFixedDim: _palettes[activePalette].secondaryFixedDim
  // readonly property color mOnSecondaryFixed: _palettes[activePalette].mOnSecondaryFixed
  // readonly property color mOnSecondaryFixedVariant: _palettes[activePalette].mOnSecondaryFixedVariant
  //
  // readonly property color tertiary: _palettes[activePalette].tertiary
  // readonly property color mOnTertiary: _palettes[activePalette].mOnTertiary
  // readonly property color tertiaryContainer: _palettes[activePalette].tertiaryContainer
  // readonly property color mOnTertiaryContainer: _palettes[activePalette].mOnTertiaryContainer
  // readonly property color tertiaryFixed: _palettes[activePalette].tertiaryFixed
  // readonly property color tertiaryFixedDim: _palettes[activePalette].tertiaryFixedDim
  // readonly property color mOnTertiaryFixed: _palettes[activePalette].mOnTertiaryFixed
  // readonly property color mOnTertiaryFixedVariant: _palettes[activePalette].mOnTertiaryFixedVariant
  //
  // readonly property color error: _palettes[activePalette].error
  // readonly property color mOnError: _palettes[activePalette].mOnError
  // readonly property color errorContainer: _palettes[activePalette].errorContainer
  // readonly property color mOnErrorContainer: _palettes[activePalette].mOnErrorContainer
  //
  readonly property color surface: _palettes[activePalette].surface
  readonly property color mOnSurface: _palettes[activePalette].mOnSurface
  readonly property color surfaceDim: _palettes[activePalette].surfaceDim
  readonly property color surfaceBright: _palettes[activePalette].surfaceBright
  // readonly property color surfaceContainerLowest: _palettes[activePalette].surfaceContainerLowest
  // readonly property color surfaceContainerLow: _palettes[activePalette].surfaceContainerLow
  // readonly property color surfaceContainer: _palettes[activePalette].surfaceContainer
  // readonly property color surfaceContainerHigh: _palettes[activePalette].surfaceContainerHigh
  // readonly property color surfaceContainerHighest: _palettes[activePalette].surfaceContainerHighest
  // readonly property color surfaceVariant: _palettes[activePalette].surfaceVariant
  readonly property color mOnSurfaceVariant: _palettes[activePalette].mOnSurfaceVariant
  // readonly property color inverseSurface: _palettes[activePalette].inverseSurface
  // readonly property color inverseOnSurface: _palettes[activePalette].inverseOnSurface
  //
  readonly property color outline: _palettes[activePalette].outline
  readonly property color outlineVariant: _palettes[activePalette].outlineVariant
  readonly property color shadow: _palettes[activePalette].shadow
  // readonly property color scrim: _palettes[activePalette].scrim
  // readonly property color sourceColor: _palettes[activePalette].sourceColor
}

