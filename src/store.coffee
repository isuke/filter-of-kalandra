import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import * as advancedPoeFilter from "advanced-poe-filter"

# TODO: move to utils
forIn = (object, callback) =>
  Object.keys(object).forEach (key) => callback(object[key], key)

export default new Vuex.Store
  state:
    advancedScriptText: ""
    variables: []
    properties: {
      scriptNames: ["No Name"]
      propNames: []
      values: []
    }
  getters:
    #
    # advancedScriptText
    #
    simpleScriptObjects: (state, getters) -> advancedPoeFilter.getObject(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler)
    simpleScriptTexts: (state, getters) -> advancedPoeFilter.compile(state.advancedScriptText, getters.variablesForCompiler, getters.propertiesForCompiler)
    scriptNames: (state, getters) -> Object.keys(getters.simpleScriptObjects)
    sectionNames: (state, getters) -> getters.simpleScriptObjects[getters.scriptNames[0]].map((o) => o.name)
    blocks: (state, getters) -> (scriptName, sectionName) =>
      getters.simpleScriptObjects[scriptName].find((s) => s.name == sectionName).blocks

    #
    # variables
    #
    variableNaems: (state) -> state.variables.map (v) => v.name
    variablesForCompiler: (state) ->
      result = {}
      state.variables.forEach (variable) =>
        # TODO: expand '#'
        result[variable.name] = if variable.items.length <= 1 then variable.items[0] else variable.items
      result

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
    # advancedScriptText
    #
    setAdvancedScriptText: (state, payload = {}) -> state.advancedScriptText = payload.advancedScriptText

    #
    # variables
    #
    setVariables: (state, payload = {}) -> state.variables = payload.variables

    #
    # properties
    #
    setProperties: (state, payload = {}) -> state.properties = payload.properties
  actions:
    #
    # properties
    #
    addScriptToProperties: ({ _commit, state, getters }) ->
      state.properties.values.push new Array(state.properties.propNames.length)
      state.properties.scriptNames.push "New Script #{state.properties.scriptNames.length + 1}"
    addPropsToProperties: ({ _commit, state, _getters }) ->
      state.properties.values.forEach (props) => props.push ''
      state.properties.propNames.push "New Prop #{state.properties.propNames.length + 1}"
