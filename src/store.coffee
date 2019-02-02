import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import localStorage from "store"
import Color from "color"
import * as advancedPoeFilter from "advanced-poe-filter"

import defaultData from "./defaultData.coffee"

# TODO: move to utils
forIn = (object, callback) =>
  Object.keys(object).forEach (key) => callback(object[key], key)

export default new Vuex.Store
  state:
    filterName: "New Filter"
    advancedScriptText: ""
    oldSimpleScriptObject: {}
    oldSimpleScriptTexts: {}
    syntaxError: undefined
    variables: []
    colors: []
    properties: {
      scriptNames: ["No Name"]
      propNames: []
      values: []
    }
  getters:
    #
    # advancedScriptText
    #
    simpleScriptObjects: (state, getters) ->
      try
        result = advancedPoeFilter.getObject(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler)
        state.oldSimpleScriptObject = result
        state.syntaxError = undefined
        result
      catch e
        state.syntaxError = e
        state.oldSimpleScriptObject
    simpleScriptTexts: (state, getters) ->
      try
        result = advancedPoeFilter.compile(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler, state.filterName)
        state.oldSimpleScriptTexts = result
        result
      catch _e
        state.oldSimpleScriptTexts
    scriptNames: (state, _getters) -> state.properties.scriptNames
    sectionNames: (state, getters) ->
      firstObject = getters.simpleScriptObjects[getters.scriptNames[0]]
      if firstObject then firstObject.map((o) => o.name) else []
    blocks: (state, getters) -> (scriptName, sectionName) =>
      getters.simpleScriptObjects[scriptName].find((s) => s.name == sectionName).blocks

    #
    # variables
    #
    variableNaems: (state) -> state.variables.map (v) => v.name
    variablesForCompiler: (state, getters) ->
      result = {}

      state.variables.forEach (variable) =>
        # TODO: expand '#'
        result[variable.name] = if variable.items.length <= 1 then variable.items[0] else variable.items

      state.colors.forEach (color, index) =>
        rgb = getters.colorObject(index).rgb().color
        result[color.name] = "#{rgb[0]} #{rgb[1]} #{rgb[2]}"

      result

    #
    # colors
    #
    colorObject: (state) -> (index) => new Color(state.colors[index].hex)

    #
    # properties
    #
    propNames: (state, getters) -> state.properties.propNames
    propValue: (state, getters) -> (scriptName, propName) =>
      i = state.properties.scriptNames.findIndex (name) => name == scriptName
      j = state.properties.propNames.findIndex (name) => name == propName
      state.properties.values[i][j]
    propertiesForCompiler: (state) ->
      result = {}
      state.properties.scriptNames.forEach (scriptName, i) =>
        state.properties.propNames.forEach (propName, j) =>
          result[scriptName] = {} if result[scriptName] == undefined
          result[scriptName][propName] = state.properties.values[i][j]
      result
  mutations:
    #
    # filterName
    #
    setFilterName: (state, payload = {}) -> state.filterName = payload.filterName

    #
    # advancedScriptText
    #
    setAdvancedScriptText: (state, payload = {}) -> state.advancedScriptText = payload.advancedScriptText

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
    setProperties: (state, payload = {}) -> state.properties = payload.properties
    addScriptToProperties: (state, payload = {}) ->
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
  actions:
    #
    # variables
    #
    importDefaultVariables: ({ _commit, state }, payload = {}) ->
      defaultData.variables.forEach (defaultVariable) =>
        index = state.variables.findIndex (v) => v.name == defaultVariable.name
        if index > -1
          if payload.canOverwrite
            state.variables[index].items = defaultVariable.items
          else
            console.log "skip '#{defaultVariable.name}'"
        else
          state.variables.push defaultVariable
    importVariablesFromJSONFile: ({ _commit, state }, payload = {}) ->
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
    exportVariables: ({ _commit, state }) ->
      content = JSON.stringify(state.variables)
      fileName = "variables.json"

      # TODO: move to utils
      downLoadLink = document.createElement("a")
      downLoadLink.download = fileName
      downLoadLink.href = URL.createObjectURL new Blob([content], type: "application/json")
      downLoadLink.dataset.downloadurl = ["application/json", downLoadLink.download, downLoadLink.href].join(":")
      downLoadLink.click()

    #
    # colors
    #
    importDefaultColors: ({ _commit, state }, payload = {}) ->
      defaultData.colors.forEach (defaultColor) =>
        index = state.colors.findIndex (c) => c.name == defaultColor.name
        if index > -1 && payload.canOverwrite
          if payload.canOverwrite
            state.colors[index].hex = defaultColor.hex
          else
            console.log "skip '#{defaultColor.name}'"
        else
          state.colors.push defaultColor
    importColorsFromJSONFile: ({ _commit, state }, payload = {}) ->
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
    exportColors: ({ _commit, state }) ->
      content = JSON.stringify(state.colors)
      fileName = "colors.json"

      # TODO: move to utils
      downLoadLink = document.createElement("a")
      downLoadLink.download = fileName
      downLoadLink.href = URL.createObjectURL new Blob([content], type: "application/json")
      downLoadLink.dataset.downloadurl = ["application/json", downLoadLink.download, downLoadLink.href].join(":")
      downLoadLink.click()

    #
    # properties
    #
    exportProperties: ({ _commit, state }) ->
      content = JSON.stringify(state.properties)
      fileName = "properties.json"

      # TODO: move to utils
      downLoadLink = document.createElement("a")
      downLoadLink.download = fileName
      downLoadLink.href = URL.createObjectURL new Blob([content], type: "application/json")
      downLoadLink.dataset.downloadurl = ["application/json", downLoadLink.download, downLoadLink.href].join(":")
      downLoadLink.click()
    importPropertiesFromJSONFile: ({ _commit, state }, payload = {}) ->
      new Promise((resolve, reject) =>
        reader = new FileReader()
        reader.onload = (event) => resolve(event.target.result)
        reader.readAsText payload.file
      ).then((result) =>
        state.properties = JSON.parse(result)
      ).catch((error) =>
        console.error error.message
      )

    #
    # local strorage
    #
    saveFilterNameToLocalStorage: ({ _commit, state }) ->
      try
        localStorage.set "filter-of-kalandra_filter-name", state.filterName
        console.log "Save filterName to LocalStorage."
      catch e
        console.error e.message
    saveAdvancedScriptTextToLocalStorage: ({ _commit, state }) ->
      try
        localStorage.set "filter-of-kalandra_advancedScriptText", state.advancedScriptText
        console.log "Save dvancedScriptText to LocalStorage."
      catch e
        console.error e.message
    saveVariablesToLocalStorage: ({ _commit, state }) ->
      try
        localStorage.set "filter-of-kalandra_variables", JSON.stringify(state.variables)
        console.log "Save variables to LocalStorage."
      catch e
        console.error e.message
    saveColorsToLocalStorage: ({ _commit, state }) ->
      try
        localStorage.set "filter-of-kalandra_colors", JSON.stringify(state.colors)
        console.log "Save colors to LocalStorage."
      catch e
        console.error e.message
    savePropertiesToLocalStorage: ({ _commit, state }) ->
      try
        localStorage.set "filter-of-kalandra_properties", JSON.stringify(state.properties)
        console.log "Save properties to LocalStorage."
      catch e
        console.error e.message
    loadFromLocalStorage: ({ commit, _state }) ->
      try
        filterName         = localStorage.get "filter-of-kalandra_filter-name"
        advancedScriptText = localStorage.get "filter-of-kalandra_advancedScriptText"
        variables          = localStorage.get "filter-of-kalandra_variables"
        colors             = localStorage.get "filter-of-kalandra_colors"
        properties         = localStorage.get "filter-of-kalandra_properties"
        commit "setFilterName", filterName: filterName                         if filterName
        commit "setAdvancedScriptText", advancedScriptText: advancedScriptText if advancedScriptText
        commit "setVariables" ,  variables: JSON.parse variables               if variables
        commit "setColors"    ,     colors: JSON.parse colors                  if colors
        commit "setProperties", properties: JSON.parse properties              if properties
        console.log "Loaded from the LocalStorage."
      catch e
        console.error e.message
