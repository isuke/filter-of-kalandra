`import(/* webpackChunkName: "monaco" */ "monaco-editor")`.then (monaco) =>
  languageID = 'advancedPoeFilter'

  activityKeywords = [
    'Show', 'Hide', 'Unset'
  ]
  branchKeywords = [
    'Fork', 'Mixin'
  ]
  conditionKeywords = [
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
    'FracturedItem'
    'SynthesisedItem'
    'Corrupted'
    'Identified'
    'ShapedMap'
    'Height'
    'Width'
    'HasExplicitMod'
    'AnyEnchantment'
    'HasEnchantment'
  ]
  actionTextKeywords = [
    'SetBorderColor'
    'SetTextColor'
    'SetBackgroundColor'
    'SetFontSize'
  ]
  actionEffectKeywords = [
    'PlayAlertSound'
    'PlayAlertSoundPositional'
    'DisableDropSound'
    'CustomAlertSound'
    'MinimapIcon'
    'PlayEffect'
  ]
  macroNames = ['Prop', 'Var']
  functionNames = [
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
  values = [
    'Normal', 'Magic', 'Rare', 'Unique',
    'Largest', 'Medium', 'Small',
    'ShAlchemy', 'ShBlessed', 'ShChaos', 'ShDivine', 'ShExalted', 'ShFusing', 'ShGeneral', 'ShMirror', 'ShRegal', 'ShVaal',
    'True', 'False',
    'Red', 'Green', 'Blue', 'Brown', 'White', 'Yellow',
    'Circle', 'Diamond', 'Hexagon', 'Square', 'Star', 'Triangle',
    'Temp',
  ]

  monaco.languages.register(id: languageID)

  monaco.languages.setLanguageConfiguration languageID,
    comments:
      lineComment: '#'

  monaco.languages.setMonarchTokensProvider languageID,
    activityKeywords: activityKeywords
    branchKeywords: branchKeywords
    conditionKeywords: conditionKeywords
    actionTextKeywords: actionTextKeywords
    actionEffectKeywords: actionEffectKeywords
    macroNames: macroNames
    functionNames: functionNames
    values: values
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
              'Unset': 'keyword.unset'
              'Fork': 'keyword.fork'
              'Mixin': 'keyword.mixin'
              '@conditionKeywords': 'keyword.condition'
              '@actionTextKeywords': 'keyword.action.text'
              '@actionEffectKeywords': 'keyword.action.effect'
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
      { token: 'keyword.hide'       , foreground: '4984ab' }
      { token: 'keyword.unset'      , foreground: '3d86b7' }
      { token: 'keyword.fork'       , foreground: '2542ce' }
      { token: 'keyword.mixin'      , foreground: '2542ce' }
      { token: 'keyword.condition'  , foreground: '7c8f00' }
      { token: 'keyword.action.text', foreground: '3a9900' }
      { token: 'keyword.action.effect', foreground: 'cc0086' }
      { token: 'number'             , foreground: 'cb4b16' }
      { token: 'variable.value'     , foreground: 'cb4b16' }
      { token: 'macro'              , foreground: '2aa198', fontStyle: 'underline' }
      { token: 'function'           , foreground: 'd33682' }
    ]

  monaco.languages.registerCompletionItemProvider languageID,
    provideCompletionItems: ->
      suggestions = ([]).concat(
        activityKeywords,
        branchKeywords,
        conditionKeywords,
        actionTextKeywords,
        actionEffectKeywords,
      ).map (keyword) =>
        {
          label: keyword
          kind: monaco.languages.CompletionItemKind.Keyword
          insertText: "#{keyword} "
        }
      suggestions = suggestions.concat macroNames.concat(functionNames).map (functionName) =>
        {
          label: functionName
          kind: monaco.languages.CompletionItemKind.function
          insertText: functionName
        }
      suggestions = suggestions.concat values.map (value) =>
        {
          label: value
          kind: monaco.languages.CompletionItemKind.value
          insertText: value
        }
      suggestions = suggestions.concat activityKeywords.map (activityKeyword) =>
        {
          label: "#{activityKeyword} Block"
          kind: monaco.languages.CompletionItemKind.Snippet
          insertText: """
            #{activityKeyword} "${1:Block Name}"
            \t$0
          """
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet
          documentation: "#{activityKeyword} Block"
        }
      suggestions = suggestions.concat branchKeywords.map (branchKeyword) =>
        {
          label: "#{branchKeyword} Branch"
          kind: monaco.languages.CompletionItemKind.Snippet
          insertText: """
            #{branchKeyword} "${1:#{branchKeyword} Name}"
            \tShow "${2:Block Name}"
            \t\t$0
          """
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet
          documentation: "#{branchKeyword} Branch"
        }
      suggestions = suggestions.concat macroNames.map (macroName) =>
        {
          label: macroName
          kind: monaco.languages.CompletionItemKind.Snippet
          insertText: """
            #{macroName}("${1:#{macroName} Name}")
          """
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet
          documentation: macroName
        }
      suggestions = suggestions.concat functionNames.map (functionName) =>
        {
          label: functionName
          kind: monaco.languages.CompletionItemKind.Snippet
          insertText: """
            #{functionName}($1)
          """
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet
          documentation: functionName
        }

      { suggestions: suggestions }
