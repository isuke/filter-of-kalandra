<template lang="pug">
.script-editor
  filter-editor.editor(
    ref="editor",
    v-model="$store.state.advancedScriptText",
    :syntax-error="$store.state.syntaxError",
  )
</template>

<script lang="coffee">
import debounce from "lodash.debounce"

import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
  computed:
    advancedScriptText: -> @$store.state.advancedScriptText
  watch:
    advancedScriptText: debounce ->
      @$store.dispatch("requestSimpleScriptObjectToWorker")
    , 1000
  methods:
    scrollToSection: (sectionName) ->
      @$refs.editor.scrollToSection(sectionName)
</script>

<style lang="scss" scoped>
.script-editor {
  max-width: calc(100vw - #{$aside-size-width});

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;
}
</style>
