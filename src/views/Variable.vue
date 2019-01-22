<template lang="pug">
main.variable
  variable-aside.aside
  .main
    .variable(v-for="(variable, i) in $store.state.variables")
      input.name(type="text", v-model="$store.state.variables[i].name")
      ul.list
        li.item(v-for="(item, j) in variable.items")
          input(type="text", v-model="$store.state.variables[i].items[j]")
      button(@click.prevent="$store.commit('addItemToVariable', { index: i })") Add New Item

    button(@click.prevent="$store.commit('addVariable')") Add New Variable
</template>

<script lang="coffee">
import VariableAside from "@/views/VariableAside.vue"

export default
  components:
    "variable-aside": VariableAside
</script>

<style lang="scss" scoped>
.variable {
  display: grid;
  grid-template-rows: 1fr;
  grid-template-columns: 20rem 1fr;

  > .aside {
    grid-row: 1;
    grid-column: 1;
    background-color: hsl(20,  80%,  20%); // TODO
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
