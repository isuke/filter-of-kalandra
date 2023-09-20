<template>
  <ul class="variable-list">
    <li class="variable" v-for="(variable, i) in store.state.variables" :key="i" :id="variable.name">
      <input class="name" type="text" v-model="store.state.variables[i].name" />
      <button class="button delete" @click="store.commit('removeVariable', { index: i })">×</button>
      <ul class="list">
        <li class="item" v-for="(_item, j) in variable.items" :key="j">
          <button class="button delete" @click="store.commit('removeItemFromVariable', { index: i, itemIndex: j })">×</button>
          <input class="input" type="text" v-model="store.state.variables[i].items[j]" />
        </li>
      </ul>
      <button class="new-button" @click.prevent="store.commit('addItemToVariable', { index: i })">Add New Item</button>
    </li>
  </ul>
</template>

<script lang="ts" setup>
import { useStore } from "vuex"

const store = useStore()
</script>

<style lang="scss" scoped>
.variable-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
  grid-auto-rows: max-content;
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);
  padding-top: 0;

  > .variable {
    display: grid;
    grid-template-rows: auto 1fr auto;
    grid-template-columns: 1fr 2rem;
    gap: var(--space-size-s);
    color: $night-ft-color;
    background-color: $night-bg-color2;

    @include card;

    > .name {
      grid-row: 1;
      grid-column: 1;
      font-size: var(--ft-size-l);

      @include text-input;
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

          @include text-input;
        }
      }
    }

    > .new-button {
      grid-row: 3;
      grid-column: 1 / -1;

      @include button-fill;
    }
  }
}
</style>
