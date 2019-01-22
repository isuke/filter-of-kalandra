<template lang="pug">
aside.variable-aside
  h1.title Variable Names
  ul.list
    li.item(
      v-for="(variableName, i) in $store.getters.variableNaems"
    ) {{ variableName }}
      //- input(type="text", v-model="$store.state.variables[i].name")
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
  }

  > .list {
    position: sticky;
    top: $global-header-height;
    max-height: 90vh; // TODO
    overflow-y: scroll;
    z-index: $codemirror-z-index + 10;

    > .item {
      cursor: pointer;
      text-decoration: underline;
      margin-top:    var(--space-size-s);
      margin-bottom: var(--space-size-s);
    }
  }
}
</style>
