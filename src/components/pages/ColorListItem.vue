<template>
  <div class="color-list-item">
    <dl class="list">
      <dt class="term">RGB</dt>
      <dd class="description">{{ rgbStr }}</dd>
      <dt class="term">HEX</dt>
      <dd class="description">{{ hexLazy }}</dd>
      <dt class="term">HSL</dt>
      <dd class="description">{{ hslStr }}</dd>
      <dt class="term">Luminosity</dt>
      <dd class="description">{{ round(colorObjectLazy?.luminosity()) }}</dd>
      <dt class="term">Is Light?</dt>
      <dd class="description">{{ colorObjectLazy?.isLight() }}</dd>
    </dl>
    <div class="previews">
      <div class="preview background"><span class="item" :style="backgroundStyle">Item Name</span></div>
      <div class="preview font"><span class="item" :style="fontStyle">Item Name</span></div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import Color from "color"
import debounce from "lodash.debounce"
import { ref, computed, watch } from "vue"

import { ColorHex, ColorRGBString } from "@/types/color"
import { round } from "@/utils/numberUtils"

type Props = {
  name: string
  hex: ColorHex
}
const props = defineProps<Props>()

const hexLazy = ref<ColorHex | undefined>(props.hex)
const colorObjectLazy = ref<Color<string> | undefined>(new Color(props.hex))

watch(
  () => props.hex,
  (hex) =>
    debounce(() => {
      hexLazy.value = hex
      colorObjectLazy.value = new Color<string>(hex)
    }, 0),
)

const rgbStr = computed<ColorRGBString | "">(() => {
  const color = colorObjectLazy.value?.rgb().object()

  if (color) {
    return `${color?.r} ${color?.g} ${color?.b}`
  } else {
    return ""
  }
})

const hslStr = computed<`${number}° ${number}% ${number}%` | "">(() => {
  const color = colorObjectLazy.value?.hsl().object()

  if (color) {
    return `${Math.floor(color.h)}° ${Math.floor(color.s)}% ${Math.floor(color.l)}%`
  } else {
    return ""
  }
})

const backgroundStyle = computed<{ "background-color": string; "color": "black" | "white" }>(() => {
  return {
    "background-color": hexLazy.value ?? "",
    "color": colorObjectLazy.value?.isLight ? "black" : "white",
  }
})

const fontStyle = computed<{ "background-color": "black" | "white"; "color": string; "border": `0.2em ${string} solid` }>(() => {
  return {
    "background-color": colorObjectLazy.value?.isLight() ? "black" : "white",
    "color": hexLazy.value ?? "",
    "border": `0.2em ${hexLazy.value} solid`,
  }
})
</script>

<style lang="scss" scoped>
.color-list-item {
  display: grid;

  > .list {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-auto-rows: max-content;
    column-gap: var(--space-size-s);

    > .term {
      /* no-op */
    }

    > .description {
      /* no-op */
    }
  }

  > .previews {
    display: inline-grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--space-size-s);
    margin-top: var(--space-size-s);

    .preview {
      display: flex;
      flex: 1;
      align-items: center;
      justify-content: center;
      padding: 0.5rem;
      background-color: black;
      border-radius: $border-radius-base;

      > .item {
        padding: 0.5em;
      }
    }
  }
}
</style>
