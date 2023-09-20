<template>
  <div class="property-header">
    <div class="actions">
      <button class="button importjson" @click.prevent="importJsonModalElement?.open()">Import Json</button>
      <button class="button export" @click.prevent="store.dispatch('ioStore/exportProperties')">Export</button>
    </div>
    <simple-modal
      class="modal importjson"
      ref="importJsonModalElement"
      headerStr="Import Json"
      execStr="Import"
      @exec="importJson"
      :canExec="!!jsonFile && canOverwrite"
    >
      <template v-slot:content>
        <label class="label -attention">
          <input class="checkbox" type="checkbox" v-model="canOverwrite" />All exists property are removed when import Json !
        </label>
        <input class="file" type="file" accept=".json" @change="changeJsonFile" />
      </template>
    </simple-modal>
  </div>
</template>

<script lang="ts" setup>
import { ref } from "vue"
import { useStore } from "vuex"

const store = useStore()

import SimpleModal from "@/commons/SimpleModal.vue"

const importJsonModalElement = ref<InstanceType<typeof SimpleModal>>()

const canOverwrite = ref<boolean>(false)
const jsonFile = ref<File | null | undefined>(undefined)

const changeJsonFile = (event: { target: HTMLInputElement }) => {
  jsonFile.value = event.target?.files?.item(0)
}

const importJson = async () => {
  if (!jsonFile.value) return

  await store.dispatch("ioStore/importPropertiesFromJsonFile", { file: jsonFile.value })
  importJsonModalElement.value?.close("executed")
  store.dispatch("toasterStore/add", { message: "completed to import" })
  canOverwrite.value = false
}
</script>

<style lang="scss" scoped>
.property-header {
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

      &.importjson {
        &::after {
          content: " ...";
        }
      }
    }
  }
}

.property-header > .modal {
  ::v-deep(.content) {
    display: flex;
    flex-direction: column;

    > .label {
      &.-attention {
        color: $error-ft-color;
      }

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
