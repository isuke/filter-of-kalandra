<template>
  <div class="script-preview-item" @mouseover="isShowTooltip = true" @mouseleave="isShowTooltip = false">
    <div class="icon-wrap">
      <minimap-icon
        class="icon"
        :size="block.actions.MinimapIcon.size"
        :color="block.actions.MinimapIcon.color"
        :shape="block.actions.MinimapIcon.shape"
        v-if="block.activity === 'Show' && block.actions.MinimapIcon"
      />
    </div>
    <span class="name" :style="getNameStyle(block.actions)" @click.prevent="playAlertSound(block.actions)" v-show="block.activity === 'Show' || isAlt">
      Item Name {{ hasAlertSound ? "♪" : "" }} {{ hasCustomAlertSound ? "♫" : "" }}
    </span>
    <div class="play-effect-wrap">
      <div
        class="play-effect"
        :class="{ '-temp': block.actions.PlayEffect.temp }"
        :style="getPlayEffectStyle(block.actions.PlayEffect)"
        v-if="block.activity === 'Show' && block.actions.PlayEffect"
      />
    </div>
    <div class="tooltip" v-show="isShowTooltip && Object.keys(block.name).length > 0">
      <dl class="list">
        <template v-for="(val, key) in block.name" :key="key">
          <dt class="term">{{ key }}</dt>
          <dd class="description">{{ val ? val : "Any" }}</dd>
        </template>
      </dl>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, computed } from "vue"

import MinimapIcon from "@/commons/MinimapIcon.vue"
import { playSound } from "@/composables/sound"

import type * as advancedPoeFilter from "advanced-poe-filter"
import type * as advancedPoeFilterParser from "advanced-poe-filter-parser"

type Props = {
  block: advancedPoeFilter.Block
  isAlt: boolean
}
const props = withDefaults(defineProps<Props>(), {
  isAlt: false,
})

const isShowTooltip = ref<boolean>(false)

const hasAlertSound = computed<boolean>(() => {
  return !!(props.block.actions.PlayAlertSound || props.block.actions.PlayAlertSoundPositional)
})

const hasCustomAlertSound = computed<boolean>(() => {
  return !!(props.block.actions.CustomAlertSound || props.block.actions.CustomAlertSoundOptional)
})

const getNameStyle = (actions: advancedPoeFilter.Block["actions"]) => {
  return {
    "border": actions.SetBorderColor ? `1px ${getColorStrForStyle(actions.SetBorderColor)} solid` : undefined,
    "color": actions.SetTextColor ? getColorStrForStyle(actions.SetTextColor) : undefined,
    "background-color": actions.SetBackgroundColor ? getColorStrForStyle(actions.SetBackgroundColor) : undefined,
    "font-size": actions.SetFontSize ? `${Math.round(actions.SetFontSize / 2.5)}px` : undefined,
    "cursor": hasAlertSound.value ? "pointer" : undefined,
  }
}

const getColorStrForStyle = (colorObject: advancedPoeFilterParser.RGBA): `rgba(${number},${number},${number},${number})` => {
  return `rgba(${colorObject.rgb.r},${colorObject.rgb.g},${colorObject.rgb.b},${colorObject.alpha / 255})`
}

const playAlertSound = (actions: advancedPoeFilter.Block["actions"]) => {
  const sound = actions.PlayAlertSound ?? actions.PlayAlertSoundPositional

  if (sound) {
    return playSound({ id: sound.id, volume: sound.volume })
  } else {
    return undefined
  }
}

const getPlayEffectStyle = (playEffect: advancedPoeFilter.Block["actions"]["PlayEffect"]): { "background-color": string; "color": string } | undefined => {
  switch (playEffect?.color) {
    case "Red":
      return { "background-color": "hsla(  0, 100%, 45%, 0.8)", "color": "white" }
    case "Green":
      return { "background-color": "hsla(110, 100%, 45%, 0.8)", "color": "white" }
    case "Blue":
      return { "background-color": "hsla(230, 100%, 45%, 0.8)", "color": "white" }
    case "Brown":
      return { "background-color": "hsla( 20, 100%, 45%, 0.8)", "color": "white" }
    case "White":
      return { "background-color": "rgba(255, 255, 255 , 0.8)", "color": "black" }
    case "Yellow":
      return { "background-color": "hsla( 60, 100%, 45%, 0.8)", "color": "black" }
    case "Cyan":
      return { "background-color": "hsla(180, 100%, 45%, 0.8)", "color": "white" }
    case "Grey":
      return { "background-color": "rgba( 60,  60,  60 , 0.8)", "color": "white" }
    case "Orange":
      return { "background-color": "hsla( 20, 100%, 65%, 0.8)", "color": "white" }
    case "Pink":
      return { "background-color": "hsla(300,  30%, 65%, 0.8)", "color": "black" }
    case "Purple":
      return { "background-color": "hsla(270, 100%, 50%, 0.8)", "color": "white" }
  }
}
</script>

<style lang="scss" scoped>
$my-tooltip-z-index: 100;

.script-preview-item {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  white-space: nowrap;

  > .icon-wrap {
    width: 32px;
    height: 32px;
    margin: {
      right: var(--space-size-xs);
      left: var(--space-size-xs);
    }

    > .icon {
      /* no-op */
    }
  }

  > .name {
    padding: 0.5em;
    margin: auto;
    font-size: 11px; // Override by js
    color: white;
    cursor: default;
    background-color: black;
  }

  > .play-effect-wrap {
    width: 32px;
    height: 32px;
    margin: {
      right: var(--space-size-xs);
      left: var(--space-size-xs);
    }

    > .play-effect {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 32px;
      height: 32px;
      border-radius: 50%;

      &.-temp::before {
        font-size: var(--ft-size-m);
        font-weight: $bold-font-weight;
        content: "T";
      }
    }
  }

  > .tooltip {
    position: absolute;
    bottom: 2.5rem;
    left: auto;
    z-index: $my-tooltip-z-index;
    padding: var(--space-size-xs);
    background-color: white;
    border-radius: $border-radius-base;
    opacity: 0.9;

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
