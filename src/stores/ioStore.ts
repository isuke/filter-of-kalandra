import { ColorHex, ColorRGB } from "@/types/color"
import { rgbToHex } from "@/utils/colorUtils"
import { download } from "@/utils/htmlUtils"

import { State } from "./index"

import type { Commit, ActionContext, Dispatch } from "vuex"

type Getters = ActionContext<State, State>["rootGetters"]

export default {
  namespaced: true,
  actions: {
    importAdvancedScriptTextFromTextFile: ({ commit }: { commit: Commit }, payload: { file: File }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)
        return reader.readAsText(payload.file)
      })
        .then((result) => commit("setAdvancedScriptText", { advancedScriptText: result }, { root: true }))
        .catch((error: Error) => console.error(error.message))
    },
    importVariablesFromJsonFile: ({ rootState, dispatch }: { rootState: State; dispatch: Dispatch }, payload: { file: File; canOverwrite: boolean }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)

        reader.readAsText(payload.file)
      })
        .then((result) => {
          JSON.parse(result as string).forEach((importVariable: { name: string; items: string[] }) => {
            const index = rootState.variables.findIndex((v) => v.name === importVariable.name)
            if (index > -1) {
              if (payload.canOverwrite) {
                return (rootState.variables[index].items = importVariable.items)
              } else {
                return console.info(`skip '${importVariable.name}'`)
              }
            } else {
              return rootState.variables.push(importVariable)
            }
          })
        })
        .catch((error: Error) => {
          dispatch("toasterStore/add", { message: error.message, type: "error" })
          console.error(error.message)
        })
    },
    exportVariables: ({ rootState }: { rootState: State }) => {
      download("variables.json", JSON.stringify(rootState.variables), "application/json")
    },
    importColorsFromJsonFile: ({ rootState, dispatch }: { rootState: State; dispatch: Dispatch }, payload: { file: File; canOverwrite: boolean }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)
        reader.readAsText(payload.file)
      })
        .then((result) => {
          JSON.parse(result as string).forEach((importColor: { name: string; rgb?: ColorRGB; hex?: ColorHex }) => {
            const index = rootState.colors.findIndex((c) => c.name === importColor.name)
            if (index > -1) {
              if (payload.canOverwrite) {
                if (importColor.rgb) {
                  rootState.colors[index].hex = rgbToHex(importColor.rgb)
                } else if (importColor.hex) {
                  rootState.colors[index].hex = importColor.hex
                }
              } else {
                console.info(`skip '${importColor.name}'`)
              }
            } else {
              const hex = importColor.rgb ? rgbToHex(importColor.rgb) : importColor.hex
              rootState.colors.push({ name: importColor.name, hex: hex as ColorHex })
            }
          })
        })
        .catch((error: Error) => {
          dispatch("toasterStore/add", { message: error.message, type: "error" })
          console.error(error.message)
        })
    },
    exportColors: ({ rootGetters }: { rootGetters: Getters }) => {
      download("colors.json", JSON.stringify(rootGetters.colorsRGBFormat), "application/json")
    },
    exportProperties: ({ rootState }: { rootState: State }) => {
      download("properties.json", JSON.stringify(rootState.properties), "application/json")
    },
    importPropertiesFromJsonFile: ({ commit, dispatch }: { commit: Commit; dispatch: Dispatch }, payload: { file: File }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)
        reader.readAsText(payload.file)
      })
        .then((result) => {
          commit("setProperties", { properties: JSON.parse(result as string) }, { root: true })
        })
        .catch((error: Error) => {
          dispatch("toasterStore/add", { message: error.message, type: "error" })
          console.error(error.message)
        })
    },
    importFilterInfoFromJsonFile: ({ commit, dispatch }: { commit: Commit; dispatch: Dispatch }, payload: { file: File }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)
        return reader.readAsText(payload.file)
      })
        .then((result) => {
          commit("setFilterInfo", { filterInfo: JSON.parse(result as string) }, { root: true })
        })
        .catch((error: Error) => {
          dispatch("toasterStore/add", { message: error.message, type: "error" })
          console.error(error.message)
        })
    },
    importOptionsFromJsonFile: ({ commit, dispatch }: { commit: Commit; dispatch: Dispatch }, payload: { file: File }) => {
      return new Promise((resolve, _reject) => {
        const reader = new FileReader()
        reader.onload = (event) => resolve(event.target?.result)
        reader.readAsText(payload.file)
      })
        .then((result) => {
          commit("setOptions", { options: JSON.parse(result as string) }, { root: true })
        })
        .catch((error: Error) => {
          dispatch("toasterStore/add", { message: error.message, type: "error" })
          console.error(error.message)
        })
    },
    importAll: ({ commit }: { commit: Commit }, payload: { files: { [filename: string]: string }; callback?: () => void }) => {
      commit("resetAll", {}, { root: true })

      let existFilterInfoFile = false
      const filterName = "New Filter"
      Object.keys(payload.files).forEach((fileName) => {
        const content = payload.files[fileName]
        switch (fileName) {
          case "variables.json": {
            commit("setVariables", { variables: JSON.parse(content) }, { root: true })
            break
          }
          case "colors.json": {
            commit("setColors", { colors: JSON.parse(content) }, { root: true })
            break
          }
          case "properties.json": {
            commit("setProperties", { properties: JSON.parse(content) }, { root: true })
            break
          }
          case "filterInfo.json": {
            commit("setFilterInfo", { filterInfo: JSON.parse(content) }, { root: true })
            existFilterInfoFile = true
            break
          }
          case "options.json": {
            commit("setOptions", { options: JSON.parse(content) }, { root: true })
            break
          }
          default: {
            const match = fileName.match(/^(.*)\.(.*)$/)
            if (match) {
              const _name = match[1]
              const ext = match[2]
              if (ext === "advancedfilter") {
                commit("setAdvancedScriptText", { advancedScriptText: content }, { root: true })
                if (window.editor) window.editor.setValue(content) // MEMO: monaco-editor reload
              }
            }
          }
        }
      })
      if (!existFilterInfoFile) {
        console.warn("import old version data.")
        commit(
          "setFilterInfo",
          {
            filterInfo: {
              name: filterName,
              appVersion: process.env.VUE_APP_VERSION,
            },
          },
          { root: true },
        )
      }
      if (payload.callback) payload.callback()
    },
    importAllFromFileList: ({ dispatch }: { dispatch: Dispatch }, payload: { fileList: FileList; callback: () => void }) => {
      const fileNames: string[] = []
      const files: File[] = []
      Array.from(payload.fileList).forEach((file) => {
        fileNames.push(file.name)
        files.push(file)
      })
      dispatch("importAll", {
        fileNames: fileNames,
        files: files,
        callback: payload.callback,
      })
    },
    importAllFromZip: async ({ dispatch }: { dispatch: Dispatch }, payload: { file: File; callback?: () => void }) => {
      const { unzipSync, strFromU8 } = await import(/* webpackChunkName: "zip" */ "fflate")

      const arrBuffer = await payload.file.arrayBuffer()
      const unzippedFiles = unzipSync(new Uint8Array(arrBuffer))

      const files: { [filename: string]: string } = {}

      Object.keys(unzippedFiles).forEach((key) => {
        if (!/^__MACOSX/.test(key)) {
          files[key.replace(/^.*[\\/]/, "")] = strFromU8(unzippedFiles[key])
        }
      })

      dispatch("importAll", { files: files })
    },
    exportAll: async ({ rootState, dispatch }: { rootState: State; dispatch: Dispatch }) => {
      const { zipSync, strToU8 } = await import(/* webpackChunkName: "zip" */ "fflate")

      await dispatch("createSimpleScriptTexts", {}, { root: true })

      const files: { [name: string]: Uint8Array } = {}
      const texts = rootState.simpleScriptTexts
      Object.keys(texts).forEach((key) => {
        const scriptName = key
        const simpleScriptText = texts[key]
        files[`${rootState.filterInfo.name}_${scriptName}.filter`] = strToU8(simpleScriptText)
      })

      const zipFile = zipSync(files)

      download(`${rootState.filterInfo.name}.zip`, zipFile, "application/zip")
    },
  },
}
