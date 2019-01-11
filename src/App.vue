<template lang="pug">
  #app
    nav.nav
      router-link(to="/") Home
      | |
      router-link(to="/script/editor") Script
      | |
      router-link(to="/variable") Variable
      | |
      router-link(to="/color") Color
      | |
      router-link(to="/property") Property

    main.main
      keep-alive
        router-view
</template>

<script lang="coffee">
import sample from "@/sample.coffee"

export default
  methods:
    setSamples: ->
      @$store.commit "setAdvancedScriptText", { advancedScriptText: sample.advancedScriptText }
      @$store.commit "setVariables", { variables: sample.variables }
      @$store.commit "setColors", { colors: sample.colors }
      @$store.commit "setProperties", { properties: sample.properties }
  created: ->
    @setSamples() if process.env.NODE_ENV == "development"
</script>


<style lang="scss" scoped>
#app {
}
</style>
