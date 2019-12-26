<template lang="pug">
.script-text
  header.header
    ul.list
      li.item(
        v-for="(scriptName, i) in $store.getters.scriptNames",
        :key="i",
        @click.prevent="changeCurrentScript(scriptName)",
        :class="{ '-current': scriptName === currentScriptName }"
      )
        | {{ scriptName }}
    .actions
      button.button.copy(@click.prevent="copy") Copy to Clipboard
      button.button.reload(@click.prevent="reload") Reload
  pre.text(ref="text", v-text="text")
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
  data: ->
    currentScriptName: undefined
  computed:
    texts: -> @$store.state.simpleScriptTexts
    text: -> @texts[@currentScriptName]
  watch:
    text: -> @$nextTick => @createMonaco()
  methods:
    changeCurrentScript: (scriptName) -> @currentScriptName = scriptName
    createMonaco: ->
      if @$refs.text.childElementCount == 0 && @text.length < 100000
        `import(/* webpackChunkName: "monaco" */ "monaco-editor")`.then (monaco) =>
          monaco.editor.colorizeElement @$refs.text,
            mimeType: "advancedPoeFilter"
            theme: "advancedPoeFilterTheme"
            tabSize: 4
    copy: ->
      navigator.clipboard.writeText(@text)
      .then(() => @$emit('add-toaster', "copied"))
      .catch((e) => console.error e.message)
    reload: ->
      @$emit('add-toaster', "started to reload")
      @$store.dispatch("requestSimpleScriptTextsToWorker")
  created: ->
    @currentScriptName = @$store.getters.scriptNames[0]
  mounted: ->
    @reload()
</script>

<style lang="scss" scoped>
$my-sub-header-height: 3rem;
$my-sub-header-z-index: $base-z-index + 20;

.script-text {
  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .header {
    position: sticky;
    top: calc(#{$global-fixed-height} + #{$sub-header-height});
    height: $my-sub-header-height;
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    padding-left: var(--space-size-xl);
    width: 100%;
    height: $sub-header-height;

    @include bg-ft-color($script-color-hue, "day");

    > .list {
      flex: 1;
      display: inline-flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;

      > .item {
        flex: 1;
        display: inline-flex;
        align-items: center;
        text-decoration-line: underline;
        cursor: pointer;

        &.-current {
          color: _ft-color($script-color-hue, "day", true);
        }
      }
    }

    > .actions {
      display: inline-flex;
      align-items: center;

      > .button {
        @include button-fill($color-color-hue);
        margin-right: var(--space-size-s);
      }
    }
  }

  > .text {
    padding: 0.5em;
    background-color: white;
    overflow-x: scroll;
  }
}
</style>
