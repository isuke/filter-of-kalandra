<template lang="pug">
.color-header
  .actions
    button.button.new(@click.prevent="$store.commit('addColor')") Add New Color
    button.button.importdefault() Import Default Colors
    button.button.importjson() Import Json
    button.button.export() Export
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.color-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($color-color-hue, "night");

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill($color-color-hue);
      margin-right: var(--space-size-s);
    }
  }
}
</style>
