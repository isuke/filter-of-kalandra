<template lang="pug">
.script
  .head
    router-link(to="/script/editor") Editor
    | |
    router-link(to="/script/preview") Preview
    | |
    router-link(to="/script/text") Text
  .aside
    ul.sectionlist
      li.item(v-for="sectionName in $store.getters.sectionNames") {{ sectionName }}
  .main
    router-view
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.script {
  display: grid;
  grid-template-rows: 2rem 1fr;
  grid-template-columns: 10rem 1fr;
  margin: 1rem;

  > .head {
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
