<template>
  <main class="variable">
    <variable-header class="header" />
    <variable-aside class="aside" @click-variable-name="scrollToVariable" />
    <variable-list class="main" />
  </main>
</template>

<script lang="ts" setup>
import { nextTick } from "vue"

import VariableAside from "@/pages/VariableAside.vue"
import VariableHeader from "@/pages/VariableHeader.vue"
import VariableList from "@/pages/VariableList.vue"

const scrollToVariable = (variableName: string): void => {
  nextTick(() => {
    const y = (document.getElementById(variableName)?.getBoundingClientRect().top || 0) - 48 - 48 // MEMO: header height
    window.scrollBy(0, y)
  })
}
</script>

<style lang="scss" scoped>
.variable {
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
