<template lang="pug">
ul.variable-list
  li.variable(v-for="(variable, i) in $store.state.variables", :id="variable.name")
    input.name(type="text", v-model="$store.state.variables[i].name")
    button.deletebutton() ×
    ul.list
      li.item(v-for="(item, j) in variable.items")
        button.deletebutton() ×
        input.input(type="text", v-model="$store.state.variables[i].items[j]")
    button.newbutton(@click.prevent="$store.commit('addItemToVariable', { index: i })") Add New Item
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.variable-list {
  --grid-columns: 2; // TODO: media

  display: grid;
  grid-auto-rows: max-content;
  grid-template-columns: repeat(var(--grid-columns), 1fr);
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);

  background-color: hsl($variable-color-hue,  50%,  90%); // TODO

  > .variable {
    display: grid;
    grid-template-rows: auto 1fr auto;
    grid-template-columns: 1fr 2rem;

    @include card($variable-color-hue);

    transition: $duration-base all;

    > .name {
      grid-row: 1;
      grid-column: 1;
      font-size: var(--ft-size-l);
    }

    > .deletebutton {
      grid-row: 1;
      grid-column: 2;
      font-size: var(--ft-size-l);
    }

    > .list {
      grid-row: 2;
      grid-column: 1 / -1;

      > .item {
        display: inline-flex;
        align-items: center;
        width: 100%;

        > .deletebutton {}

        > .input {
          flex: 1;
        }

      }
    }

    > .newbutton {
      grid-row: 3;
      grid-column: 1 / -1;
    }
  }
}
</style>
