export default
  namespaced: true
  state:
    _currentID: 0
    items: []
    timeout: 8000
    defaultItemVals:
      message: ""
      type: "normal"
  getters: {}
  mutations: {}
  actions:
    add: ({ state, dispatch }, payload = {}) ->
      id = state._currentID++

      state.items.push Object.assign {}, state.defaultItemVals, { id: id }, payload

      setTimeout =>
        dispatch 'remove', id: id
      , state.timeout
      id
    remove: ({ state }, payload = {}) ->
      index = state.items.findIndex (item) => item.id == payload.id
      return if index < 0
      state.items.splice(index, 1)
      payload.id
