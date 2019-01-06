<template lang="pug">
.property
  table.table
    thead.head
      tr.row
        th.head Property Name \ Script Name
        td.scriptname(v-for="scriptNames in $store.getters.scriptNames") {{ scriptNames }}
    tbody
      tr.row(v-for="propName in $store.getters.propNames")
        th.propname {{ propName }}
        td.propval(v-for="scriptName in $store.getters.scriptNames") {{ $store.state.properties[scriptName][propName] }}

  button.newprop(@click="$store.dispatch('addPropsToProperties')") Add New Property

  button.newscript(@click="$store.dispatch('addScriptToProperties')") Add New Script
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
