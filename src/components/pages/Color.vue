<template>
  <main class="color">
    <color-header class="header" />
    <color-aside class="aside" @click-color-name="scrollToColor" />
    <color-list class="main" />
  </main>
</template>

<script lang="ts" setup>
import { nextTick } from "vue"

import ColorAside from "@/pages/ColorAside.vue"
import ColorHeader from "@/pages/ColorHeader.vue"
import ColorList from "@/pages/ColorList.vue"

const scrollToColor = (colorName: string) => {
  nextTick(() => {
    const y = (document.getElementById(colorName)?.getBoundingClientRect()?.top || 0) - 48 - 48 // MEMO: header height
    window.scrollBy(0, y)
  })
}
</script>

<style lang="scss" scoped>
.color {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: $aside-size-width 1fr;

  > .header {
    position: sticky;
    top: $global-fixed-height;
    grid-row: 1;
    grid-column: 2;
  }

  > .aside {
    grid-row: 1 / -1;
    grid-column: 1;
  }

  > .main {
    grid-row: 2;
    grid-column: 2;
  }
}
</style>
