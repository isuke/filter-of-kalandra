import type * as advancedPoeFilterParser from "advanced-poe-filter-parser"

import(/* webpackChunkName: "monaco" */ "monaco-editor").then((monaco) => {
  const languageID: string = "advancedPoeFilter"

  const activityKeywords: advancedPoeFilterParser.Activity[] = ["Show", "Hide", "Unset", "Ignore"]
  const branchKeywords: advancedPoeFilterParser.BranchType[] = ["Fork", "Mixin"]
  const conditionKeywords: advancedPoeFilterParser.Condition[] = [
    "Class",
    "BaseType",
    "DropLevel",
    "ItemLevel",
    "AreaLevel",
    "GemLevel",
    "GemQualityType",
    "StackSize",
    "MapTier",
    "Quality",
    "LinkedSockets",
    "Sockets",
    "SocketGroup",
    "Rarity",
    "BaseDefencePercentile",
    "BaseArmour",
    "BaseEnergyShield",
    "BaseEvasion",
    "BaseWard",
    "FracturedItem",
    "SynthesisedItem",
    "Corrupted",
    "Mirrored",
    "Identified",
    "Scourged",
    "ShapedMap",
    "ElderMap",
    "BlightedMap",
    "UberBlightedMap",
    "Height",
    "Width",
    "CorruptedMods",
    "EnchantmentPassiveNum",
    "HasExplicitMod",
    "HasImplicitMod",
    "HasEaterOfWorldsImplicit",
    "HasSearingExarchImplicit",
    "AnyEnchantment",
    "HasEnchantment",
    "HasInfluence",
    "EnchantmentPassiveNode",
    "AlternateQuality",
    "Replica",
    "ArchnemesisMod",
    "HasCruciblePassiveTree",
  ]
  const actionTextKeywords: advancedPoeFilterParser.Action[] = ["SetBorderColor", "SetTextColor", "SetBackgroundColor", "SetFontSize"]
  const actionEffectKeywords: advancedPoeFilterParser.Action[] = [
    "PlayAlertSound",
    "PlayAlertSoundPositional",
    "DisableDropSound",
    "EnableDropSound",
    "CustomAlertSound",
    "MinimapIcon",
    "PlayEffect",
  ]
  const macroNames: string[] = ["Prop", "Var"]
  const functionNames: string[] = [
    "Negate",
    "Grayscale",
    "Saturate",
    "Desaturate",
    "Lighten",
    "Darken",
    "Whiten",
    "Blacken",
    "Hex",
    "Saturation",
    "Lightness",
    "Plus",
    "Minus",
  ]
  const values: string[] = [
    "Normal",
    "Magic",
    "Rare",
    "Unique",
    "Largest",
    "Medium",
    "Small",
    "ShAlchemy",
    "ShBlessed",
    "ShChaos",
    "ShDivine",
    "ShExalted",
    "ShFusing",
    "ShGeneral",
    "ShMirror",
    "ShRegal",
    "ShVaal",
    "True",
    "False",
    "Red",
    "Green",
    "Blue",
    "Brown",
    "White",
    "Yellow",
    "Cyan",
    "Grey",
    "Orange",
    "Pink",
    "Purple",
    "Circle",
    "Diamond",
    "Hexagon",
    "Square",
    "Star",
    "Triangle",
    "Cross",
    "Moon",
    "Raindrop",
    "Kite",
    "Pentagon",
    "UpsideDownHouse",
    "Temp",
    "None",
  ]

  monaco.languages.register({ id: languageID })

  monaco.languages.setLanguageConfiguration(languageID, { comments: { lineComment: "#" } })

  monaco.languages.setMonarchTokensProvider(languageID, {
    tokenizer: {
      root: [
        {
          regex: /^ *#:.*$/,
          action: "comment.output",
        },
        {
          regex: /^ *#[^:]?.*$/,
          action: "comment",
        },
        {
          regex: "Show",
          action: "keyword.show",
        },
        {
          regex: "Hide",
          action: "keyword.hide",
        },
        {
          regex: "Unset",
          action: "keyword.unset",
        },
        {
          regex: "Fork",
          action: "keyword.fork",
        },
        {
          regex: "Mixin",
          action: "keyword.mixin",
        },
        {
          regex: new RegExp(conditionKeywords.join("|")),
          action: "keyword.condition",
        },
        {
          regex: new RegExp(actionTextKeywords.join("|")),
          action: "keyword.action.text",
        },
        {
          regex: new RegExp(actionEffectKeywords.join("|")),
          action: "keyword.action.effect",
        },
        {
          regex: new RegExp(values.join("|")),
          action: "keyword.value",
        },
        {
          regex: new RegExp(macroNames.join("|")),
          action: {
            token: "macro.name",
            bracket: "@open",
            next: "@macro",
          },
        },
        {
          regex: new RegExp(functionNames.join("|")),
          action: {
            token: "function.name",
            bracket: "@open",
            next: "@function",
          },
        },
        {
          regex: /"/,
          action: {
            token: "string.quote",
            bracket: "@open",
            next: "@string",
          },
        },
        {
          regex: /\d+/,
          action: "number",
        },
      ],
      string: [
        {
          regex: /[^"]+/,
          action: "string",
        },
        {
          regex: /"/,
          action: {
            token: "string.quote",
            bracket: "@close",
            next: "@pop",
          },
        },
      ],
      macro: [
        {
          regex: /[^()]+/,
          action: "macro.value",
        },
        {
          regex: /\(/,
          action: "macro.quote",
        },
        {
          regex: /\)/,
          action: {
            token: "macro.quote",
            bracket: "@close",
            next: "@pop",
          },
        },
      ],
      function: [
        {
          regex: /[^()]+/,
          action: "function.value",
        },
        {
          regex: /\(/,
          action: "function.quote",
        },
        {
          regex: /\)/,
          action: {
            token: "function.quote",
            bracket: "@close",
            next: "@pop",
          },
        },
      ],
    },
  })

  monaco.editor.defineTheme("advancedPoeFilterDayTheme", {
    base: "vs",
    inherit: true,
    colors: {
      "editor.background": "#f0f0f0",
      "editor.foreground": "#04041b",
    },
    rules: [
      { token: "comment", foreground: "#073642" },
      { token: "comment.output", foreground: "#8282ff" },
      { token: "keyword", foreground: "#268bd2" },
      { token: "keyword.show", foreground: "#268bd2" },
      { token: "keyword.hide", foreground: "#4984ab" },
      { token: "keyword.unset", foreground: "#3d86b7" },
      { token: "keyword.fork", foreground: "#2542ce" },
      { token: "keyword.mixin", foreground: "#2542ce" },
      { token: "keyword.condition", foreground: "#7c8f00" },
      { token: "keyword.action.text", foreground: "#3a9900" },
      { token: "keyword.action.effect", foreground: "#cc0086" },
      { token: "number", foreground: "#cb4b16" },
      { token: "variable.value", foreground: "#cb4b16" },
      { token: "macro", foreground: "#2aa198", fontStyle: "underline" },
      { token: "function", foreground: "#d33682" },
      // { background: "#f0f0f0" },
      // { foreground: "#04041b" },
    ],
  })
  monaco.editor.defineTheme("advancedPoeFilterNightTheme", {
    base: "vs-dark",
    inherit: true,
    colors: {
      "editor.background": "#252525",
      "editor.foreground": "#fafafd",
    },
    rules: [
      { token: "comment", foreground: "#737268" },
      { token: "comment.output", foreground: "#71a1d0" },
      { token: "keyword", foreground: "#f2787a" },
      { token: "keyword.show", foreground: "#f2787a" },
      { token: "keyword.hide", foreground: "#f4878a" },
      { token: "keyword.unset", foreground: "#f99058" },
      { token: "keyword.fork", foreground: "#fdb35d" },
      { token: "keyword.mixin", foreground: "#fdb35d" },
      { token: "keyword.condition", foreground: "#ffcc66" },
      { token: "keyword.action.text", foreground: "#6699cc" },
      { token: "keyword.action.effect", foreground: "#99cc99" },
      { token: "number", foreground: "#ffd278" },
      { token: "variable.value", foreground: "#ffd278" },
      { token: "macro", foreground: "#d4d1c9", fontStyle: "underline" },
      { token: "function", foreground: "#cc99cc" },
      // { background: '#252525' }
      // { foreground: '#fafafd' }
    ],
  })

  monaco.languages.registerCompletionItemProvider(languageID, {
    provideCompletionItems: (_model, position, _context, _token) => {
      const range = {
        startLineNumber: position.lineNumber,
        startColumn: 0,
        endLineNumber: position.lineNumber,
        endColumn: 0,
      }

      const keywordSuggestions = [...activityKeywords, ...branchKeywords, ...conditionKeywords, ...actionTextKeywords, ...actionEffectKeywords].map(
        (keyword) => {
          return {
            label: keyword,
            kind: monaco.languages.CompletionItemKind.Keyword,
            insertText: `${keyword} `,
            range,
          }
        },
      )
      const macroAndFunctionSuggestions = [...macroNames, ...functionNames].map((macroName) => {
        return {
          label: macroName,
          kind: monaco.languages.CompletionItemKind.Function,
          insertText: macroName,
          range,
        }
      })
      const valueSuggestions = values.map((value) => {
        return {
          label: value,
          kind: monaco.languages.CompletionItemKind.Value,
          insertText: value,
          range,
        }
      })
      const activitySuggestions = activityKeywords.map((activityKeyword) => {
        return {
          label: `${activityKeyword} Block`,
          kind: monaco.languages.CompletionItemKind.Snippet,
          insertText: `
              ${activityKeyword} "\${1:Block Name}"
              \t$0
            `,
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet,
          documentation: `${activityKeyword} Block`,
          range,
        }
      })
      const branchSuggestions = branchKeywords.map((branchKeyword) => {
        return {
          label: `${branchKeyword} Branch`,
          kind: monaco.languages.CompletionItemKind.Snippet,
          insertText: `
              ${branchKeyword} "\${1:#{branchKeyword} Name}"
              \tShow "\${2:Block Name}"
              \t\t$0
            `,
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet,
          documentation: `${branchKeyword} Branch`,
          range,
        }
      })
      const macroSuggestions = macroNames.map((macroName) => {
        return {
          label: macroName,
          kind: monaco.languages.CompletionItemKind.Snippet,
          insertText: `
              ${macroName}("\${1:#{macroName} Name}")
            `,
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet,
          documentation: macroName,
          range,
        }
      })
      const functionSuggestions = functionNames.map((functionName) => {
        return {
          label: functionName,
          kind: monaco.languages.CompletionItemKind.Snippet,
          insertText: `
              ${functionName}($1)
            `,
          insertTextRules: monaco.languages.CompletionItemInsertTextRule.InsertAsSnippet,
          documentation: functionName,
          range,
        }
      })

      return {
        suggestions: [
          ...keywordSuggestions,
          ...macroAndFunctionSuggestions,
          ...valueSuggestions,
          ...activitySuggestions,
          ...branchSuggestions,
          ...macroSuggestions,
          ...functionSuggestions,
        ],
      }
    },
  })
})
