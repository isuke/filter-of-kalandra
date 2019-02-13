`import(/* webpackChunkName: "monaco" */ "monaco-editor")`.then (monaco) =>
  monaco.languages.register(id: 'advancedPoeFilter')

  monaco.languages.setMonarchTokensProvider 'advancedPoeFilter',
    keywords: [
      'Show', 'Hide', 'Mixin'
    ]
    conditionKeywords: [
      'Class'
      'BaseType'
      'Prophecy'
      'DropLevel'
      'ItemLevel'
      'GemLevel'
      'StackSize'
      'MapTier'
      'Quality'
      'LinkedSockets'
      'Sockets'
      'SocketGroup'
      'Rarity'
      'ShaperItem'
      'ElderItem'
      'Corrupted'
      'Identified'
      'ShapedMap'
      'Height'
      'Width'
      'HasExplicitMod'
    ]
    actionKeywords: [
      'SetBorderColor'
      'SetTextColor'
      'SetBackgroundColor'
      'SetFontSize'
      'PlayAlertSound'
      'PlayAlertSoundPositional'
      'DisableDropSound'
      'CustomAlertSound'
      'MinimapIcon'
      'PlayEffect'
    ]
    macroNames: ['Prop', 'Var']
    functionNames: [
      'Negate'
      'Grayscale'
      'Saturate'
      'Desaturate'
      'Lighten'
      'Darken'
      'Whiten'
      'Blacken'
      'Hex'
      'Saturation'
      'Lightness'
      'Plus'
      'Minus'
    ]
    values: [
      'Normal', 'Magic', 'Rare', 'Unique',
      'Largest', 'Medium', 'Small',
      'ShAlchemy', 'ShBlessed', 'ShChaos', 'ShDivine', 'ShExalted', 'ShFusing', 'ShGeneral', 'ShMirror', 'ShRegal', 'ShVaal',
      'True', 'False',
      'Red', 'Green', 'Blue', 'Brown', 'White', 'Yellow',
      'Circle', 'Diamond', 'Hexagon', 'Square', 'Star', 'Triangle',
      'Temp',
    ]
    operators: ['=', '>', '<', '<=', '>=']

    tokenizer:
      root: [
        {
          regex: /^ *#:.*$/
          action: 'comment.output'
        },
        {
          regex: /^ *#[^:].*$/
          action: 'comment'
        },
        {
          regex: /[A-Z]\w*/
          action:
            cases:
              'Show': 'keyword.show'
              'Hide': 'keyword.hide'
              'Mixin': 'keyword.mixin'
              '@conditionKeywords': 'keyword.condition'
              '@actionKeywords': 'keyword.action'
              '@values': 'variable.value'
              '@macroNames':
                token: 'macro.name'
                bracket: '@open'
                next: '@macro'
              '@functionNames':
                token: 'function.name'
                bracket: '@open'
                next: '@function'
        },
        {
          regex: /"/
          action:
            token: 'string.quote'
            bracket: '@open'
            next: '@string'
        },
        {
          regex: /\d+/,
          action: 'number',
        },
      ]
      string: [
        {
          regex: /[^"]+/
          action: 'string'
        },
        {
          regex: /"/
          action:
            token: 'string.quote'
            bracket: '@close'
            next: '@pop'
        }
      ]
      macro: [
        {
          regex: /[^()]+/
          action: 'macro.value'
        },
        {
          regex: /\(/
          action: 'macro.quote'
        },
        {
          regex: /\)/
          action:
            token: 'macro.quote'
            bracket: '@close'
            next: '@pop'
        }
      ]
      function: [
        {
          regex: /[^()]+/
          action: 'function.value'
        },
        {
          regex: /\(/
          action: 'function.quote'
        },
        {
          regex: /\)/
          action:
            token: 'function.quote'
            bracket: '@close'
            next: '@pop'
        }
      ]

  monaco.editor.defineTheme 'advancedPoeFilterTheme',
    base: 'vs'
    inherit: true
    rules: [
      { token: 'comment'            , foreground: '073642' }
      { token: 'comment.output'     , foreground: '8282ff' }
      { token: 'keyword'            , foreground: '268bd2' }
      { token: 'keyword.show'       , foreground: '268bd2' }
      { token: 'keyword.hide'       , foreground: '268bd2' }
      { token: 'keyword.mixin'      , foreground: '268bd2' }
      { token: 'keyword.condition'  , foreground: '859900' }
      { token: 'keyword.action'     , foreground: '3A9900' }
      { token: 'number'             , foreground: 'cb4b16' }
      { token: 'variable.value'     , foreground: 'cb4b16' }
      { token: 'macro'              , foreground: '2aa198', fontStyle: 'underline' }
      { token: 'function'           , foreground: 'd33682' }
    ]
