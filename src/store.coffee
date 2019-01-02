import Vue  from "vue"
import Vuex from "vuex"

Vue.use(Vuex)

import * as advancedPoeFilter from "advanced-poe-filter"

export default new Vuex.Store
  state:
    scriptText: ""
  mutations:
    setScriptText: (state, payload = {}) -> state.scriptText = payload.scriptText
  getters:
    outputObject: (state) -> advancedPoeFilter.getObject(state.scriptText)
    outputText: (state) -> advancedPoeFilter.compile(state.scriptText)
  actions: {}
