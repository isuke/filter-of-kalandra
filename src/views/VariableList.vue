<template lang="pug">
ul.variable-list
  li.variable(v-for="(variable, i) in $store.state.variables", :key="i", :id="variable.name")
    input.name(type="text", v-model="$store.state.variables[i].name")
    button.button.delete(@click="$store.commit('removeVariable', { index: i })") ×
    ul.list
      li.item(v-for="(item, j) in variable.items", :key="j")
        button.button.delete(@click="$store.commit('removeItemFromVariable', { index: i , itemIndex: j})") ×
        input.input(type="text", v-model="$store.state.variables[i].items[j]")
    button.newbutton(@click.prevent="$store.commit('addItemToVariable', { index: i })") Add New Item
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.variable-list {
  display: grid;
  grid-auto-rows: max-content;
  grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .variable {
    display: grid;
    grid-template-rows: auto 1fr auto;
    grid-template-columns: 1fr 2rem;
    gap: var(--space-size-s);

    @include card();
    @include bg-ft-color($variable-color-hue, "day");

    > .name {
      grid-row: 1;
      grid-column: 1;
      font-size: var(--ft-size-l);

      @include text-input();
    }

    > .button {
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

        > .button {
          margin-right: var(--space-size-xs);
        }

        > .input {
          flex: 1;

          @include text-input();
        }
      }
    }

    > .newbutton {
      grid-row: 3;
      grid-column: 1 / -1;

      @include button-fill($variable-color-hue);
    }
  }
}
</style>
