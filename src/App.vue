<template lang="pug">
  #app
    the-global-header.header

    keep-alive
      router-view.main

    the-global-footer.footer
</template>

<script lang="coffee">
import TheGlobalHeader from "@/components/TheGlobalHeader"
import TheGlobalFooter from "@/components/TheGlobalFooter"

import sample from "@/sample.coffee"

export default
  components:
    "the-global-header": TheGlobalHeader
    "the-global-footer": TheGlobalFooter
  data: ->
    saveIntervalID: undefined
  methods:
    setSaveInterval: ->
      @saveIntervalID = setInterval (=> @$store.dispatch "saveToLocalStorage"), 1000 * 30
    clearSaveInterval: ->
      @saveIntervalID = clearInterval @saveIntervalID
    setSamples: ->
      @$store.commit "setAdvancedScriptText", advancedScriptText: sample.advancedScriptText
      @$store.commit "setVariables", variables: sample.variables
      @$store.commit "setColors", colors: sample.colors
      @$store.commit "setProperties", properties: sample.properties
  created: ->
    @setSamples() if process.env.NODE_ENV == "development"
    @$store.dispatch "loadFromLocalStorage"
    @setSaveInterval()
</script>


<style lang="scss" scoped>
#app {
  width: 100%;
  min-height: 100vh;
  display: grid;
  grid-template-rows: $global-header-height 1fr 2rem;
  grid-template-columns: 1fr;

  > .header {
    grid-row: 1;
    grid-column: 1;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: $global-header-height;
    background-color: $bg-color-base;
    z-index: $codemirror-z-index + 10;
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
