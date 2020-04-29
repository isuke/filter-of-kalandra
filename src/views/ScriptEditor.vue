<template lang="pug">
.script-editor
  filter-editor.editor(
    ref="editor",
    v-model="$store.state.advancedScriptText",
    :syntax-error="$store.state.syntaxError"
  )
  .hint
    p.item Do you want to edit by text editor? <a class="link" href="https://marketplace.visualstudio.com/items?itemName=isuke.vscode-advanced-poe-filter" target="_blank" rel="noopener noreferrer">There is vscode extention !</a>
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
      @$ga.event('script', 'edit') if process.env.NODE_ENV == "production"
      @$store.dispatch("requestSimpleScriptObjectToWorker")
    , 2500
  methods:
    scrollToSection: (sectionName) ->
      @$refs.editor.scrollToSection(sectionName)
</script>

<style lang="scss" scoped>
.script-editor {
  max-width: calc(100vw - #{$aside-size-width});
  font-size: var(--ft-size-m);

  > .editor {
    height: 100%;
  }

  > .hint {
    padding: var(--space-size-m);

    > .item {
      > .link {
        text-decoration: underline;
      }
    }
  }
}
</style>
