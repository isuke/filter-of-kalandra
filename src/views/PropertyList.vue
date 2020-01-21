<template lang="pug">
.property-list
  table.table
    thead.head
      tr.row
        th.head Property Name \ Script Name
        td.data.scriptname(v-for="(scriptNames, i) in $store.getters.scriptNames", :key="i")
          .wrapper
            input.input(type="text", v-model="$store.state.properties.scriptNames[i]")
            button.delete(@click="$store.commit('removeScriptFromProperties', { index: i })") ×
    tbody.body
      tr.row(v-for="(propName, j) in $store.getters.propNames", :key="j")
        td.data.propname
          .wrapper
            input.input(type="text", v-model="$store.state.properties.propNames[j]")
            button.delete(@click="$store.commit('removePropsFromProperties', { index: j })") ×
        td.data.propval(v-for="(scriptName, i) in $store.getters.scriptNames", :key="i")
          .wrapper
            input.input(type="text", v-model="$store.state.properties.values[i][j]")

  .newprop
    button.button(@click="$store.commit('addPropsToProperties')") Add New Property

  .newscript
    button.button(@click="$store.commit('addScriptToProperties')", :disabled="! $store.getters.canAddScript") Add New Script
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
  padding-top: 0;
  gap: var(--space-size-s);

  overflow-x: scroll;

  > .table {
    grid-row: 1;
    grid-column: 1;

    > .head {
      background-color: $night-bg-color2;
      color: $night-ft-color;
      border-bottom: $border-height-extra-bold $day-night-border-color solid;

      > .row {
        > .head { padding: var(--space-size-s); }
        > .data {
          padding: var(--space-size-s);

          > .wrapper {
            display: inline-flex;
            width: 100%;

            > .input {
              flex: 1;
              @include text-input();
            }
            > .delete { margin: var(--space-size-xs); }
          }
        }
      }
    }
    > .body {
      > .row {
        &:nth-child(even) { background-color: darken($day-bg-color, 10%); }

        > .data {
          padding: var(--space-size-s);

          &.propname { min-width: 20rem; }
          &.propval  { min-width: 10rem; }

          > .wrapper {
            display: inline-flex;
            width: 100%;

            > .input {
              flex: 1;
              @include text-input();
            }
            > .delete { margin: var(--space-size-xs); }
          }
        }
      }
    }
  }

  > .newprop {
    grid-row: 2;
    grid-column: 1;

    > .button {
      width: 100%;
      @include button-fill();
    }
  }

  > .newscript {
    grid-row: 1;
    grid-column: 2;

    > .button {
      height: 100%;
      @include button-fill();
    }
  }
}
</style>
