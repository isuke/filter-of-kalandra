import debounce from "lodash.debounce"
import { watch } from "vue"

import sample from "@/sample"

import type { State } from "@/stores/index"
import type { Store } from "vuex"

/**
 * Make to auto save all data to LocalStorage.
 * @param store
 */
const useLocalStorageAutoSave = (store: Store<State>): void => {
  watch(
    () => store.state.advancedScriptText,
    debounce(() => {
      store
        .dispatch("localStorageStore/saveAdvancedScriptTextToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1000),
  )
  watch(
    () => store.state.variables,
    debounce(() => {
      store
        .dispatch("localStorageStore/saveVariablesToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1500),
    { deep: true },
  )
  watch(
    () => store.state.colors,
    debounce(() => {
      store
        .dispatch("localStorageStore/saveColorsToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1500),
    { deep: true },
  )
  watch(
    () => store.state.properties,
    debounce(() => {
      store
        .dispatch("localStorageStore/savePropertiesToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1500),
    { deep: true },
  )
  watch(
    () => store.state.filterInfo,
    debounce(() => {
      store
        .dispatch("localStorageStore/saveFilterInfoToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1500),
    { deep: true },
  )
  watch(
    () => store.state.options,
    debounce(() => {
      store
        .dispatch("localStorageStore/saveOptionsToLocalStorage")
        .then()
        .catch((error: Error) => console.error(error.message))
    }, 1500),
    { deep: true },
  )
}

const setDefaultValues = (store: Store<State>, loaded: string[]): void => {
  if (!loaded.includes("advancedScriptText")) store.commit("setAdvancedScriptText", { advancedScriptText: sample.advancedScriptText })
  if (!loaded.includes("variables")) store.dispatch("importDefaultVariables", { canOverwrite: false })
  if (!loaded.includes("colors")) store.dispatch("importDefaultColors", { canOverwrite: false })
  if (!loaded.includes("properties")) store.commit("setProperties", { properties: sample.properties })
}

/**
 * Load all data from LocalStorage and set default value if cannot load data.
 * @param store
 */
const loadFromLocalStorage = (store: Store<State>): void => {
  store
    .dispatch("localStorageStore/loadFromLocalStorage")
    .then((loaded) => {
      setDefaultValues(store, loaded)
    })
    .catch((error: Error) => console.error(error.message))
}

export { useLocalStorageAutoSave, loadFromLocalStorage }
