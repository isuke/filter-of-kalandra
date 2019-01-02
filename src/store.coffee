import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import * as advancedPoeFilter from "advanced-poe-filter"

export default new Vuex.Store
  state:
    advancedScriptText: ""
  mutations:
    setAdvancedScriptText: (state, payload = {}) -> state.advancedScriptText = payload.advancedScriptText
  getters:
    simpleScriptObjects: (state) -> advancedPoeFilter.getObject(state.advancedScriptText)
    simpleScriptTexts: (state) -> advancedPoeFilter.compile(state.advancedScriptText)
    scriptNames: (state, getters) -> Object.keys(getters.simpleScriptObjects)
    sectionNames: (state, getters) -> getters.simpleScriptObjects[getters.scriptNames[0]].map((o) => o.name)
    blocks: (state, getters) -> (scriptName, sectionName) =>
      getters.simpleScriptObjects[scriptName].find((s) => s.name == sectionName).blocks
  actions: {}
