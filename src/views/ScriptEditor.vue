<template lang="pug">
.script-editor
  filter-editor.editor(
    ref="editor",
    v-model="$store.state.advancedScriptText",
    :syntax-error="$store.state.syntaxError",
  )
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
  methods:
    scrollToSection: (sectionName) ->
      @$refs.editor.scrollToSection(sectionName)
</script>

<style lang="scss" scoped>
.script-editor {
  max-width: calc(100vw - #{$aside-size-width});
}
</style>
