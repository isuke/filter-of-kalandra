import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import Color from "color"
import localStorage from "store/dist/store.modern.min.js"
import * as advancedPoeFilter from "advanced-poe-filter"

import { forIn, isEmpty, download } from "@/scripts/utils.coffee"

import CompileWorker from './compile.worker.js'

import defaultData from "./defaultData.coffee"

export default new Vuex.Store
  strict: false
  state:
    advancedScriptText: ""
    simpleScriptObject: {}
    simpleScriptTexts: {}
    syntaxError: undefined
    variables: []
    colors: []
    properties:
      scriptNames: ["No Name"]
      propNames: []
      values: []
    filterInfo:
      name: "New Filter"
      appVersion: process.env.VUE_APP_VERSION
    options:
      addDisableDropSoundToHideBlock: true
      convertPlayAlertSoundPositionalToPlayAlertSound: false
      removeCustomAlertSound: false
      initialFontSize: 32
    scriptNumLimit: if process.env.NODE_ENV == "development" then 10 else 2
    _compileWorker: undefined
  getters:
    #
    # advancedScriptText
    #
    scriptNames: (state, _getters) -> state.properties.scriptNames
    sectionNames: (state, getters) ->
      result = []
      regexp = /^(Show|Hide|Unset|Var|Prop)[^\n]+"([^\n]+)"$/gm
      while match = regexp.exec(state.advancedScriptText)
        result.push match[2]
      result
    blocks: (state, getters) -> (scriptName, sectionName) =>
      state.simpleScriptObject[scriptName].find((s) => s.name == sectionName).blocks

    #
    # variables
    #
    variableNaems: (state) -> state.variables.map (v) => v.name
    variablesForCompiler: (state, getters) ->
      result = {}

      state.variables.forEach (variable) =>
        result[variable.name] = if variable.items.length <= 1 then variable.items[0] else variable.items

      state.colors.forEach (color, index) =>
        rgb = getters.colorObject(index).rgb().color
        result[color.name] = "#{rgb[0]} #{rgb[1]} #{rgb[2]}"

      result

    #
    # colors
    #
    # TODO: remove
    colorObject: (state) -> (index) => new Color(state.colors[index].hex)

    #
    # properties
    #
    propNames: (state, getters) -> state.properties.propNames
    propValue: (state, getters) -> (scriptName, propName) =>
      i = state.properties.scriptNames.findIndex (name) => name == scriptName
      j = state.properties.propNames.findIndex (name) => name == propName
      state.properties.values[i][j]
    canAddScript: (state, getters) -> getters.scriptNames.length < state.scriptNumLimit
    propertiesForCompiler: (state) ->
      result = {}
      state.properties.scriptNames.forEach (scriptName, i) =>
        state.properties.propNames.forEach (propName, j) =>
          result[scriptName] = {} if result[scriptName] == undefined
          result[scriptName][propName] = state.properties.values[i][j]
      result
  mutations:
    #
    # advancedScriptText
    #
    setAdvancedScriptText: (state, payload = {}) ->
      state.advancedScriptText = payload.advancedScriptText
      window.editor.setValue payload.advancedScriptText if window.editor # HACK
    setSyntaxError: (state, payload = {}) -> state.syntaxError = payload.syntaxError
    setSimpleScriptObject: (state, payload = {}) -> state.simpleScriptObject = Object.freeze(payload.simpleScriptObject)
    setSimpleScriptTexts: (state, payload = {}) -> state.simpleScriptTexts = Object.freeze(payload.simpleScriptTexts)

    #
    # variables
    #
    setVariables: (state, payload = {}) -> state.variables = payload.variables
    addVariable: (state, payload = {}) -> state.variables.push { name: "New Variable #{state.variables.length + 1}", items: [] }
    removeVariable: (state, payload = {}) -> state.variables.splice(payload.index, 1)
    addItemToVariable: (state, payload = {}) ->
      items = state.variables[payload.index].items
      items.push "New Item #{items.length + 1}"
    removeItemFromVariable: (state, payload = {}) ->
      items = state.variables[payload.index].items
      items.splice(payload.itemIndex, 1)

    #
    # colors
    #
    setColors: (state, payload = {}) -> state.colors = payload.colors
    addColor: (state, payload = {}) -> state.colors.push { name: "New Color #{state.colors.length + 1}", hex: "#000000" }
    removeColor: (state, payload = {}) -> state.colors.splice(payload.index, 1)

    #
    # properties
    #
    setProperties: (state, payload = {}) ->
      state.properties =
        scriptNames: payload.properties.scriptNames.slice(0, state.scriptNumLimit)
        propNames:   payload.properties.propNames
        values:      payload.properties.values.slice(0, state.scriptNumLimit)
    addScriptToProperties: (state, payload = {}) ->
      if state.properties.scriptNames.length < state.scriptNumLimit
        state.properties.values.push new Array(state.properties.propNames.length).fill("")
        state.properties.scriptNames.push "New Script #{state.properties.scriptNames.length + 1}"
    removeScriptFromProperties: (state, payload = {}) ->
      state.properties.scriptNames.splice(payload.index, 1)
      state.properties.values.splice(payload.index, 1)
    addPropsToProperties: (state, payload = {}) ->
      state.properties.values.forEach (props) => props.push ''
      state.properties.propNames.push "New Prop #{state.properties.propNames.length + 1}"
    removePropsFromProperties: (state, payload = {}) ->
      state.properties.propNames.splice(payload.index, 1)
      state.properties.values.forEach (value) => value.splice(payload.index, 1)

    #
    # filterInfo
    #
    setFilterInfo: (state, payload = {}) -> state.filterInfo = payload.filterInfo

    #
    # options
    #
    setOptions: (state, payload = {}) -> state.options = payload.options

    #
    # all
    #
    resetAll: (state) ->
      state.advancedScriptText = ""
      state.simpleScriptObject = {}
      state.syntaxError = undefined
      state.variables = []
      state.colors = []
      state.properties = {
        scriptNames: ["No Name"]
        propNames: []
        values: []
      }
      state.filterInfo = {
        name: "New Filter"
        appVersion: process.env.VUE_APP_VERSION
      }
      state.options = {
        addDisableDropSoundToHideBlock: true
        convertPlayAlertSoundPositionalToPlayAlertSound: false
        removeCustomAlertSound: false
        initialFontSize: 32
      }
  actions:
    #
    # advancedScriptText
    #
    importAdvancedScriptTextFromTextFile: ({ commit }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        commit("setAdvancedScriptText", advancedScriptText: result)
      ).catch((error) =>
        console.error error.message
      )

    #
    # variables
    #
    importDefaultVariables: ({ state }, payload = {}) ->
      defaultData.variables.forEach (defaultVariable) =>
        index = state.variables.findIndex (v) => v.name == defaultVariable.name
        if index > -1
          if payload.canOverwrite
            state.variables[index].items = defaultVariable.items
          else
            console.log "skip '#{defaultVariable.name}'"
        else
          state.variables.push defaultVariable
    importVariablesFromJSONFile: ({ state }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        JSON.parse(result).forEach (importVariable) =>
          index = state.variables.findIndex (v) => v.name == importVariable.name
          if index > -1
            if payload.canOverwrite
              state.variables[index].items = importVariable.items
            else
              console.log "skip '#{importVariable.name}'"
          else
            state.variables.push importVariable
      ).catch((error) =>
        console.error error.message
      )
    exportVariables: ({ state }) ->
      download "variables.json", JSON.stringify(state.variables), "application/json"

    #
    # colors
    #
    importDefaultColors: ({ state }, payload = {}) ->
      defaultData.colors.forEach (defaultColor) =>
        index = state.colors.findIndex (c) => c.name == defaultColor.name
        if index > -1 && payload.canOverwrite
          if payload.canOverwrite
            state.colors[index].hex = defaultColor.hex
          else
            console.log "skip '#{defaultColor.name}'"
        else
          state.colors.push defaultColor
    importColorsFromJSONFile: ({ state }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        JSON.parse(result).forEach (importColor) =>
          index = state.colors.findIndex (c) => c.name == importColor.name
          if index > -1 && payload.canOverwrite
            if payload.canOverwrite
              state.colors[index].hex = importColor.hex
            else
              console.log "skip '#{importColor.name}'"
          else
            state.colors.push importColor
      ).catch((error) =>
        console.error error.message
      )
    exportColors: ({ state }) ->
      download "colors.json", JSON.stringify(state.colors), "application/json"

    #
    # properties
    #
    exportProperties: ({ state }) ->
      download "properties.json", JSON.stringify(state.properties), "application/json"
    importPropertiesFromJSONFile: ({ state, commit }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        commit "setProperties", properties: JSON.parse(result)
      ).catch((error) =>
        console.error error.message
      )

    #
    # filterInfo
    #
    importFilterInfoFromJSONFile: ({ state, commit }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        commit "setFilterInfo", options: JSON.parse(result)
      ).catch((error) =>
        console.error error.message
      )

    #
    # options
    #
    importOptionsFromJSONFile: ({ state, commit }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        commit "setOptions", options: JSON.parse(result)
      ).catch((error) =>
        console.error error.message
      )

    #
    # compile
    #
    createSimpleScriptObject: ({ state, commit, getters }) ->
      object = advancedPoeFilter.getObject(
        state.advancedScriptText,
        getters.variablesForCompiler,
        getters.propertiesForCompiler,
        state.filterInfo,
        state.options
      )
      commit "setSimpleScriptObject", simpleScriptObject: object
      object
    createSimpleScriptTexts: ({ state, commit, getters }) ->
      texts = advancedPoeFilter.compile(
        state.advancedScriptText,
        getters.variablesForCompiler,
        getters.propertiesForCompiler,
        state.filterInfo,
        state.options
      )
      commit "setSimpleScriptTexts", simpleScriptTexts: texts
      texts

    #
    # web-worker
    #
    createCompileWorker: ({ state, getters, commit }, payload) ->
      worker = new CompileWorker()
      worker.addEventListener "message", (message) =>
        if message.data.status == "success"
          if message.data.type == "Object"
            commit "setSimpleScriptObject", simpleScriptObject: message.data.result
          else if message.data.type == "Text"
            commit "setSimpleScriptTexts", simpleScriptTexts: message.data.result
          else
            console.error "Unkown type: `#{message.data.type}`"
          commit "setSyntaxError", syntaxError: undefined
          payload.successCallback() if payload.successCallback
        else
          commit "setSyntaxError", syntaxError: message.data.result
          payload.failCallback() if payload.failCallback
      worker.addEventListener "error", (error) =>
        commit "setSyntaxError", syntaxError: { message: error.message }
      state._compileWorker = worker
    requestSimpleScriptObjectToWorker: ({ state, getters }) ->
      if state._compileWorker
        state._compileWorker.postMessage
          type: "Object"
          advancedScriptText: state.advancedScriptText
          variables:  getters.variablesForCompiler
          properties: getters.propertiesForCompiler
          filterInfo: state.filterInfo
          options:    state.options
    requestSimpleScriptTextsToWorker: ({ state, getters }) ->
      if state._compileWorker
        state._compileWorker.postMessage
          type: "Text"
          advancedScriptText: state.advancedScriptText
          variables:  getters.variablesForCompiler
          properties: getters.propertiesForCompiler
          filterInfo: state.filterInfo
          options:    state.options

    #
    # local strorage
    #
    saveAdvancedScriptTextToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_advancedScriptText", state.advancedScriptText
          resolve()
        catch e
          reject(e)
    saveVariablesToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_variables", JSON.stringify(state.variables)
          resolve()
        catch e
          reject(e)
    saveColorsToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_colors", JSON.stringify(state.colors)
          resolve()
        catch e
          reject(e)
    savePropertiesToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_properties", JSON.stringify(state.properties)
          resolve()
        catch e
          reject(e)
    saveFilterInfoToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_filterInfo", JSON.stringify(state.filterInfo)
          localStorage.remove "filter-of-kalandra_filterName" # remove old version garbage
          resolve()
        catch e
          reject(e)
    saveOptionsToLocalStorage: ({ state }) ->
      new Promise (resolve, reject) =>
        try
          localStorage.set "filter-of-kalandra_options", JSON.stringify(state.options)
          resolve()
        catch e
          reject(e)
    loadFromLocalStorage: ({ commit }) ->
      new Promise (resolve, reject) =>
        try
          loaded = []
          advancedScriptText = localStorage.get "filter-of-kalandra_advancedScriptText"
          variables          = localStorage.get "filter-of-kalandra_variables"
          colors             = localStorage.get "filter-of-kalandra_colors"
          properties         = localStorage.get "filter-of-kalandra_properties"
          filterInfo         = localStorage.get "filter-of-kalandra_filterInfo"
          options            = localStorage.get "filter-of-kalandra_options"

          filterName = localStorage.get "filter-of-kalandra_filterName" # old version

          unless isEmpty advancedScriptText
            commit "setAdvancedScriptText", advancedScriptText: advancedScriptText
            loaded.push 'advancedScriptText'
          unless isEmpty variables
            commit "setVariables", variables: JSON.parse variables
            loaded.push 'variables'
          unless isEmpty colors
            commit "setColors", colors: JSON.parse colors
            loaded.push 'colors'
          unless isEmpty properties
            commit "setProperties", properties: JSON.parse properties
            loaded.push 'properties'
          unless isEmpty filterInfo
            commit "setFilterInfo", filterInfo: JSON.parse filterInfo
            loaded.push 'filterInfo'
          unless isEmpty options
            commit "setOptions", options: JSON.parse options
            loaded.push 'options'
          if isEmpty(filterInfo) && ! isEmpty(filterName)
            console.warn "load old version data from local storage."
            commit "setFilterInfo",
              filterInfo:
                name: filterName
                appVersion: process.env.VUE_APP_VERSION
            loaded.push 'filterInfo'
          resolve loaded
        catch e
          reject e

    #
    # zip import/export
    #
    importAll: ({ state, commit, dispatch }, payload = {}) ->
      commit "resetAll"

      existFilterInfoFile = false
      filterName = "New Filter"

      payload.fileNames.forEach (fileName, index) =>
        file = payload.files[index]

        switch fileName
          when "variables.json"
            dispatch("importVariablesFromJSONFile", file: file, canOverwrite: true)
          when "colors.json"
            dispatch("importColorsFromJSONFile", file: file, canOverwrite: true)
          when "properties.json"
            dispatch("importPropertiesFromJSONFile", file: file)
          when "filterInfo.json"
            dispatch("importFilterInfoFromJSONFile", file: file)
            existFilterInfoFile = true
          when "options.json"
            dispatch("importOptionsFromJSONFile", file: file)
          else
            match = fileName.match /^(.*)\.(.*)$/
            if match
              name = match[1]
              ext  = match[2]
              if ext == 'advancedfilter'
                filterName = name
                dispatch("importAdvancedScriptTextFromTextFile", file: file)

      # for old data
      unless existFilterInfoFile
        console.warn "import old version data."
        commit "setFilterInfo",
          filterInfo:
            name: filterName
            appVersion: process.env.VUE_APP_VERSION

      payload.callback() if payload.callback
    importAllFromFileList: ({ state, commit, dispatch }, payload = {}) ->
      fileNames = []
      files = []

      Array.prototype.forEach.call payload.fileList, (file) =>
        fileNames.push file.name
        files.push file

      dispatch "importAll", { fileNames: fileNames, files: files, callback: payload.callback }
    importAllFromZip: ({ state, commit, dispatch }, payload = {}) ->
      zip = await `import(/* webpackChunkName: "zip" */ "jsziptools/zip")`

      zip
        .unpack
          buffer: payload.file
        .then (reader) =>
          filePathes = reader.getFileNames()
          fileNames = filePathes.map (filePath) => filePath.match(/([^\/]+?)?$/)[1]
          files = await Promise.all filePathes.map (filePath) => reader.readFileAsBlob(filePath)

          dispatch "importAll", { fileNames: fileNames, files: files, callback: payload.callback }
    exportAll: ({ state, getters, dispatch }) ->
      zip = await `import(/* webpackChunkName: "zip" */ "jsziptools/zip")`

      filters = []

      texts = await dispatch("createSimpleScriptTexts")
      forIn texts, (simpleScriptText, scriptName) =>
        filters.push { name: "#{state.filterInfo.name}_#{scriptName}.filter", buffer: simpleScriptText }

      files = [
        name: state.filterInfo.name
        dir: filters.concat [
          { name: "#{state.filterInfo.name}.advancedfilter", buffer: state.advancedScriptText }
          { name: "variables.json" , buffer: JSON.stringify(state.variables) }
          { name: "colors.json"    , buffer: JSON.stringify(state.colors) }
          { name: "properties.json", buffer: JSON.stringify(state.properties) }
          { name: "filterInfo.json", buffer: JSON.stringify(state.filterInfo) }
          { name: "options.json"   , buffer: JSON.stringify(state.options) }
        ]
      ]

      zip
        .pack
          files: files
        .then (buffer) =>
          download "#{state.filterInfo.name}.zip", buffer, "application/zip"
