<template lang="pug">
.variable
  .aside
    ul.list
      li.item(v-for="(variableName, i) in $store.getters.variableNaems")
        input(type="text", v-model="$store.state.variables[i].name")
  .main
    .variable(v-for="(variable, i) in $store.state.variables")
      input.name(type="text", v-model="$store.state.variables[i].name")
      ul.list
        li.item(v-for="(item, j) in variable.items")
          input(type="text", v-model="$store.state.variables[i].items[j]")
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

      > .name {
        font-size: 1.5rem;
      }
    }
  }
}
</style>
