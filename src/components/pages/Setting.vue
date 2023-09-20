<template>
  <main class="setting">
    <form class="form">
      <!-- <label class="label" :for="`appversion-${uid}`">App Version </label> -->
      <!-- <input class="input" type="text" v-model="store.state.filterInfo.appVersion" :id="`appversion-${uid}`" readOnly="readOnly" /> -->
      <label class="label" :for="`filter-name-${uid}`">Filter Name</label>
      <input class="input text" type="text" v-model="store.state.filterInfo.name" :id="`filter-name-${uid}`" />
      <label class="label" :for="`filter-name-${uid}`">Filter Name</label>
      <input class="input text" type="text" v-model="store.state.filterInfo.name" :id="`filter-name-${uid}`" />
      <label class="label" :for="`version-${uid}`">Filter Version</label>
      <input class="input text" type="text" v-model="store.state.filterInfo.version" :id="`version-${uid}`" />
      <label class="label" :for="`add-disable-drop-sound-to-hide-block-${uid}`">Add DisableDropSound to Hide Block (default: true)</label>
      <input
        class="input checkbox"
        type="checkbox"
        v-model="store.state.options.addDisableDropSoundToHideBlock"
        :id="`add-disable-drop-sound-to-hide-block-${uid}`"
      />
      <label class="icon" :for="`add-disable-drop-sound-to-hide-block-${uid}`" />
      <label class="label" :for="`convert-play-alert-sound-${uid}`">Convert PlayAlertSoundPositional to PlayAlertSound (default: false)</label>
      <input
        class="input checkbox"
        type="checkbox"
        v-model="store.state.options.convertPlayAlertSoundPositionalToPlayAlertSound"
        :id="`convert-play-alert-sound-${uid}`"
      />
      <label class="icon" :for="`convert-play-alert-sound-${uid}`" />
      <label class="label" :for="`remove-custom-alert-sound-${uid}`">Remove CustomAlertSound (default: false)</label>
      <input class="input checkbox" type="checkbox" v-model="store.state.options.removeCustomAlertSound" :id="`remove-custom-alert-sound-${uid}`" />
      <label class="icon" :for="`remove-custom-alert-sound-${uid}`" />
      <label class="label" :for="`default-alert-sound-volume-${uid}`">defaultAlertSoundVolume (default: 150)</label>
      <input
        class="input text"
        type="number"
        min="0"
        max="300"
        v-model.number="store.state.options.defaultAlertSoundVolume"
        :id="`default-alert-sound-volume-${uid}`"
      />
      <label class="label" :for="`default-alert-sound-positional-volume-${uid}`">defaultAlertSoundPositionalVolume (default: 150)</label>
      <input
        class="input text"
        type="number"
        min="0"
        max="300"
        v-model.number="store.state.options.defaultAlertSoundPositionalVolume"
        :id="`default-alert-sound-positional-volume-${uid}`"
      />
      <label class="label" :for="`initial-font-size-${uid}`">Initial FontSize (default: 32)</label>
      <input class="input text" type="number" min="18" max="42" v-model.number="store.state.options.initialFontSize" :id="`initial-font-size-${uid}`" />
    </form>
  </main>
</template>

<script lang="ts" setup>
import { getCurrentInstance } from "vue"
import { useStore } from "vuex"

const store = useStore()

const uid = getCurrentInstance()?.uid
</script>

<style lang="scss" scoped>
.setting {
  padding: var(--space-size-s);

  > .form {
    display: grid;
    grid-template-columns: max-content 1fr;
    grid-gap: var(--space-size-m);
    align-items: center;

    > .label {
      grid-column: 1;
      padding: var(--space-size-m);
    }

    > .input {
      grid-column: 2;
      padding: var(--space-size-m);

      &.text {
        @include text-input;
      }

      &.checkbox {
        @include checkbox;
      }
    }
  }
}
</style>
