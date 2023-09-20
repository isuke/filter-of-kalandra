import { getObject, compile } from "advanced-poe-filter"
import { createStore } from "vuex"

import defaultData from "@/defaultData"
import ioStore from "@/stores/ioStore"
import localStorageStore from "@/stores/localStorageStore"
import toasterStore from "@/stores/toasterStore"
import workerStore, { CompileWorkerMessageUnknownError, CompileWorkerMessageSyntaxError } from "@/stores/workerStore"
import { hexToRGB } from "@/utils/colorUtils"

import type { ColorHex } from "@/types/color"
import type { PoeFilterObject, Block as PoeBlock } from "advanced-poe-filter"

type AdvancedScriptTextState = {
  advancedScriptText: string
  simpleScriptObject: PoeFilterObject
  simpleScriptTexts: {
    [propertyName: string]: string
  }
  syntaxError: CompileWorkerMessageUnknownError["result"] | CompileWorkerMessageSyntaxError["result"] | undefined
}
type VariablesState = {
  variables: {
    name: string
    items: string[]
  }[]
}
type ColorsState = {
  colors: {
    name: string
    hex: ColorHex
  }[]
}
type PropertiesState = {
  properties: {
    scriptNames: string[]
    propNames: string[]
    values: string[][]
  }
}
type FilterInfoState = {
  filterInfo: {
    name: string
    version: string
    appVersion: `${number}.${number}.${number}`
  }
}
type OptionsState = {
  options: {
    addDisableDropSoundToHideBlock: boolean
    convertPlayAlertSoundPositionalToPlayAlertSound: boolean
    removeCustomAlertSound: boolean
    defaultAlertSoundVolume: number
    defaultAlertSoundPositionalVolume: number
    initialFontSize: number
  }
}
export type State = AdvancedScriptTextState & VariablesState & ColorsState & PropertiesState & FilterInfoState & OptionsState

const scriptNumLimit = 10

export default createStore({
  strict: false,
  modules: {
    ioStore,
    localStorageStore,
    workerStore,
    toasterStore,
  },
  state: {
    advancedScriptText: "",
    simpleScriptObject: {},
    simpleScriptTexts: {},
    syntaxError: undefined,
    variables: [],
    colors: [],
    properties: {
      scriptNames: ["No Name"],
      propNames: [],
      values: [],
    },
    filterInfo: {
      name: "New Filter",
      version: "0.0.1",
      appVersion: process.env.VUE_APP_VERSION,
    },
    options: {
      addDisableDropSoundToHideBlock: true,
      convertPlayAlertSoundPositionalToPlayAlertSound: false,
      removeCustomAlertSound: false,
      defaultAlertSoundVolume: 150,
      defaultAlertSoundPositionalVolume: 150,
      initialFontSize: 32,
    },
  } as State,
  getters: {
    //
    // advancedScriptText
    //
    scriptNames: (state) => {
      return state.properties.scriptNames
    },
    sectionNames: (state) => {
      const regexp = /^(Show|Hide|Unset|Var|Prop)[^\n]+"([^\n]+)"$/gm
      const result = []
      let match
      while ((match = regexp.exec(state.advancedScriptText))) {
        result.push(match[2])
      }
      return result
    },
    blocks: (state) => {
      return (scriptName: string, sectionName: string): PoeBlock[] | undefined => {
        if (!state.simpleScriptObject[scriptName]) return undefined

        return state.simpleScriptObject[scriptName].find((s) => s.name === sectionName)?.blocks
      }
    },

    //
    // variables
    //
    variableNames: (state) => {
      return state.variables.map((v) => v.name)
    },
    variablesForCompiler: (state) => {
      const result: { [name: string]: string | string[] } = {}
      state.variables.forEach((variable) => {
        result[variable.name] = variable.items.length <= 1 ? variable.items[0] : variable.items
      })
      state.colors.forEach((color) => {
        const rgb = hexToRGB(color.hex)
        result[color.name] = rgb[0] + " " + rgb[1] + " " + rgb[2]
      })
      return result
    },

    //
    // colors
    //
    colorsRGBFormat: (state) => {
      return state.colors.map((color) => {
        return { name: color.name, rgb: hexToRGB(color.hex) }
      })
    },

    //
    // properties
    //
    propNames: (state) => {
      return state.properties.propNames
    },
    propValue: (state) => {
      return (scriptName: string, propName: string) => {
        const i = state.properties.scriptNames.findIndex((name) => name === scriptName)
        const j = state.properties.propNames.findIndex((name) => name === propName)
        return state.properties.values[i][j]
      }
    },
    canAddScript: (_state, getters) => {
      return getters.scriptNames.length < scriptNumLimit
    },
    propertiesForCompiler: (state) => {
      const result: { [name: string]: { [name: string]: string } } = {}
      state.properties.scriptNames.forEach((scriptName, i) => {
        state.properties.propNames.forEach((propName, j) => {
          if (!result[scriptName]) result[scriptName] = {}
          result[scriptName][propName] = state.properties.values[i][j]
        })
      })
      return result
    },
  },
  mutations: {
    setAdvancedScriptText: (state, payload: { advancedScriptText: State["advancedScriptText"] }) => {
      state.advancedScriptText = payload.advancedScriptText
      // if (window.editor) window.editor.setValue(payload.advancedScriptText)
    },
    setSyntaxError: (state, payload: { syntaxError: State["syntaxError"] }) => {
      return (state.syntaxError = payload.syntaxError)
    },
    setSimpleScriptObject: (state, payload: { simpleScriptObject: State["simpleScriptObject"] }) => {
      state.simpleScriptObject = Object.freeze(payload.simpleScriptObject)
    },
    setSimpleScriptTexts: (state, payload: { simpleScriptTexts: State["simpleScriptTexts"] }) => {
      state.simpleScriptTexts = Object.freeze(payload.simpleScriptTexts)
    },
    setVariables: (state, payload: { variables: State["variables"] }) => {
      state.variables = payload.variables
    },
    addVariable: (state) => {
      state.variables.push({
        name: `New Variable ${state.variables.length + 1}`,
        items: [],
      })
    },
    removeVariable: (state, payload: { index: number }) => {
      state.variables.splice(payload.index, 1)
    },
    addItemToVariable: (state, payload: { index: number }) => {
      const items = state.variables[payload.index].items
      items.push(`New Item ${items.length + 1}`)
    },
    removeItemFromVariable: (state, payload: { index: number; itemIndex: number }) => {
      const items = state.variables[payload.index].items
      items.splice(payload.itemIndex, 1)
    },
    setColors: (state, payload: { colors: State["colors"] }) => {
      state.colors = payload.colors
    },
    addColor: (state) => {
      state.colors.push({
        name: `New Color ${state.colors.length + 1}`,
        hex: "#000000",
      })
    },
    removeColor: (state, payload: { index: number }) => {
      state.colors.splice(payload.index, 1)
    },
    setProperties: (state, payload: { properties: State["properties"] }) => {
      state.properties = {
        scriptNames: payload.properties.scriptNames.slice(0, scriptNumLimit),
        propNames: payload.properties.propNames,
        values: payload.properties.values.slice(0, scriptNumLimit),
      }
    },
    addScriptToProperties: (state) => {
      if (state.properties.scriptNames.length < scriptNumLimit) {
        state.properties.values.push(new Array(state.properties.propNames.length).fill(""))
        state.properties.scriptNames.push(`New Script ${state.properties.scriptNames.length + 1}`)
      }
    },
    removeScriptFromProperties: (state, payload: { index: number }) => {
      state.properties.scriptNames.splice(payload.index, 1)
      state.properties.values.splice(payload.index, 1)
    },
    addPropsToProperties: (state) => {
      state.properties.values.forEach((props) => props.push(""))
      state.properties.propNames.push("New Prop " + (state.properties.propNames.length + 1))
    },
    removePropsFromProperties: (state, payload: { index: number }) => {
      state.properties.propNames.splice(payload.index, 1)
      state.properties.values.forEach((value) => value.splice(payload.index, 1))
    },

    //
    // filterInfo
    //
    setFilterInfo: (state, payload: { filterInfo: State["filterInfo"] }) => {
      state.filterInfo = payload.filterInfo
    },

    //
    // options
    //
    setOptions: (state, payload: { options: State["options"] }) => {
      state.options = payload.options
    },
    resetAll: (state) => {
      state.advancedScriptText = ""
      state.simpleScriptObject = {}
      state.syntaxError = undefined
      state.variables = []
      state.colors = []
      state.properties = {
        scriptNames: ["No Name"],
        propNames: [],
        values: [],
      }
      state.filterInfo = {
        name: "New Filter",
        version: "0.0.1",
        appVersion: process.env.VUE_APP_VERSION,
      }
      state.options = {
        addDisableDropSoundToHideBlock: true,
        convertPlayAlertSoundPositionalToPlayAlertSound: false,
        removeCustomAlertSound: false,
        defaultAlertSoundVolume: 150,
        defaultAlertSoundPositionalVolume: 150,
        initialFontSize: 32,
      }
    },
  },
  actions: {
    importDefaultVariables: ({ state }: { state: State }, payload: { canOverwrite: boolean }) => {
      defaultData.variables.forEach((defaultVariable) => {
        const index = state.variables.findIndex((v) => v.name === defaultVariable.name)
        if (index > -1) {
          if (payload.canOverwrite) {
            state.variables[index].items = defaultVariable.items
          } else {
            console.info(`skip '${defaultVariable.name}'`)
          }
        } else {
          state.variables.push(defaultVariable)
        }
      })
    },
    importDefaultColors: ({ state }: { state: State }, payload: { canOverwrite: boolean }) => {
      defaultData.colors.forEach((defaultColor) => {
        const index = state.colors.findIndex((c) => c.name === defaultColor.name)
        if (index > -1) {
          if (payload.canOverwrite) {
            return (state.colors[index].hex = defaultColor.hex as ColorHex)
          } else {
            return console.info(`skip '${defaultColor.name}'`)
          }
        } else {
          return state.colors.push(defaultColor as { name: string; hex: ColorHex })
        }
      })
    },

    createSimpleScriptObject: ({ state, commit, getters }) => {
      const object = getObject(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler, state.filterInfo, state.options)
      commit("setSimpleScriptObject", {
        simpleScriptObject: object,
      })
    },
    createSimpleScriptTexts: ({ state, commit, getters }) => {
      const texts = compile(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler, state.filterInfo, state.options)
      commit("setSimpleScriptTexts", { simpleScriptTexts: texts })
    },
  },
})
