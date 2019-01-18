<template lang="pug">
  #app
    the-global-header

    main.main
      keep-alive
        router-view
</template>

<script lang="coffee">
import TheGlobalHeader from "@/components/TheGlobalHeader"

import sample from "@/sample.coffee"

export default
  components:
    "the-global-header": TheGlobalHeader
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
}
</style>
