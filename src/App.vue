<template lang="pug">
#app
  the-global-header.header(@add-toaster="$refs.toaster.add($event)")

  keep-alive
    router-view.main(@add-toaster="$refs.toaster.add($event)")

  the-global-footer.footer

  the-toaster-list.toaster(ref="toaster")
</template>

<script lang="coffee">
import debounce from "lodash.debounce"

import localStrorageUsable from "@/scripts/mixins/localStorageUsable.coffee"

import TheGlobalHeader from "@/components/TheGlobalHeader"
import TheGlobalFooter from "@/components/TheGlobalFooter"
import TheToasterList  from "@/components/TheToasterList"

export default
  mixins: [
    localStrorageUsable
  ]
  components:
    "the-global-header": TheGlobalHeader
    "the-global-footer": TheGlobalFooter
    "the-toaster-list":  TheToasterList
  computed:
    advancedScriptText: -> @$store.state.advancedScriptText
    variables:          -> @$store.state.variables
    colors:             -> @$store.state.colors
    properties:         -> @$store.state.properties
    filterInfo:         -> @$store.state.filterInfo
    options:            -> @$store.state.options
  methods:
    createCompileWorker: ->
      @$store.dispatch "createCompileWorker",
        successCallback: debounce =>
          @$refs.toaster.add("completed to compile")
        , 1000
        failCallback: debounce =>
          @$refs.toaster.add { message: "failed compile", type: "error" }
        , 1000
  created: ->
    @loadFromLocalStorage()
    @createCompileWorker()
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

  > .toaster {
    position: fixed;
    top: $global-header-height;
    right: 0;
    margin: var(--space-size-s);
    z-index: $toaster-z-index;
  }
}
</style>
