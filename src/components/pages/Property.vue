<template>
  <main class="property">
    <property-header class="header" />
    <property-list class="main" />
  </main>
</template>

<script lang="ts" setup>
import PropertyHeader from "@/pages/PropertyHeader.vue"
import PropertyList from "@/pages/PropertyList.vue"
</script>

<style lang="scss" scoped>
.property {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: 1fr;

  > .header {
    position: sticky;
    top: $global-fixed-height;
    grid-row: 1;
    grid-column: 1;
  }

  > .main {
    grid-row: 2;
    grid-column: 1;
  }
}
</style>
