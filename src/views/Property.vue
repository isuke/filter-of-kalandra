<template lang="pug">
main.property
  property-header.header

  property-list.main
</template>

<script lang="coffee">
import PropertyHeader from "@/views/PropertyHeader"
import PropertyList   from "@/views/PropertyList"

export default
  components:
    "property-header": PropertyHeader
    "property-list": PropertyList
</script>

<style lang="scss" scoped>
.property {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: 1fr;

  > .header {
    grid-row: 1;
    grid-column: 1;
    position: sticky;
    top: $global-fixed-height;
  }

  > .main {
    grid-row: 2;
    grid-column: 1;
  }
}
</style>
