<template lang="pug">
main.variable
  variable-header.header

  variable-aside.aside(@click-variable-name="scrollToVariable")

  variable-list.main
</template>

<script lang="coffee">
import VariableHeader from "@/views/VariableHeader.vue"
import VariableAside  from "@/views/VariableAside.vue"
import VariableList   from "@/views/VariableList.vue"

export default
  components:
    "variable-header": VariableHeader
    "variable-aside": VariableAside
    "variable-list": VariableList
  methods:
    scrollToVariable: (variableName) ->
      y = document.getElementById(variableName).getBoundingClientRect().top - 48 - 48 # TODO: header height
      window.scrollBy 0, y
</script>

<style lang="scss" scoped>
.variable {
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

    // > .variable {
    //   display: block;

    //   > .name {
    //     font-size: 1.5rem;
    //   }
    // }
  }
}
</style>
