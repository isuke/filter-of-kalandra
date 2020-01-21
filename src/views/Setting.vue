<template lang="pug">
main.setting
  form.form
    //- label.label(:for="`appversion-${_uid}`") App Version
    //- input.input(type="text", v-model="$store.state.filterInfo.appVersion", :id="`appversion-${_uid}`", readOnly)

    label.label(:for="`filtername-${_uid}`") Filter Name
    input.input.text(type="text", v-model="$store.state.filterInfo.name", :id="`filtername-${_uid}`")

    label.label(:for="`version-${_uid}`") Filter Version
    input.input.text(type="text", v-model="$store.state.filterInfo.version", :id="`version-${_uid}`")

    label.label(:for="`adddisabledropsoundtohideblock-${_uid}`") Add DisableDropSound to Hide Block (default: true)
    input.input.checkbox(type="checkbox", v-model="$store.state.options.addDisableDropSoundToHideBlock", :id="`adddisabledropsoundtohideblock-${_uid}`")
    label.icon(:for="`adddisabledropsoundtohideblock-${_uid}`")

    label.label(:for="`convertplayalertsound-${_uid}`") Convert PlayAlertSoundPositional to PlayAlertSound (default: false)
    input.input.checkbox(type="checkbox", v-model="$store.state.options.convertPlayAlertSoundPositionalToPlayAlertSound", :id="`convertplayalertsound-${_uid}`")
    label.icon(:for="`convertplayalertsound-${_uid}`")

    label.label(:for="`removecustomalertsound-${_uid}`") Remove CustomAlertSound (default: false)
    input.input.checkbox(type="checkbox", v-model="$store.state.options.removeCustomAlertSound", :id="`removecustomalertsound-${_uid}`")
    label.icon(:for="`removecustomalertsound-${_uid}`")

    label.label(:for="`defaultalertsoundvolume-${_uid}`") defaultAlertSoundVolume (default: 150)
    input.input.text(type="number", min="0", max="300", v-model.number="$store.state.options.defaultAlertSoundVolume", :id="`defaultalertsoundvolume-${_uid}`")

    label.label(:for="`defaultalertsoundpositionalvolume-${_uid}`") defaultAlertSoundPositionalVolume (default: 150)
    input.input.text(type="number", min="0", max="300", v-model.number="$store.state.options.defaultAlertSoundPositionalVolume", :id="`defaultalertsoundpositionalvolume-${_uid}`")

    label.label(:for="`initialfontsize-${_uid}`") Initial FontSize (default: 32)
    input.input.text(type="number", min="18", max="42", v-model.number="$store.state.options.initialFontSize", :id="`initialfontsize-${_uid}`")
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.setting {
  padding: var(--space-size-s);

  > .form {
    display: grid;
    align-items: center;
    grid-template-columns: max-content 1fr;
    grid-gap: var(--space-size-m);

    > .label {
      grid-column: 1;
      padding: var(--space-size-m);
    }
    > .input {
      grid-column: 2;
      padding: var(--space-size-m);

      &.text { @include text-input(); }
      &.checkbox { @include checkbox(); }
    }
  }
}
</style>
