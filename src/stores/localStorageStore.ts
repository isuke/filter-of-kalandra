import localStorage from "store"

import { isEmpty } from "@/utils/objectUtils"

import type { State } from "./index"
import type { Commit } from "vuex"

export default {
  namespaced: true,
  actions: {
    saveAdvancedScriptTextToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_advancedScriptText", rootState.advancedScriptText)
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    saveVariablesToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_variables", JSON.stringify(rootState.variables))
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    saveColorsToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_colors", JSON.stringify(rootState.colors))
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    savePropertiesToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_properties", JSON.stringify(rootState.properties))
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    saveFilterInfoToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_filterInfo", JSON.stringify(rootState.filterInfo))
          localStorage.remove("filter-of-kalandra_filterName")
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    saveOptionsToLocalStorage: ({ rootState }: { rootState: State }) => {
      return new Promise((resolve, reject) => {
        try {
          localStorage.set("filter-of-kalandra_options", JSON.stringify(rootState.options))
          resolve(undefined)
        } catch (error) {
          reject(error)
        }
      })
    },
    loadFromLocalStorage: ({ commit }: { commit: Commit }) => {
      return new Promise((resolve, reject) => {
        try {
          const loaded = []
          const advancedScriptText = localStorage.get("filter-of-kalandra_advancedScriptText")
          const variables = localStorage.get("filter-of-kalandra_variables")
          const colors = localStorage.get("filter-of-kalandra_colors")
          const properties = localStorage.get("filter-of-kalandra_properties")
          const filterInfo = localStorage.get("filter-of-kalandra_filterInfo")
          const options = localStorage.get("filter-of-kalandra_options")
          const filterName = localStorage.get("filter-of-kalandra_filterName")
          if (!isEmpty(advancedScriptText)) {
            commit(
              "setAdvancedScriptText",
              {
                advancedScriptText: advancedScriptText,
              },
              { root: true },
            )
            loaded.push("advancedScriptText")
          }
          if (!isEmpty(variables)) {
            commit(
              "setVariables",
              {
                variables: JSON.parse(variables),
              },
              { root: true },
            )
            loaded.push("variables")
          }
          if (!isEmpty(colors)) {
            commit(
              "setColors",
              {
                colors: JSON.parse(colors),
              },
              { root: true },
            )
            loaded.push("colors")
          }
          if (!isEmpty(properties)) {
            commit(
              "setProperties",
              {
                properties: JSON.parse(properties),
              },
              { root: true },
            )
            loaded.push("properties")
          }
          if (!isEmpty(filterInfo)) {
            commit(
              "setFilterInfo",
              {
                filterInfo: JSON.parse(filterInfo),
              },
              { root: true },
            )
            loaded.push("filterInfo")
          }
          if (!isEmpty(options)) {
            commit(
              "setOptions",
              {
                options: JSON.parse(options),
              },
              { root: true },
            )
            loaded.push("options")
          }
          if (isEmpty(filterInfo) && !isEmpty(filterName)) {
            console.warn("load old version data from local storage.")
            commit(
              "setFilterInfo",
              {
                filterInfo: {
                  name: filterName,
                  version: "0.0.1",
                  appVersion: process.env.VUE_APP_VERSION,
                },
              },
              { root: true },
            )
            loaded.push("filterInfo")
          }
          resolve(loaded)
        } catch (error) {
          reject(error)
        }
      })
    },
    clearFromLocalStorage: () => {
      localStorage.clearAll()
    },
  },
}
