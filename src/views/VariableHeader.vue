<template lang="pug">
.valiable-header
  .actions
    button.button(@click.prevent="$store.commit('addVariable')") Add New Variable
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.valiable-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  background-color: $variable-bg-color-light;
  padding-left: var(--space-size-s);

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button($color-hue: $variable-color-hue);
    }
  }
}
</style>
