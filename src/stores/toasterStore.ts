import type { Dispatch } from "vuex"

type StateItem = {
  id?: number
  type?: "normal" | "error"
  message?: string
}

type State = {
  _currentID: number
  items: Required<StateItem>[]
  timeout: number
  defaultItemValues: {
    type: "normal" | "error"
    message: string
  }
}

export default {
  namespaced: true,
  state: (): State => {
    return {
      _currentID: 0,
      items: [],
      timeout: 8000,
      defaultItemValues: {
        message: "",
        type: "normal",
      },
    }
  },
  actions: {
    add: ({ state, dispatch }: { state: State; dispatch: Dispatch }, payload: StateItem = {}): number => {
      const id = state._currentID++

      state.items.push(Object.assign({}, state.defaultItemValues, { id: id }, payload))

      setTimeout(() => {
        dispatch("remove", { id })
      }, state.timeout)

      return id
    },
    remove: ({ state }: { state: State }, payload: { id: number }): number | undefined => {
      const index = state.items.findIndex((item) => item.id === payload.id)

      if (index < 0) return undefined

      state.items.splice(index, 1)

      return payload.id
    },
  },
}
