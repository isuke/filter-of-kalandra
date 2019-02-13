<template lang="pug">
#app
  the-global-header.header

  keep-alive
    router-view.main

  the-global-footer.footer
</template>

<script lang="coffee">
import debounce from "lodash.debounce"

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
  watch:
    filterName: debounce ->
      @$store.dispatch("saveFilterNameToLocalStorage")
        .then(=> console.log "Save FilterName to LocalStorage." if process.env.NODE_ENV == "development")
        .catch((e) => console.error e.message)
    , 1000
    advancedScriptText: debounce ->
      @$store.dispatch("saveAdvancedScriptTextToLocalStorage")
        .then(=> console.log "Save AdvancedScriptText to LocalStorage." if process.env.NODE_ENV == "development")
        .catch((e) => console.error e.message)
    , 1000
    variables:
      handler: debounce ->
        @$store.dispatch("saveVariablesToLocalStorage")
          .then(=> console.log "Save Variables to LocalStorage." if process.env.NODE_ENV == "development")
          .catch((e) => console.error e.message)
      , 1000
      deep: true
    colors:
      handler: debounce ->
        @$store.dispatch("saveColorsToLocalStorage")
          .then(=> console.log "Save Colors to LocalStorage." if process.env.NODE_ENV == "development")
          .catch((e) => console.error e.message)
      , 1000
      deep: true
    properties:
      handler: debounce ->
        @$store.dispatch("savePropertiesToLocalStorage")
          .then(=> console.log "Save Properties to LocalStorage." if process.env.NODE_ENV == "development")
          .catch((e) => console.error e.message)
      , 1000
      deep: true
  created: ->
    @$store.dispatch("loadFromLocalStorage")
      .then((loaded) =>
        console.log "Loaded from the LocalStorage." if process.env.NODE_ENV == "development"
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
