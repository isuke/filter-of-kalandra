<template lang="pug">
.property-list
  table.table
    thead.head
      tr.row
        th.head Property Name \ Script Name
        td.data.scriptname(v-for="(scriptNames, i) in $store.getters.scriptNames")
          input(type="text", v-model="$store.state.properties.scriptNames[i]")
          button.delete() ×
    tbody.body
      tr.row(v-for="(propName, j) in $store.getters.propNames")
        td.data.propname
          input.input(type="text", v-model="$store.state.properties.propNames[j]")
          button.delete() ×
        td.data.propval(v-for="(scriptName, i) in $store.getters.scriptNames")
          input(type="text", v-model="$store.state.properties.values[i][j]")

  .newprop
    button.button(@click="$store.commit('addPropsToProperties')") Add New Property

  .newscript
    button.button(@click="$store.commit('addScriptToProperties')") Add New Script
</template>

<script lang="coffee">
import PropertyHeader from "@/views/PropertyHeader"

export default
  components:
    "property-header": PropertyHeader
</script>

<style lang="scss" scoped>
.property-list {
  display: grid;
  grid-template-rows: min-content 2rem;
  grid-template-columns: 1fr auto;
  padding: var(--space-size-s);
  gap: var(--space-size-s);

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .table {
    grid-row: 1;
    grid-column: 1;

    // border: $border-height-base hsl($property-color-hue, 100%, 40%) solid;

    > .head {
      border-bottom: $border-height-base _ft-color($property-color-hue, "day", true) solid;

      > .row {
        @include bg-ft-color($property-color-hue, "day", true);

        > .head { padding: var(--space-size-s); }
        > .data { padding: var(--space-size-s); }
      }
    }
    > .body {
      > .row {
        &:nth-child(odd)  { @include bg-ft-color($property-color-hue, "day", false); }
        &:nth-child(even) { @include bg-ft-color($property-color-hue, "day", true); }

        > .data { padding: var(--space-size-s); }
      }
    }
  }

  > .newprop {
    grid-row: 2;
    grid-column: 1;

    > .button { @include button-fill($property-color-hue); }
  }

  > .newscript {
    grid-row: 1;
    grid-column: 2;

    > .button { @include button-fill($property-color-hue); }
  }
}
</style>
