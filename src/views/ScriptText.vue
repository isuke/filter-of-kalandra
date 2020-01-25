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
        .title {{ scriptName }}
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
            theme: "advancedPoeFilterNightTheme"
            tabSize: 4
    copy: ->
      @$ga.event('text', 'copy to clipboard') if process.env.NODE_ENV == "production"
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

    background-color: $night-bg-color2;
    color: $night-ft-color;

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
        cursor: pointer;

        > .title {
          color: $night-ft-accent-color3;
          font-weight: $bold-font-weight;
          border-bottom-width: $border-height-bold;
          border-bottom-style: solid;
          border-color: $night-bg-color2;
        }

        &.-current > .title {
          color: $night-ft-accent-color1;
          border-color: $night-ft-accent-color1;
        }
      }
    }

    > .actions {
      display: inline-flex;
      align-items: center;

      > .button {
        @include button-fill();
        margin-right: var(--space-size-s);
      }
    }
  }

  > .text {
    padding: 0.5em;
    background-color: $night-bg-color;
    color: $night-ft-color;
    overflow-x: scroll;
  }
}
</style>
