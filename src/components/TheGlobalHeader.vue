<template lang="pug">
header.the-global-header
  router-link.item.logo(tag="h1", to="/", exact) Filter of Kalandra
  nav.nav
    ul.list
      router-link.item.script(tag="li", to="/script") Script
      router-link.item.variable(tag="li", to="/variable") Variable
      router-link.item.color(tag="li", to="/color") Color
      router-link.item.property(tag="li", to="/property") Property
      router-link.item.setting(tag="li", to="/setting") Setting
  .actions
    button.button Import
    button.button Export
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
  background-color: $global-bg-color-night;
  color: $global-ft-color-night;

  .logo {
    align-self: center;
    padding-top:    var(--space-size-s);
    padding-bottom: var(--space-size-s);
    padding-right:  var(--space-size-l);
    font-size: var(--ft-size-l);
    cursor: pointer;

    &::after {
      content: "(α)";
      font-style: italic;
      font-size: var(--ft-size-m);
    }
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
        justify-content: center;
        @ghost padding-left-right(var(--space-size-m));
        padding-bottom: var(--space-size-xs);
        @ghost border-top-radius(#{$border-radius-base});
        margin-top: var(--space-size-xs);
        cursor: pointer;

        &.script.-current   { @include bg-ft-color($script-color-hue  , "night"); }
        &.variable.-current { @include bg-ft-color($variable-color-hue, "night"); }
        &.color.-current    { @include bg-ft-color($color-color-hue   , "night"); }
        &.property.-current { @include bg-ft-color($property-color-hue, "night"); }
        &.setting.-current {
          background-color: $global-bg-color-day;
          color: $global-ft-color-day
        }
      }
    }
  }

  > .actions {
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-skelton($global-accent-color-hue, "night");
      margin-left: var(--space-size-m);
    }
  }
}
</style>
