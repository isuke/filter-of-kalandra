<template lang="pug">
.property-header
  .actions
    button.button.importjson(@click.prevent="$refs.importJSONModal.open()") Import JSON
    button.button.export(@click.prevent="$store.dispatch('exportProperties')") Export

  simple-modal.modal.importjson(
    ref="importJSONModal",
    headerStr="Import JSON",
    execStr="Import",
    :canExec="canOverwrite",
    @exec="importJSON"
  )
    template(v-slot:content)
      label.label.-attention
        input.checkbox(type="checkbox", v-model="canOverwrite")
        | All exists property are removed when import JSON !
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
    importJSON: ->
      await @$store.dispatch('importPropertiesFromJSONFile', { file: @jsonFile })
      @$refs.importJSONModal.close('execed')
      @canOverwrite = false
</script>

<style lang="scss" scoped>
.property-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);

  @include bg-ft-color($property-color-hue, "night");

  > .actions {
    flex: 1;
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill($property-color-hue);
      margin-right: var(--space-size-s);

      &.importjson {
        &::after { content: " ..."; }
      }
    }
  }
}

.property-header > .modal {
  /deep/ .content {
    display: flex;
    flex-direction: column;

    > .label {

      &.-attention {
        color: $error-ft-color;
      }

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
