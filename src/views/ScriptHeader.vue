<template lang="pug">
.script-header
  nav.nav
    ul.list
      router-link.item(tag="li", to="/script/editor"): .title Editor
      router-link.item(tag="li", to="/script/preview"): .title  Preview
      router-link.item(tag="li", to="/script/text"): .title  Text
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

  background-color: $day-bg-color;
  color: $day-ft-color;

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

        cursor: pointer;

        > .title {
          color: $day-ft-accent-color3;
          font-weight: $bold-font-weight;
          border-bottom-width: $border-height-bold;
          border-bottom-style: solid;
          border-color: $day-bg-color;
        }

        &.-current > .title {
          color: $day-ft-accent-color1;
          border-color: $day-ft-accent-color1;
        }
      }
    }
  }
}
</style>
