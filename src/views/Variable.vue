<template lang="pug">
.variable
  .aside
    ul.list
      li.item(v-for="variableName in $store.getters.variableNaems") {{ variableName }}
  .main
    .variable(v-for="(values, variableName) in $store.state.variables")
      h1 {{ variableName }}
      ul.list
        li.item(v-for="value in values") {{ value }}
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.variable {
  display: grid;
  grid-template-rows: 1fr;
  grid-template-columns: 20rem 1fr;

  > .aside {
    grid-row: 1;
    grid-column: 1;
  }

  > .main {
    grid-row: 1;
    grid-column: 2;

    > .variable {
      display: block;
    }
  }
}
</style>
