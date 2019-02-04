<template lang="pug">
.script-text
  header.header
    ul.list
      li.item(v-for="scriptName in $store.getters.scriptNames")
        a.scriptname(@click.prevent="changeCurrentScript(scriptName)", href="") {{ scriptName }}
  //- filter-editor.text(v-model="$store.getters.simpleScriptTexts[currentScriptName]", mode="original-poe-filter", :config="{ readOnly: true, lineWrapping: true }")
  textarea.textarea(v-model="$store.getters.simpleScriptTexts[currentScriptName]", readOnly)
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
  data: ->
    currentScriptName: undefined
  methods:
    changeCurrentScript: (scriptName) -> @currentScriptName = scriptName
  created: ->
    @currentScriptName = @$store.getters.scriptNames[0]
</script>

<style lang="scss" scoped>
.script-text {
  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .header {
    > .list {
      display: inline-flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      width: 100%;
      height: $sub-header-height;
      padding-left: var(--space-size-s);

      > .item {
        flex: 1;
      }
    }
  }

  // > .text {
  //   width: calc(100vw - #{$aside-size-width});
  // }
  > .textarea {
    font-family: $mono-font-family;
    padding: 0.5em;
    width: calc(100vw - #{$aside-size-width});
    height: calc(100% - #{$sub-header-height});
    // height: calc(100vh - #{$global-header-height} - #{$sub-header-height})
  }
}
</style>
