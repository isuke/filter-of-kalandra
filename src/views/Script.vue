<template lang="pug">
.script
  script-header.header
  .aside
    ul.sectionlist
      li.item(v-for="sectionName in $store.getters.sectionNames") {{ sectionName }}
  .main
    keep-alive
      router-view
</template>

<script lang="coffee">
import ScriptHeader from "@/views/ScriptHeader"

export default
  components:
    "script-header": ScriptHeader
</script>

<style lang="scss" scoped>
.script {
  display: grid;
  grid-template-rows: 2rem 1fr;
  grid-template-columns: 10rem 1fr;

  > .header {
    grid-row: 1;
    grid-column: 1 / -1;
  }

  > .aside {
    grid-row: 2;
    grid-column: 1;
  }

  > .main {
    grid-row: 2;
    grid-column: 2;
  }
}
</style>
