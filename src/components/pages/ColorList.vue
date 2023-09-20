<template>
  <ul class="color-list">
    <li class="color" v-for="(color, i) in store.state.colors" :key="i" :id="color.name">
      <input class="name" type="text" v-model="color.name" />
      <button class="button delete" @click="store.commit('removeColor', { index: i })">×</button>
      <input class="input" type="color" v-model.lazy="color.hex" />
      <color-list-item class="detail" :name="color.name" :hex="color.hex" />
    </li>
  </ul>
</template>

<script lang="ts" setup>
import { useStore } from "vuex"

import ColorListItem from "@/pages/ColorListItem.vue"

const store = useStore()
</script>

<style lang="scss" scoped>
.color-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
  grid-auto-rows: max-content;
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);
  padding-top: 0;

  > .color {
    display: grid;
    grid-template-rows: auto auto 1fr;
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

    > .input {
      grid-row: 2;
      grid-column: 1 / -1;
    }

    > .detail {
      grid-row: 3;
      grid-column: 1 / -1;
    }
  }
}
</style>
