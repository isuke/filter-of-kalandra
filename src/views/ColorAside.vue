<template lang="pug">
aside.color-aside
  h1.title Color Names
  ul.list
    li.item(
      v-for="color in $store.state.colors",
      @click=""
    ) {{ color.name }}
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.color-aside {
  padding-top:    var(--space-size-s);
  padding-bottom: var(--space-size-s);
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);

  @include bg-ft-color($color-color-hue);

  > .title {
    font-size: var(--ft-size-l);
  }

  > .list {
    position: sticky;
    top: $global-header-height;
    max-height: calc(100vh - #{$global-header-height} - #{$sub-header-height});
    overflow-y: scroll;

    > .item {
      cursor: pointer;
      text-decoration: underline;
      margin-top:    var(--space-size-s);
      margin-bottom: var(--space-size-s);
    }
  }
}
</style>
