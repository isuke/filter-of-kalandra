<template lang="pug">
aside.variable-aside
  h1.title Variable Names
  ul.list
    li.item(
      v-for="(variableName, i) in $store.getters.variableNaems",
      @click="$emit('click-variable-name', variableName)"
    ) {{ variableName }}
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.variable-aside {
  padding-top:    var(--space-size-s);
  padding-bottom: var(--space-size-s);
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);

  @include bg-ft-color($variable-color-hue, "night");

  > .title {
    font-size: var(--ft-size-l);
  }

  > .list {
    position: sticky;
    top: $global-header-height;
    max-height: calc(100vh - #{$global-header-height} - #{$sub-header-height});
    overflow-y: scroll;
    @include bg-ft-color($variable-color-hue, "night");

    @include hide-scrollbar();

    > .item {
      cursor: pointer;
      text-decoration: underline;
      margin-top:    var(--space-size-s);
      margin-bottom: var(--space-size-s);
    }
  }
}
</style>
