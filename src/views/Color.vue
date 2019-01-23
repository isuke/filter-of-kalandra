<template lang="pug">
main.color
  color-header.header

  color-aside.aside

  color-list.main
</template>

<script lang="coffee">
import ColorHeader from "@/views/ColorHeader"
import ColorAside from "@/views/ColorAside"
import ColorList from "@/views/ColorList"

export default
  components:
    "color-header": ColorHeader
    "color-aside": ColorAside
    "color-list": ColorList
</script>

<style lang="scss" scoped>
.color {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: $aside-size-width 1fr;

  > .header {
    grid-row: 1;
    grid-column: 2;
    position: sticky;
    top: $global-header-height;
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
