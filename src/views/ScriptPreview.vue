<template lang="pug">
.script-preview
  .subheader.none
  .subheader.scriptname(v-for="scriptName in $store.getters.scriptNames") {{ scriptName }}

  template(v-for="(scripts, sectionName) in simpleScriptObjectsForPreview")
    .sectionname {{ sectionName }}

    template(v-for="(blocks, blockName) in scripts")
      .blockname {{ blockName }}

      template(v-for="(block, scriptName) in blocks")
        .image
          img.back(:src="bgImage")
          .item
            minimap-icon.icon(
              :size="block.actions.MinimapIcon.size",
              :color="block.actions.MinimapIcon.color",
              :shape="block.actions.MinimapIcon.shape",
              v-if="block.activity === 'Show' && block.actions.MinimapIcon"
            )
            span.name(
              :style="getNameStyle(block.actions)",
              @click.prevent="playAlertSound(block.actions)",
              v-if="block.activity === 'Show'"
            ) Item Name
            .playeffect(
              :class="{ '-temp': block.actions.PlayEffect.temp }",
              :style="getPlayEffectStyle(block.actions.PlayEffect)",
              v-if="block.activity === 'Show' && block.actions.PlayEffect"
            )
</template>

<script lang="coffee">
import Color from "color"

import MinimapIcon from "@/components/MinimapIcon.vue"

import soundAudible from "@/mixins/soundAudible.coffee"

import bgImage from "@/assets/images/preview-bg-200x150.png"

# TODO: move to utils
forIn = (object, callback) =>
  Object.keys(object).forEach (key) => callback(object[key], key)

export default
  components:
    "minimap-icon": MinimapIcon
  data: ->
    bgImage: bgImage
  mixins: [
    soundAudible
  ]
  computed:
    simpleScriptObjectsForPreview: ->
      result = {}
      forIn @$store.getters.simpleScriptObjects, (sections, scriptName) =>
        sections.forEach (section) =>
          result[section.name] = {} unless result[section.name]
          section.blocks.forEach (block) =>
            blockName = @getBlockNameStr(block.name)
            result[section.name][blockName] = {} unless result[section.name][blockName]
            result[section.name][blockName][scriptName] = {}
            result[section.name][blockName][scriptName].activity = block.activity
            result[section.name][blockName][scriptName].actions = block.actions
      result
  methods:
    getBlockNameStr: (blockNameObject) ->
      temp = []
      forIn blockNameObject, (val, key) =>
        if val
          temp.push("#{key} is \"#{val}\"")
        else
          temp.push("#{key} is Any")
      temp.join(' - ')
    getNameStyle: (actions) ->
      {
        "border": "0.2em #{@getColorStr(actions.SetBorderColor)} solid" if actions.SetBorderColor
        "color": @getColorStr(actions.SetTextColor)                     if actions.SetTextColor
        "background-color": @getColorStr(actions.SetBackgroundColor)    if actions.SetBackgroundColor
        "font-size": "#{Math.round(actions.SetFontSize / 2)}px"         if actions.SetFontSize
      }
    getColorStr: (colorObject) ->
      color = new Color(colorObject.rgb)
      color.hex().replace('0x', '#') # TODO: alpha
    playAlertSound: (actions) ->
      sound = if actions.PlayAlertSound
        actions.PlayAlertSound
      else if actions.PlayAlertSoundPositional
        actions.PlayAlertSoundPositional

      return unless sound

      @sound(sound.id, sound.volume)
    getPlayEffectStyle: (playEffect) ->
      switch playEffect.color
        when "Red"    then { "background-color": "hsla(  0, 100%, 45%, 0.6)", color: "white" }
        when "Green"  then { "background-color": "hsla(110, 100%, 45%, 0.6)", color: "white" }
        when "Blue"   then { "background-color": "hsla(230, 100%, 45%, 0.6)", color: "white" }
        when "Brown"  then { "background-color": "hsla( 20, 100%, 45%, 0.6)", color: "white" }
        when "White"  then { "background-color": "rgba(255, 255, 255 , 0.6)", color: "black" }
        when "Yellow" then { "background-color": "hsla( 60, 100%, 45%, 0.6)", color: "black" }
</script>

<style lang="scss" scoped>
$my-header-z-index: $base-z-index + 10;

.script-preview {
  display: grid;
  grid-template-columns: max-content;
  grid-column-gap: var(--space-size-s);
  padding-left: var(--space-size-m);
  padding-right: var(--space-size-m);

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .subheader {
    position: sticky;
    display: flex;
    align-items: center;
    height: $sub-header-height;
    top: calc(#{$global-header-height} + #{$sub-header-height});
    padding: var(--space-size-m);
    font-size: var(--ft-size-l);
    background-color: $global-bg-color-day;
    z-index: $my-header-z-index;

    &.none {
      grid-row: 1;
      grid-column: 1;
    }

    &.scriptname {
      grid-row: 1;
      grid-column: auto;

      display: flex;
      justify-content: center;
      white-space: nowrap;
    }
  }

  > .sectionname {
    grid-row: auto;
    grid-column: 1 / -1;

    position: sticky;
    display: flex;
    align-items: center;
    top: calc(#{$global-header-height} + #{$sub-header-height});
    height: $sub-header-height;
    font-size: var(--ft-size-l);
    background-color: $global-bg-color-day;
    z-index: $my-header-z-index;
  }

  > .blockname {
    grid-row: auto;
    grid-column: 1;

    display: flex;
    align-items: center;
    max-width: 24rem;
    overflow: scroll;
    white-space: nowrap;
  }

  > .image {
    grid-row: auto;
    grid-column: auto;

    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;

    > .back {
      position: relative;
      overflow: hidden;
      @ghost size(160px, 64px);
    }

    > .item {
      position: absolute;
      display: flex;
      align-items: center;

      > .icon { /* no-op */ }

      > .name {
        margin: auto;
        padding: 0.5em;
        opacity: 0.5;
        background-color: black;
        color: white;
        font-size: 11px;
        cursor: pointer;
      }

      > .playeffect {
        display: flex;
        align-items: center;
        justify-content: center;
        @ghost circle(1.5rem);
        margin-left: var(--space-size-s);

        &.-temp::before {
          content: "T";
          font-size: var(--ft-size-m);
          font-weight: $bold-font-weight;
        }
      }
    }
  }
}
</style>
