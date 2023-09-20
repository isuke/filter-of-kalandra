import { Commit, ActionContext } from "vuex"

import { State } from "./index"

export type CompileWorkerMessageSuccess = {
  status: "success"
  type: "Object" | "Text"
  result: string | object
}
export type CompileWorkerMessageUnknownError = {
  status: "fail"
  result: {
    name: "UnknownError"
    message: string
  }
}
export type CompileWorkerMessageSyntaxError = {
  status: "fail"
  result: {
    name: "SyntaxError"
    type: "Object" | "Text"
    message: string
    location: {
      start: {
        line: number
        column: number
        offset: number
      }
      end: {
        line: number
        column: number
        offset: number
      }
    }
  }
}
type CompileWorkerMessage = {
  data: CompileWorkerMessageSuccess | CompileWorkerMessageUnknownError | CompileWorkerMessageSyntaxError
}

type Getters = ActionContext<State, State>["rootGetters"]

let compileWorker: Worker

export default {
  namespaced: true,
  actions: {
    createCompileWorker: ({ commit }: { commit: Commit }, payload: { successCallback?: () => void; failCallback?: () => void }) => {
      compileWorker = new Worker(new URL("../compile.worker.js", import.meta.url))
      compileWorker.addEventListener("message", (message: CompileWorkerMessage) => {
        if (message.data.status === "success") {
          commit(
            "setSyntaxError",
            {
              syntaxError: undefined,
            },
            { root: true },
          )

          if (message.data.type === "Object") {
            commit(
              "setSimpleScriptObject",
              {
                simpleScriptObject: message.data.result,
              },
              { root: true },
            )
          } else if (message.data.type === "Text") {
            commit(
              "setSimpleScriptTexts",
              {
                simpleScriptTexts: message.data.result,
              },
              { root: true },
            )
          } else {
            console.error(`Unknown type: ${message.data.type}`)
          }
          if (payload.successCallback) {
            payload.successCallback()
          }
        } else {
          commit(
            "setSyntaxError",
            {
              syntaxError: message.data.result,
            },
            { root: true },
          )
          if (payload.failCallback) {
            payload.failCallback()
          }
        }
      })
      compileWorker.addEventListener("error", (error) => {
        commit(
          "setSyntaxError",
          {
            syntaxError: {
              message: error.message,
            },
          },
          { root: true },
        )
      })
    },
    requestSimpleScriptObjectToWorker: ({ rootState, rootGetters }: { rootState: State; rootGetters: Getters }) => {
      if (compileWorker) {
        compileWorker.postMessage(
          JSON.parse(
            JSON.stringify({
              type: "Object",
              advancedScriptText: rootState.advancedScriptText,
              variables: rootGetters.variablesForCompiler,
              properties: rootGetters.propertiesForCompiler,
              filterInfo: rootState.filterInfo,
              options: rootState.options,
            }),
          ),
        )
      } else {
        console.error("Compile Worker not exist.")
      }
    },
    requestSimpleScriptTextsToWorker: ({ rootState, rootGetters }: { rootState: State; rootGetters: Getters }) => {
      if (compileWorker) {
        compileWorker.postMessage(
          JSON.parse(
            JSON.stringify({
              type: "Text",
              advancedScriptText: rootState.advancedScriptText,
              variables: rootGetters.variablesForCompiler,
              properties: rootGetters.propertiesForCompiler,
              filterInfo: rootState.filterInfo,
              options: rootState.options,
            }),
          ),
        )
      }
    },
    terminateCompileWorker: () => {
      if (compileWorker) compileWorker.terminate()
    },
  },
}
