<template lang="pug">
main.setting
  form.form
    label.label.filtername(:for="`filtername-${_uid}`") Filter Name
    input.input(type="text", v-model="$store.state.filterName", :id="`filtername-${_uid}`")
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.setting {
  padding: var(--space-size-s);

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .form {
    display: grid;
    grid-template-columns: max-content 1fr;

    > .label {
      grid-column: 1;
      padding: var(--space-size-m);
    }
    > .input {
      grid-column: 2;
      padding: var(--space-size-m);

      @include text-input();
    }
  }
}
</style>
