<template lang="pug">
aside.script-aside
  h1.title Section Names
  ul.list
    li.item(v-for="sectionName in $store.getters.sectionNames") {{ sectionName }}
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.script-aside {
  background-color: $bg-color-light;
  padding-top:    var(--space-size-s);
  padding-bottom: var(--space-size-s);
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);

  > .title {
    font-size: var(--ft-size-l);
  }

  > .list {
    position: sticky;
    top: 0;
    max-height: 90vh; // TODO
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
