<template lang="pug">
.script-preview
  header.header
    .sectionname {{ currentSectionName }}
    .actions
      button.button.reload(@click.prevent="isAlt = !isAlt") ALT (Now {{ isAlt ? 'ON' : 'OFF' }})
      button.button.reload(@click.prevent="reload") Reload

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
      @$store.dispatch "toasterStore/add", message: "started to reload"
      @$store.dispatch("requestSimpleScriptObjectToWorker")
    scrollToSection: (sectionName) ->
      @$store.dispatch "toasterStore/add", message: "started to create preview '#{sectionName}'"
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
$my-sub-header-height: 3rem;
$my-sub-header-z-index: $base-z-index + 20;
$my-section-name-z-index: $base-z-index + 10;

.script-preview {
  > .header {
    position: sticky;
    top: calc(#{$global-fixed-height} + #{$sub-header-height});
    height: $my-sub-header-height;
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    width: 100%;
    height: $sub-header-height;
    z-index: $my-sub-header-z-index;

    background-color: $night-bg-color2;
    color: $night-ft-color;

    > .sectionname {
      flex: 1;
      padding: var(--space-size-m);
      font-size: var(--ft-size-l);
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

  > .script {
    > .name {
      position: sticky;
      top: calc(#{$global-fixed-height} + #{$sub-header-height} + #{$my-sub-header-height});
      padding: var(--space-size-m);
      font-size: var(--ft-size-l);

      background-color: $night-bg-color3;
      color: $night-ft-color;

      z-index: $my-section-name-z-index;
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
