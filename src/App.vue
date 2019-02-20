<template lang="pug">
#app
  the-global-header.header

  keep-alive
    router-view.main

  the-global-footer.footer
</template>

<script lang="coffee">
import debounce from "lodash.debounce"
import * as advancedPoeFilter from "advanced-poe-filter"

import TheGlobalHeader from "@/components/TheGlobalHeader"
import TheGlobalFooter from "@/components/TheGlobalFooter"

import sample from "@/sample.coffee"

export default
  components:
    "the-global-header": TheGlobalHeader
    "the-global-footer": TheGlobalFooter
  computed:
    filterName:         -> @$store.state.filterName
    advancedScriptText: -> @$store.state.advancedScriptText
    variables:          -> @$store.state.variables
    colors:             -> @$store.state.colors
    properties:         -> @$store.state.properties
    variablesForCompiler: ->
      result = {}

      @variables.forEach (variable) =>
        result[variable.name] = if variable.items.length <= 1 then variable.items[0] else variable.items

      @colors.forEach (color, index) =>
        rgb = @$store.getters.colorObject(index).rgb().color
        result[color.name] = "#{rgb[0]} #{rgb[1]} #{rgb[2]}"

      result
    propertiesForCompiler: ->
      result = {}
      @properties.scriptNames.forEach (scriptName, i) =>
        @properties.propNames.forEach (propName, j) =>
          result[scriptName] = {} if result[scriptName] == undefined
          result[scriptName][propName] = @properties.values[i][j]
      result
  watch:
    filterName: debounce ->
      @setSimpleScriptObjectAndTexts()
      @$store.dispatch("saveFilterNameToLocalStorage")
        .then()
        .catch((e) => console.error e.message)
    , 1500
    advancedScriptText: debounce ->
      @setSimpleScriptObjectAndTexts()
      @$store.dispatch("saveAdvancedScriptTextToLocalStorage")
        .then()
        .catch((e) => console.error e.message)
    , 1000
    variables:
      handler: debounce ->
        @setSimpleScriptObjectAndTexts()
        @$store.dispatch("saveVariablesToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    colors:
      handler: debounce ->
        @setSimpleScriptObjectAndTexts()
        @$store.dispatch("saveColorsToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
    properties:
      handler: debounce ->
        @setSimpleScriptObjectAndTexts()
        @$store.dispatch("savePropertiesToLocalStorage")
          .then()
          .catch((e) => console.error e.message)
      , 1500
      deep: true
  methods:
    setSimpleScriptObjectAndTexts: ->
      try
        object = advancedPoeFilter.getObject(@advancedScriptText, @variablesForCompiler, @propertiesForCompiler)
        texts = advancedPoeFilter.compile(@advancedScriptText, @variablesForCompiler, @propertiesForCompiler, @filterName)
        @$store.commit 'setSimpleScriptObject', simpleScriptObject: object
        @$store.commit 'setSimpleScriptTexts', simpleScriptTexts: texts
        @$store.commit 'setSyntaxError', syntaxError: undefined
      catch e
        @$store.commit 'setSyntaxError', syntaxError: e
  created: ->
    @$store.dispatch("loadFromLocalStorage")
      .then((loaded) =>
        @$store.commit "setAdvancedScriptText", advancedScriptText: sample.advancedScriptText unless loaded.includes "advancedScriptText"
        @$store.dispatch 'importDefaultVariables', canOverwrite: false                        unless loaded.includes "variables"
        @$store.dispatch 'importDefaultColors', canOverwrite: false                           unless loaded.includes "colors"
        @$store.commit "setProperties", properties: sample.properties                         unless loaded.includes "properties"
      ).catch((e) =>
        console.error e.message
      )
</script>

<style lang="scss" scoped>
#app {
  width: 100%;
  min-height: 100vh;
  display: grid;
  grid-template-rows: $global-header-height 1fr auto;
  grid-template-columns: 1fr;

  > .header {
    grid-row: 1;
    grid-column: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: $global-header-height;
    z-index: $editor-z-index + 10;
  }

  > .main {
    grid-row: 2;
    grid-column: 1;
  }

  > .footer {
    grid-row: 3;
    grid-column: 1;
  }
}
</style>
