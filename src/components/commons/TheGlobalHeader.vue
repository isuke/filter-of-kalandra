<template>
  <header class="the-global-header">
    <router-link class="item logo" to="/" exact="exact">
      <h1 class="title">Filter of Kalandra</h1>
    </router-link>
    <nav class="nav">
      <ul class="list">
        <li class="item">
          <router-link class="link script" to="/script">Script</router-link>
        </li>
        <li class="item">
          <router-link class="link variable" to="/variable">Variable</router-link>
        </li>
        <li class="item">
          <router-link class="link color" to="/color">Color</router-link>
        </li>
        <li class="item">
          <router-link class="link property" to="/property">Property</router-link>
        </li>
        <li class="item">
          <router-link class="link setting" to="/setting">Setting</router-link>
        </li>
        <a class="item doc" href="https://filter-of-kalandra-doc.netlify.com/" target="_blank" rel="noopener noreferrer">Doc</a>
      </ul>
    </nav>
    <div class="actions">
      <button class="button import" @click.prevent="importAllModalElement?.open()">Import</button>
      <button class="button export" @click.prevent="exportAll">Export</button>
    </div>
    <simple-modal class="modal import" ref="importAllModalElement" headerStr="Import" execStr="Import" :canExec="canOverwrite" @exec="importAll">
      <template v-slot:content>
        <div class="group">
          <input class="checkbox" :id="`canOverwrite-${uid}`" type="checkbox" v-model="canOverwrite" />
          <label class="label -attention" :for="`canOverwrite-${uid}`">All exists data are removed when import JSON !</label>
        </div>
        <div class="group">
          <input class="radio" :id="`importType-dir-${uid}`" type="radio" :name="`importType-${uid}`" value="dir" v-model="importType" />
          <label class="label" :for="`importType-dir-${uid}`">Import Folder</label>
          <input class="radio" :id="`importType-zip-${uid}`" type="radio" :name="`importType-${uid}`" value="zip" v-model="importType" />
          <label class="label" :for="`importType-zip-${uid}`">Import Zip</label>
        </div>
        <div class="group">
          <input class="file" v-show="importType === 'dir'" type="file" @change="changeImportFileList" webkitdirectory="webkitdirectory" />
          <input class="file" v-show="importType === 'zip'" type="file" @change="changeImportZipFile" accept=".zip" />
        </div>
      </template>
    </simple-modal>
  </header>
</template>

<script lang="ts" setup>
import { ref, getCurrentInstance } from "vue"
import { useStore } from "vuex"

import SimpleModal from "@/commons/SimpleModal.vue"
import { eventGtag } from "@/composables/gtag"

const store = useStore()

const uid = getCurrentInstance()?.uid

const importAllModalElement = ref<InstanceType<typeof SimpleModal>>()

const canOverwrite = ref<boolean>(false)
const importType = ref<"dir" | "zip">("dir")
const importFileList = ref<FileList | null>(null)
const importZipFile = ref<File | null | undefined>(null)

const changeImportFileList = (event: Event) => {
  const target = event.target as HTMLInputElement
  importFileList.value = target.files
}

const changeImportZipFile = (event: Event) => {
  const target = event.target as HTMLInputElement
  importZipFile.value = target.files?.item(0)
}

const importAll = () => {
  eventGtag("import button", "click")

  if (importType.value === "dir") {
    store.dispatch("ioStore/importAllFromFileList", {
      fileList: importFileList.value,
      callback: () => store.dispatch("toasterStore/add", { message: "completed to import" }),
    })
  } else {
    store.dispatch("ioStore/importAllFromZip", {
      file: importZipFile.value,
      callback: () => store.dispatch("toasterStore/add", { message: "completed to import" }),
    })
  }

  importAllModalElement.value?.close("executed")
  canOverwrite.value = false
}

const exportAll = () => {
  eventGtag("export button", "click")

  store.dispatch("toasterStore/add", { message: "started to export" })

  setTimeout(() => {
    store.dispatch("ioStore/exportAll")
  }, 600 /* $duration-slow */)
}
</script>

<style lang="scss" scoped>
.the-global-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-right: var(--space-size-l);
  padding-left: var(--space-size-l);
  color: $night-ft-color;
  background-color: $night-bg-color;

  .logo {
    align-self: center;
    padding-top: var(--space-size-s);
    padding-right: var(--space-size-l);
    padding-bottom: var(--space-size-s);
    font-size: var(--ft-size-l);
    cursor: pointer;

    > .title {
      @include text-no-break;

      &::after {
        font-size: var(--ft-size-m);
        font-style: italic;
        content: "(β)";
      }
    }
  }

  > .nav {
    display: inline-flex;
    flex: 1;
    align-items: stretch;

    > .list {
      display: inline-flex;
      flex: 1;
      align-items: stretch;

      > .item {
        display: inline-flex;
        flex: 1;
        align-items: center;
        justify-content: center;
        font-weight: $bold-font-weight;

        > .link {
          display: inline-flex;
          align-items: center;
          justify-content: center;
          width: 100%;
          height: 100%;
          padding-bottom: var(--space-size-xs);
          margin-top: var(--space-size-s);
          cursor: pointer;
          border-top-left-radius: $border-radius-base;
          border-top-right-radius: $border-radius-base;

          &.-current {
            color: $day-ft-color;
            background-color: $day-bg-color;
          }
        }
      }
    }
  }

  > .actions {
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-fill;

      margin-left: var(--space-size-m);

      &.import {
        &::after {
          content: " ...";
        }
      }
    }
  }
}

.the-global-header > .modal {
  ::v-deep(.content) {
    display: flex;
    flex-direction: column;

    > .group {
      display: flex;
      flex-direction: row;

      &:not(:first-child) {
        margin-top: var(--space-size-m);
      }

      > .label {
        margin-right: 1em;

        &.-attention {
          color: $error-ft-color;
        }
      }

      > .checkbox {
        margin-right: 1em;
        appearance: auto;
      }

      > .radio {
        margin-right: 1em;
        appearance: auto;
      }

      > .file {
        /* no-op */
      }
    }
  }
}
</style>
