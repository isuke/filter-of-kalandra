<template lang="pug">
.variable-header
  .actions
    button.button.new(@click.prevent="$store.commit('addVariable')") Add New Variable
    button.button.removeall(@click.prevent="$refs.removeAllModal.open()") Remove All
    button.button.importdefault(@click.prevent="$refs.importDefaultModal.open()") Import Default Variables
    button.button.importjson(@click.prevent="$refs.importJSONModal.open()") Import JSON
    button.button.export(@click.prevent="$store.dispatch('exportVariables')") Export

  simple-modal.modal.removeall(
    ref="removeAllModal",
    headerStr="Remove All Variables",
    execStr="Remove All",
    @exec="removeAll"
  )
    template(v-slot:content)
      p.text Are you sure?

  simple-modal.modal.importdefault(
    ref="importDefaultModal",
    headerStr="Import Default Variables",
    execStr="Import",
    @exec="importDefault"
  )
    template(v-slot:content)
      label.label
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | Overwrite if exists same name variable.

  simple-modal.modal.importjson(
    ref="importJSONModal",
    headerStr="Import JSON",
    execStr="Import",
    @exec="importJSON"
  )
    template(v-slot:content)
      label.label
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | Overwrite if exists same name variable.
      input.file(type="file", accept=".json", @change="changeJSONFile")
</template>

<script lang="coffee">
import SimpleModal from "@/components/SimpleModal.vue"

export default
  data: ->
    canOverwrite: false
    jsonFile: undefined
  components:
    "simple-modal": SimpleModal
  methods:
    removeAll: ->
      @$store.commit('setVariables', { variables: [] })
      @$refs.removeAllModal.close('execed')
    changeJSONFile: (event) -> @jsonFile = event.target.files[0]
    importDefault: ->
      await @$store.dispatch('importDefaultVariables', { canOverwrite: @canOverwrite })
      @$refs.importDefaultModal.close('execed')
      @$store.dispatch "toasterStore/add", message: "completed to import"
    importJSON: ->
      await @$store.dispatch('importVariablesFromJSONFile', { canOverwrite: @canOverwrite, file: @jsonFile })
      @$refs.importJSONModal.close('execed')
      @$store.dispatch "toasterStore/add", message: "completed to import"
</script>

<style lang="scss" scoped>
.variable-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  background-color: $day-bg-color;
  color: $day-ft-color;

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill();
      margin-right: var(--space-size-s);

      &.removeall {
        &::after { content: " ..."; }
      }
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
  ::v-deep .content {
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
