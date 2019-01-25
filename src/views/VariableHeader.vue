<template lang="pug">
.valiable-header
  .actions
    button.button(@click.prevent="$store.commit('addVariable')") Add New Variable
    button.button() Import Default Variables
    button.button() Import Json
    button.button() Export
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.valiable-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($variable-color-hue, "night");

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill($variable-color-hue);
      margin-right: var(--space-size-s);
    }
  }
}
</style>
