<template lang="pug">
.script-preview-item(
  @mouseover="isShowTooltip = true",
  @mouseleave="isShowTooltip = false"
)
  .iconwrap
    minimap-icon.icon(
      :size="block.actions.MinimapIcon.size",
      :color="block.actions.MinimapIcon.color",
      :shape="block.actions.MinimapIcon.shape",
      v-if="block.activity === 'Show' && block.actions.MinimapIcon"
    )
  span.name(
    :style="getNameStyle(block.actions)",
    @click.prevent="playAlertSound(block.actions)",
    v-show="block.activity === 'Show' || isAlt"
  )
    | Item Name {{ hasAlertSound ? '♪' : '' }} {{ block.actions.CustomAlertSound ? '♫' : '' }}
  .playeffectwrap
    .playeffect(
      :class="{ '-temp': block.actions.PlayEffect.temp }",
      :style="getPlayEffectStyle(block.actions.PlayEffect)",
      v-if="block.activity === 'Show' && block.actions.PlayEffect"
    )

  .tooltip(v-show="isShowTooltip && Object.keys(block.name).length > 0")
    dl.list
      template(v-for="(val, key) in block.name")
        dt.term {{ key }}
        dd.description {{ val ? val : 'Any' }}
</template>

<script lang="coffee">
import Color from "color"

import MinimapIcon from "@/components/MinimapIcon.vue"

import soundAudible from "@/scripts/mixins/soundAudible.coffee"

export default
  components:
    "minimap-icon": MinimapIcon
  mixins: [
    soundAudible
  ]
  data: ->
    isShowTooltip: false
  props:
    block:
      type: Object
      required: true
    isAlt:
      type: Boolean
      required: false
      default: false
  computed:
    hasAlertSound: ->
      @block.actions.PlayAlertSound || @block.actions.PlayAlertSoundPositional
  methods:
    getNameStyle: (actions) ->
      {
        "border": "1px #{@getColorStr(actions.SetBorderColor)} solid"   if actions.SetBorderColor
        "color": @getColorStr(actions.SetTextColor)                     if actions.SetTextColor
        "background-color": @getColorStr(actions.SetBackgroundColor)    if actions.SetBackgroundColor
        "font-size": "#{Math.round(actions.SetFontSize / 2.5)}px"       if actions.SetFontSize
        "cursor": "pointer"                                             if @hasAlertSound
      }
    getColorStr: (colorObject) ->
      color = new Color(colorObject.rgb)
      "rgba(#{color.rgb().color.join(',')},#{colorObject.alpha / 255})"
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
$my-tooltip-z-index: 100;

.script-preview-item {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  white-space: nowrap;

  > .iconwrap {
    @ghost size(32px);
    @ghost margin-left-right(var(--space-size-xs));

    > .icon { /* no-op */ }
  }

  > .name {
    margin: auto;
    padding: 0.5em;
    background-color: black;
    color: white;
    font-size: 11px; // Override by js

    cursor: default;
  }

  > .playeffectwrap {
    @ghost size(32px);
    @ghost margin-left-right(var(--space-size-xs));

    > .playeffect {
      display: flex;
      align-items: center;
      justify-content: center;
      @ghost circle(32px);

      &.-temp::before {
        content: "T";
        font-size: var(--ft-size-m);
        font-weight: $bold-font-weight;
      }
    }
  }

  > .tooltip {
    position: absolute;
    bottom: 2.5rem;
    left: auto;
    opacity: 0.9;
    padding: var(--space-size-xs);
    border-radius: $border-radius-base;
    background-color: white;

    z-index: $my-tooltip-z-index;

    > .list {
      display: grid;
      grid-template-columns: max-content max-content;

      > .term {
        grid-column: 1;
        margin-right: var(--space-size-xs);
      }

      > .description {
        grid-column: 2;
      }
    }
  }
}
</style>
