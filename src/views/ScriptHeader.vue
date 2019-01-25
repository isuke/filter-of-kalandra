<template lang="pug">
.script-header
  nav.nav
    ul.list
      router-link.item(tag="li", to="/script/editor") Editor
      router-link.item(tag="li", to="/script/preview") Preview
      router-link.item(tag="li", to="/script/text") Text
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.script-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-xl);

  @include bg-ft-color($script-color-hue, "night");

  > .nav {
    flex: 1;
    display: inline-flex;
    align-items: stretch;

    > .list {
      flex: 1;
      display: inline-flex;
      align-items: stretch;

      > .item {
        flex: 1;
        display: inline-flex;
        align-items: center;
        text-decoration-line: underline;
        cursor: pointer;

        &.-current {
          color: _ft-color($script-color-hue, "night", true);
        }
      }
    }
  }
}
</style>
