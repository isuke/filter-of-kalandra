<template lang="pug">
.variable-header
  .actions
    button.button.new(@click.prevent="$store.commit('addVariable')") Add New Variable
    button.button.importdefault(@click.prevent="$refs.importDefaultModal.open()") Import Default Variables
    button.button.importjson() Import JSON
    button.button.export(@click.prevent="$store.dispatch('exportVariables')") Export

  simple-modal.modal.importdefault(
    ref="importDefaultModal",
    headerStr="Import Default Variables",
    execStr="Import",
    @exec="importDefault"
  )
    .content(slot="content")
      label.label
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | Overwrite if exists same name variable.
</template>

<script lang="coffee">
import SimpleModal from "@/components/SimpleModal.vue"

export default
  data: ->
    canOverwrite: false
  components:
    "simple-modal": SimpleModal
  methods:
    importDefault: ->
      await @$store.dispatch('importDefaultVariables', { canOverwrite: @canOverwrite })
      @$refs.importDefaultModal.close('execed')
</script>

<style lang="scss" scoped>
.variable-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($variable-color-hue, "night");

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill($variable-color-hue);
      margin-right: var(--space-size-s);

      &.importdefault {
        &::after { content: " ..."; }
      }
      &.importjson {
        &::after { content: " ..."; }
      }
    }
  }
}

.variable-header > .modal {
  > .content {
    display: flex;
    flex-direction: column;

    > .label {
      > .checkbox {
        margin-right: 1em;
      }
    }

    > .file {
      margin-top: var(--space-size-m);
    }
  }
}
</style>
