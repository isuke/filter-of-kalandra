<template lang="pug">
aside.variable-aside
  h1.title Variable Names
  ul.list
    li.item(
      v-for="(variableName, i) in $store.getters.variableNaems",
      :key="i",
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

  > .title {
    font-size: var(--ft-size-l);
    color: $day-ft-accent-color2;
  }

  > .list {
    position: sticky;
    top: $global-fixed-height;
    max-height: calc(100vh - #{$global-fixed-height} - #{$sub-header-height});
    overflow-y: scroll;

    @include hide-scrollbar();

    > .item {
      cursor: pointer;
      color: $day-ft-accent-color3;
      margin-top:    var(--space-size-s);
      margin-bottom: var(--space-size-s);
    }
  }
}
</style>
