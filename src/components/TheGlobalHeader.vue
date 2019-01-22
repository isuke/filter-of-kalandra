<template lang="pug">
header.the-global-header
  h1.logo Filter of Kalandra
  nav.nav
    ul.list
      router-link.item(tag="li", to="/", exact) Home
      router-link.item(tag="li", to="/script") Script
      router-link.item(tag="li", to="/variable") Variable
      router-link.item(tag="li", to="/color") Color
      router-link.item(tag="li", to="/property") Property
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.the-global-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);
  border-bottom: $base-border-height solid $home-ft-color-base;

  .logo {
    padding-top:    var(--space-size-s);
    padding-bottom: var(--space-size-s);
    padding-right:  var(--space-size-l);
    font-size: var(--ft-size-l);
  }

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
        margin: var(--space-size-xs);
        text-decoration-line: underline;
        cursor: pointer;

        &.-current {
          color: $home-ft-color-accent;
          font-weight: $bold-font-weight;
        }
      }
    }
  }
}
</style>
