<template>
  <div class="property-list">
    <table class="table">
      <thead class="head">
        <tr class="row">
          <th class="head">Property Name \ Script Name</th>
          <td class="data script-name" v-for="(_scriptNames, i) in store.getters.scriptNames" :key="i">
            <div class="wrapper">
              <input class="input" type="text" v-model="store.state.properties.scriptNames[i]" />
              <button class="delete" @click="store.commit('removeScriptFromProperties', { index: i })">×</button>
            </div>
          </td>
        </tr>
      </thead>
      <tbody class="body">
        <tr class="row" v-for="(_propName, j) in store.getters.propNames" :key="j">
          <td class="data prop-name">
            <div class="wrapper">
              <input class="input" type="text" v-model="store.state.properties.propNames[j]" />
              <button class="delete" @click="store.commit('removePropsFromProperties', { index: j })">×</button>
            </div>
          </td>
          <td class="data prop-val" v-for="(_scriptName, i) in store.getters.scriptNames" :key="i">
            <div class="wrapper">
              <input class="input" type="text" v-model="store.state.properties.values[i][j]" />
            </div>
          </td>
        </tr>
      </tbody>
    </table>
    <div class="new-prop">
      <button class="button" @click="store.commit('addPropsToProperties')">Add New Property</button>
    </div>
    <div class="new-script">
      <button class="button" @click="store.commit('addScriptToProperties')" :disabled="!store.getters.canAddScript">Add New Script</button>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { useStore } from "vuex"

const store = useStore()
</script>

<style lang="scss" scoped>
.property-list {
  display: grid;
  grid-template-rows: min-content 2rem;
  grid-template-columns: 1fr auto;
  gap: var(--space-size-s);
  padding: var(--space-size-s);
  padding-top: 0;
  overflow-x: scroll;

  > .table {
    grid-row: 1;
    grid-column: 1;

    > .head {
      color: $night-ft-color;
      background-color: $night-bg-color2;
      border-bottom: $border-height-extra-bold $day-night-border-color solid;

      > .row {
        > .head {
          padding: var(--space-size-s);
        }

        > .data {
          padding: var(--space-size-s);

          > .wrapper {
            display: inline-flex;
            width: 100%;

            > .input {
              flex: 1;

              @include text-input;
            }

            > .delete {
              margin: var(--space-size-xs);
            }
          }
        }
      }
    }

    > .body {
      > .row {
        &:nth-child(even) {
          background-color: $day-bg-color-darken;
        }

        > .data {
          padding: var(--space-size-s);

          &.prop-name {
            min-width: 20rem;
          }

          &.prop-val {
            min-width: 10rem;
          }

          > .wrapper {
            display: inline-flex;
            width: 100%;

            > .input {
              flex: 1;

              @include text-input;
            }

            > .delete {
              margin: var(--space-size-xs);
            }
          }
        }
      }
    }
  }

  > .new-prop {
    grid-row: 2;
    grid-column: 1;

    > .button {
      width: 100%;

      @include button-fill;
    }
  }

  > .new-script {
    grid-row: 1;
    grid-column: 2;

    > .button {
      height: 100%;

      @include button-fill;
    }
  }
}
</style>
