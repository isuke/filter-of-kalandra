<template lang="pug">
main.script
  script-header.header

  script-adide.aside

  keep-alive
    router-view.main
</template>

<script lang="coffee">
import ScriptHeader from "@/views/ScriptHeader"
import ScriptAside from "@/views/ScriptAside"

export default
  components:
    "script-header": ScriptHeader
    "script-adide": ScriptAside
</script>

<style lang="scss" scoped>
.script {
  display: grid;
  grid-template-rows: 2rem 1fr;
  grid-template-columns: $aside-size-width 1fr;

  > .header {
    grid-row: 1;
    grid-column: 2;
    position: sticky;
    top: $global-header-height;
    background-color: $bg-color-light;
    z-index: $codemirror-z-index + 10;
  }

  > .aside {
    grid-row: 1 / -1;
    grid-column: 1;
    background-color: $bg-color-light;
  }

  > .main {
    grid-row: 2;
    grid-column: 2;
  }
}
</style>
