import CodeMirror from "codemirror"

keywords = [
  "Show"
  "Hide"
  "Mixin"
]

macroNames = [
  "Prop"
  "Var"
]

functionNames = [
  "Negate"
  "Grayscale"
  "Saturate"
  "Desaturate"
  "Lighten"
  "Darken"
  "Whiten"
  "Blacken"
  "Hex"
  "Saturation"
  "Lightness"
  "Plus"
  "Minus"
]

conditionNames = [
  "Class"
  "BaseType"
  "Prophecy"
  "DropLevel"
  "ItemLevel"
  "GemLevel"
  "StackSize"
  "MapTier"
  "Quality"
  "LinkedSockets"
  "Sockets"
  "SocketGroup"
  "Rarity"
  "ShaperItem"
  "ElderItem"
  "Corrupted"
  "Identified"
  "ShapedMap"
  "Height"
  "Width"
  "HasExplicitMod"
]

actionNames = [
  "SetBorderColor"
  "SetTextColor"
  "SetBackgroundColor"
  "SetFontSize"
  "PlayAlertSound"
  "PlayAlertSoundPositional"
  "DisableDropSound"
  "CustomAlertSound"
  "MinimapIcon"
  "PlayEffect"
]

CodeMirror.defineMode "advanced-poe-filter", () =>
  token: (stream, state) =>
    return 'outputcomment' if stream.match /^.*#:.*/
    return 'comment'   if stream.match /^.*#.*/
    return 'keyword'   if stream.match new RegExp "^(#{keywords.join('|')}) +\"[^\"]+\""
    return 'macro'     if stream.match new RegExp "^(#{macroNames.join('|')})\\(.*\\)"
    return 'function'  if stream.match new RegExp "^(#{functionNames.join('|')})\\(.*\\)"
    return 'condition' if stream.match new RegExp "^(#{conditionNames.join('|')})"
    return 'action'    if stream.match new RegExp "^(#{actionNames.join('|')})"
    return 'space'     if stream.match new RegExp "^ "

    stream.next()

CodeMirror.defineMode "original-poe-filter", () =>
  token: (stream, state) =>
    return 'comment'   if stream.match /^.*#.*/
    return 'keyword'   if stream.match new RegExp "^(#{keywords.join('|')})"
    return 'condition' if stream.match new RegExp "^(#{conditionNames.join('|')})"
    return 'action'    if stream.match new RegExp "^(#{actionNames.join('|')})"

    stream.next()
