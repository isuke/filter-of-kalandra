<template lang="pug">
  #app
    nav.nav
      router-link(to="/") Home
      | |
      router-link(to="/script/editor") Script

    main.main
      router-view
</template>

<script lang="coffee">
import sample from "@/sample.coffee"

export default
  created: ->
    @$store.commit "setAdvancedScriptText", { advancedScriptText: sample.advancedScriptText } if process.env.NODE_ENV == "development"
</script>


<style lang="scss" scoped>
#app {
}
</style>
