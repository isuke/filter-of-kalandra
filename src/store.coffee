import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import Color from "color"
import localStorage from "store"
import * as zip from "jsziptools/zip"
import * as advancedPoeFilter from "advanced-poe-filter"

import { forIn, download } from "@/scripts/utils.coffee"

import defaultData from "./defaultData.coffee"

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
    setAdvancedScriptText: (state, payload = {}) ->
      state.advancedScriptText = payload.advancedScriptText
      window._cm.setValue payload.advancedScriptText if window._cm # HACK

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
    importPropertiesFromJSONFile: ({ state }, payload = {}) ->
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
    saveFilterNameToLocalStorage: ({ state }) ->
      try
        localStorage.set "filter-of-kalandra_filter-name", state.filterName
        console.log "Save filterName to LocalStorage."         if process.env.NODE_ENV == "development"
      catch e
        console.error e.message
    saveAdvancedScriptTextToLocalStorage: ({ state }) ->
      try
        localStorage.set "filter-of-kalandra_advancedScriptText", state.advancedScriptText
        console.log "Save advancedScriptText to LocalStorage." if process.env.NODE_ENV == "development"
      catch e
        console.error e.message
    saveVariablesToLocalStorage: ({ state }) ->
      try
        localStorage.set "filter-of-kalandra_variables", JSON.stringify(state.variables)
        console.log "Save variables to LocalStorage."          if process.env.NODE_ENV == "development"
      catch e
        console.error e.message
    saveColorsToLocalStorage: ({ state }) ->
      try
        localStorage.set "filter-of-kalandra_colors", JSON.stringify(state.colors)
        console.log "Save colors to LocalStorage."             if process.env.NODE_ENV == "development"
      catch e
        console.error e.message
    savePropertiesToLocalStorage: ({ state }) ->
      try
        localStorage.set "filter-of-kalandra_properties", JSON.stringify(state.properties)
        console.log "Save properties to LocalStorage."         if process.env.NODE_ENV == "development"
      catch e
        console.error e.message
    loadFromLocalStorage: ({ commit }) ->
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

    #
    # zip import/export
    #
    importAllFromFileList: ({ state, commit, dispatch }, payload = {}) ->
      Array.prototype.forEach.call payload.fileList, (file) =>
        switch file.name
          when "variables.json"
            dispatch("importVariablesFromJSONFile", file: file, canOverwrite: true)
          when "colors.json"
            dispatch("importColorsFromJSONFile", file: file, canOverwrite: true)
          when "properties.json"
            dispatch("importPropertiesFromJSONFile", file: file)
          else
            match = file.name.match /^(.*)\.(.*)$/
            name = match[1]
            ext  = match[2]
            if ext == 'advancedfilter'
              commit("setFilterName", filterName: name)
              dispatch("importAdvancedScriptTextFromTextFile", file: file)
    importAllFromZip: ({ state, commit, dispatch }, payload = {}) ->
      zip
        .unpack
          buffer: payload.file
        .then (reader) =>
          reader.getFileNames().forEach (filePath) =>
            reader.readFileAsBlob(filePath).then (file) =>
              fileName = filePath.match(/([^\/]+?)?$/)[1]
              switch fileName
                when "variables.json"
                  dispatch("importVariablesFromJSONFile", file: file, canOverwrite: true)
                when "colors.json"
                  dispatch("importColorsFromJSONFile", file: file, canOverwrite: true)
                when "properties.json"
                  dispatch("importPropertiesFromJSONFile", file: file)
                else
                  match = fileName.match /^(.*)\.(.*)$/
                  name = match[1]
                  ext  = match[2]
                  if ext == 'advancedfilter'
                    commit("setFilterName", filterName: name)
                    dispatch("importAdvancedScriptTextFromTextFile", file: file)
    exportAll: ({ state, getters }) ->
      filters = []
      forIn getters.simpleScriptTexts, (simpleScriptText, scriptName) =>
        filters.push { name: "#{state.filterName}_#{scriptName}.filter", buffer: simpleScriptText }

      files = [
        name: state.filterName
        dir: filters.concat [
          { name: "#{state.filterName}.advancedfilter", buffer: state.advancedScriptText }
          { name: "variables.json" , buffer: JSON.stringify(state.variables) }
          { name: "colors.json"    , buffer: JSON.stringify(state.colors) }
          { name: "properties.json", buffer: JSON.stringify(state.properties) }
        ]
      ]

      zip
        .pack
          files: files
        .then (buffer) =>
          download "#{state.filterName}.zip", buffer, "application/zip"
