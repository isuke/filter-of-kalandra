<template lang="pug">
.script-preview
  header.header
    .actions
      button.button.reload(@click.prevent="isAlt = !isAlt") ALT (Now {{ isAlt ? 'ON' : 'OFF' }})
      button.button.reload(@click.prevent="reload") Reload

  .sectionname {{ currentSectionName }}

  .script(v-for="scriptName in $store.getters.scriptNames", :key="scriptName")
    .name {{ scriptName }}
    .items
      script-preview-item.item(
        v-for="block in $store.getters.blocks(scriptName, currentSectionName)",
        :key="block.id"
        :block="block",
        :isAlt="isAlt"
      )
</template>

<script lang="coffee">
import ScriptPreviewItem from "@/views/ScriptPreviewItem"

import bgImage from "@/assets/images/preview-bg-594x1056.png"

export default
  components:
    "script-preview-item": ScriptPreviewItem
  data: ->
    currentSectionName: undefined
    bgImage: bgImage
    isAlt: false
  methods:
    reload: ->
      @$emit('add-toaster', "started to reload")
      @$store.dispatch("requestSimpleScriptObjectToWorker")
    scrollToSection: (sectionName) ->
      @$emit('add-toaster', "started to create preview '#{sectionName}'")
      setTimeout =>
        @currentSectionName = sectionName
      , 600  # $duration-slow
  created: ->
    @currentSectionName = @$store.getters.sectionNames[0]
  mounted: ->
    window.addEventListener 'keydown', (event) => @isAlt = true  if event.key == 'Alt'
    window.addEventListener 'keyup'  , (event) => @isAlt = false if event.key == 'Alt'
</script>

<style lang="scss" scoped>
$my-bg-height: 1056px;
$my-bg-width: 594px;
$my-header-z-index: $base-z-index + 10;

.script-preview {
  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .header {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-end;
    // padding-left: var(--space-size-l);
    width: 100%;
    height: $sub-header-height;

    @include bg-ft-color($script-color-hue, "day");

    > .actions {
      display: inline-flex;
      align-items: center;

      > .button {
        @include button-fill($color-color-hue);
        margin-right: var(--space-size-s);
      }
    }
  }

  > .sectionname {
    padding: var(--space-size-m);
    font-size: var(--ft-size-l);
  }

  > .script {
    > .name {
      position: sticky;
      top: calc(#{$global-fixed-height} + #{$sub-header-height});
      padding: var(--space-size-m);
      font-size: var(--ft-size-l);
      background-color: $global-bg-color-day;
      z-index: $my-header-z-index;
    }

    > .items {
      display: flex;
      flex-wrap: wrap;
      height: 100%;
      width: 100%;
      padding: var(--space-size-m);
      align-items: center;
      justify-content: space-between;

      background-image: url("./../assets/images/preview-bg-594x1056.png");
      background-repeat: repeat-y;
      background-size: 100% auto;

      > .item {
        margin: var(--space-size-xs);
      }
    }
  }
}
</style>
