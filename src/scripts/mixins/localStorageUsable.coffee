import debounce from "lodash.debounce"

import sample from "@/sample.coffee"

export default
  watch:
    advancedScriptText: debounce ->
      @$store.dispatch("saveAdvancedScriptTextToLocalStorage")
        .then()
        .catch((e) => console.error e.message)
    , 1000
    variables:
      handler: debounce ->
        @$store.dispatch("saveVariablesToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    colors:
      handler: debounce ->
        @$store.dispatch("saveColorsToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    properties:
      handler: debounce ->
        @$store.dispatch("savePropertiesToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    filterInfo:
      handler: debounce ->
        @$store.dispatch("saveFilterInfoToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    options:
      handler: debounce ->
        @$store.dispatch("saveOptionsToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
  methods:
    loadFromLocalStorage: ->
      @$store.dispatch("loadFromLocalStorage")
        .then((loaded) =>
          @sedDefaultValues loaded
        ).catch((e) =>
          console.error e.message
        )
    sedDefaultValues: (loaded) ->
      @$store.commit "setAdvancedScriptText", advancedScriptText: sample.advancedScriptText unless loaded.includes "advancedScriptText"
      @$store.dispatch "importDefaultVariables", canOverwrite: false                        unless loaded.includes "variables"
      @$store.dispatch "importDefaultColors", canOverwrite: false                           unless loaded.includes "colors"
      @$store.commit "setProperties", properties: sample.properties                         unless loaded.includes "properties"
