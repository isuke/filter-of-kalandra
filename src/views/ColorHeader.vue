<template lang="pug">
.color-header
  .actions
    button.button.new(@click.prevent="$store.commit('addColor')") Add New Color
    button.button.importdefault(@click.prevent="$refs.importDefaultModal.open()") Import Default Colors
    button.button.importjson(@click.prevent="$refs.importJSONModal.open()") Import JSON
    button.button.export(@click.prevent="$store.dispatch('exportColors')") Export

  simple-modal.modal.importdefault(
    ref="importDefaultModal",
    headerStr="Import Default Colors",
    execStr="Import",
    @exec="importDefault"
  )
    .content(slot="content")
      label.label
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | Overwrite if exists same name color.

  simple-modal.modal.importjson(
    ref="importJSONModal",
    headerStr="Import JSON",
    execStr="Import",
    @exec="importJSON"
  )
    .content(slot="content")
      label.label
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | Overwrite if exists same name color.
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
    changeJSONFile: (event) -> @jsonFile = event.target.files[0]
    importDefault: ->
      await @$store.dispatch('importDefaultColors', { canOverwrite: @canOverwrite })
      @$refs.importDefaultModal.close('execed')
    importJSON: ->
      await @$store.dispatch('importColorsFromJSONFile', { canOverwrite: @canOverwrite, file: @jsonFile })
      @$refs.importJSONModal.close('execed')
</script>

<style lang="scss" scoped>
.color-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($color-color-hue, "night");

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill($color-color-hue);
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

.color-header > .modal {
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
