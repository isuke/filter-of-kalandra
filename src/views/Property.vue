<template lang="pug">
.property
  table.table
    thead.head
      tr.row
        th.head Property Name \ Script Name
        td.scriptname(v-for="(scriptNames, i) in $store.getters.scriptNames")
          input(type="text", v-model="$store.state.properties.scriptNames[i]")
    tbody
      tr.row(v-for="(propName, j) in $store.getters.propNames")
        th.propname
          input(type="text", v-model="$store.state.properties.propNames[j]")
        td.propval(v-for="(scriptName, i) in $store.getters.scriptNames")
          input(type="text", v-model="$store.state.properties.values[i][j]")

  button.newprop(@click="$store.commit('addPropsToProperties')") Add New Property

  button.newscript(@click="$store.commit('addScriptToProperties')") Add New Script
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.property {
  display: grid;
  grid-template-rows: 1fr 2rem;
  grid-template-columns: 1fr 10rem;

  > .table {
    grid-row: 1;
    grid-column: 1;
  }

  > .newprop {
    grid-row: 2;
    grid-column: 1;
  }

  > .newscript {
    grid-row: 1;
    grid-column: 2;
  }
}
</style>
