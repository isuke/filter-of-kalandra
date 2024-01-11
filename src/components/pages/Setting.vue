<template>
  <main class="setting">
    <form class="form">
      <!-- <label class="label" :for="`appVersion-${uid}`">App Version </label> -->
      <!-- <input class="input" type="text" v-model="store.state.filterInfo.appVersion" :id="`appVersion-${uid}`" readOnly="readOnly" /> -->

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
