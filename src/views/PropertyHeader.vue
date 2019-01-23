<template lang="pug">
.property-header
  .actions
    button.button.importjson() Import Json
    button.button.export() Export
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.property-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($property-color-hue);

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button($color-hue: $property-color-hue);
      margin-right: var(--space-size-s);
    }
  }
}
</style>
