<template>
  <div class="color-header">
    <div class="actions">
      <button class="button new" @click.prevent="store.commit('addColor')">Add New Color</button>
      <button class="button remove-all" @click.prevent="removeAllModalElement?.open()">Remove All</button>
      <button class="button import-default" @click.prevent="importDefaultModalElement?.open()">Import Default Colors</button>
      <button class="button import-json" @click.prevent="importJsonModalElement?.open()">Import JSON</button>
      <button class="button export" @click.prevent="store.dispatch('ioStore/exportColors')">Export</button>
    </div>
    <simple-modal class="modal remove-all" ref="removeAllModalElement" headerStr="Remove All Variables" execStr="Remove All" @exec="removeAll">
      <template v-slot:content>
        <p class="text">Are you sure?</p>
      </template>
    </simple-modal>
    <simple-modal class="modal import-default" ref="importDefaultModalElement" headerStr="Import Default Colors" execStr="Import" @exec="importDefault">
      <template v-slot:content>
        <label class="label"> <input class="checkbox" type="checkbox" v-model="canOverwrite" />Overwrite if exists same name color. </label>
      </template>
    </simple-modal>
    <simple-modal class="modal import-json" ref="importJsonModalElement" headerStr="Import JSON" execStr="Import" @exec="importJson" :canExec="!!jsonFile">
      <template v-slot:content>
        <label class="label"> <input class="checkbox" type="checkbox" v-model="canOverwrite" />Overwrite if exists same name color. </label>
        <input class="file" type="file" accept=".json" @change="changeJsonFile" />
      </template>
    </simple-modal>
  </div>
</template>

<script lang="ts" setup>
import { ref } from "vue"
import { useStore } from "vuex"

import SimpleModal from "@/commons/SimpleModal.vue"

const store = useStore()

const canOverwrite = ref<boolean>(false)
const jsonFile = ref<File | null | undefined>(undefined)

const removeAllModalElement = ref<InstanceType<typeof SimpleModal>>()
const importDefaultModalElement = ref<InstanceType<typeof SimpleModal>>()
const importJsonModalElement = ref<InstanceType<typeof SimpleModal>>()

const removeAll = () => {
  store.commit("setColors", { colors: [] })
  removeAllModalElement.value?.close("executed")
}

const changeJsonFile = (event: { target: HTMLInputElement }) => {
  jsonFile.value = event.target?.files?.item(0)
}
const importDefault = async () => {
  await store.dispatch("importDefaultColors", { canOverwrite: canOverwrite.value })
  importDefaultModalElement.value?.close("executed")
  store.dispatch("toasterStore/add", { message: "completed to import" })
}
const importJson = async () => {
  if (!jsonFile.value) return

  await store.dispatch("ioStore/importColorsFromJsonFile", { canOverwrite: canOverwrite.value, file: jsonFile.value })
  importJsonModalElement.value?.close("executed")
  store.dispatch("toasterStore/add", { message: "completed to import" })
}
</script>

<style lang="scss" scoped>
.color-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left: var(--space-size-s);
  color: $day-ft-color;
  background-color: $day-bg-color;

  > .actions {
    display: inline-flex;
    flex: 1;
    align-items: center;

    > .button {
      @include button-fill;

      margin-right: var(--space-size-s);

      &.remove-all {
        &::after {
          content: " ...";
        }
      }

      &.import-default {
        &::after {
          content: " ...";
        }
      }

      &.import-json {
        &::after {
          content: " ...";
        }
      }
    }
  }
}

.color-header > .modal {
  ::v-deep(.content) {
    display: flex;
    flex-direction: column;

    > .label {
      > .checkbox {
        margin-right: 1em;
        appearance: auto;
      }
    }

    > .file {
      margin-top: var(--space-size-m);
    }
  }
}
</style>
