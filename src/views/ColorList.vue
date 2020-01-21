<template lang="pug">
ul.color-list
  li.color(
    v-for="(color, i) in $store.state.colors",
    :key="i",
    :id="color.name"
  )
    input.name(type="text", v-model="color.name")
    button.button.delete(@click="$store.commit('removeColor', { index: i })") ×
    input.input(type="color", v-model.lazy="color.hex")
    color-list-item.detail(
      :name="color.name",
      :hex="color.hex",
    )

</template>

<script lang="coffee">
import ColorListItem from "@/views/ColorListItem"

export default
  components:
    "color-list-item": ColorListItem
</script>

<style lang="scss" scoped>
.color-list {
  display: grid;
  grid-auto-rows: max-content;
  grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);
  padding-top: 0;

  > .color {
    display: grid;
    gap: var(--space-size-s);
    grid-template-rows: auto auto 1fr;
    grid-template-columns: 1fr 2rem;

    background-color: $night-bg-color2;
    color: $night-ft-color;

    @include card();

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
