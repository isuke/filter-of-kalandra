<template lang="pug">
aside.script-aside
  h1.title Section Names
  ul.list
    li.item(
      v-for="(sectionName, i) in $store.getters.sectionNames",
      :key="i",
      @click="$emit('click-section-name', sectionName)"
    ) {{ sectionName }}
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.script-aside {
  padding-top:    var(--space-size-s);
  padding-bottom: var(--space-size-s);
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);

  @include bg-ft-color($script-color-hue, "night");

  > .title {
    font-size: var(--ft-size-l);
  }

  > .list {
    position: sticky;
    top: $global-fixed-height;
    max-height: calc(100vh - #{$global-fixed-height} - #{$sub-header-height});
    overflow-y: scroll;

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
