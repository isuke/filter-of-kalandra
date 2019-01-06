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
    variables: {}
    properties: {
      "No Name": {}
    }
  getters:
    #
    # advancedScriptText
    #
    simpleScriptObjects: (state) -> advancedPoeFilter.getObject(state.advancedScriptText, {}, state.properties)
    simpleScriptTexts: (state) -> advancedPoeFilter.compile(state.advancedScriptText, {}, state.properties)
    scriptNames: (state, getters) -> Object.keys(getters.simpleScriptObjects)
    sectionNames: (state, getters) -> getters.simpleScriptObjects[getters.scriptNames[0]].map((o) => o.name)
    blocks: (state, getters) -> (scriptName, sectionName) =>
      getters.simpleScriptObjects[scriptName].find((s) => s.name == sectionName).blocks

    #
    # variables
    #
    variableNaems: (state) -> Object.keys(state.variables)

    #
    # properties
    #
    propNames: (state, getters) -> Object.keys(state.properties[getters.scriptNames[0]])
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
      newProps = {}
      getters.propNames.forEach (propName) =>
        newProps[propName] = 'New Val'
      # TODO: random script name
      Vue.set(state.properties, 'New Script', newProps)
    addPropsToProperties: ({ _commit, state, _getters }) ->
      forIn state.properties, (props, scriptName) =>
        # TODO: random prop name
        Vue.set(state.properties[scriptName], 'New Prop', 'New Val')
