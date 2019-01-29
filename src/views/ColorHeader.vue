<template lang="pug">
.color-header
  .actions
    button.button.new(@click.prevent="$store.commit('addColor')") Add New Color
    button.button.importdefault(@click.prevent="$refs.importDefaultModal.open()") Import Default Colors
    button.button.importjson() Import Json
    button.button.export(@click.prevent="$store.dispatch('exportColors')") Export

  simple-modal.modal.importdefault(
    ref="importDefaultModal",
    headerStr="Import Default Colors",
    execStr="Import",
    @exec="importDefault"
  )
    .content(slot="content")
      label.label
        input.input(type="checkbox", v-model="canOverride")
        | Overwrite if exists same name color.
</template>

<script lang="coffee">
import SimpleModal from "@/components/SimpleModal.vue"

export default
  data: ->
    canOverride: false
  components:
    "simple-modal": SimpleModal
  methods:
    importDefault: ->
      await @$store.dispatch('importDefaultColors', { canOverride: @canOverride })
      @$refs.importDefaultModal.close('execed')
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
  &.importdefault {
    > .content {
      > .label {
        > .input {
          margin-right: 1em;
        }
      }
    }
  }
}
</style>
