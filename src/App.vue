<template>
  <div id="app">
    <the-global-hint class="hint" />
    <the-global-header class="header" />
    <router-view v-slot="{ Component }">
      <keep-alive>
        <component class="main" :is="Component" />
      </keep-alive>
    </router-view>
    <the-global-footer class="footer" @clear="clearAllDataAndClose()" />
    <the-toaster-list class="toaster" />
  </div>
</template>

<script lang="ts" setup>
import debounce from "lodash.debounce"
import { onMounted, nextTick } from "vue"
import { useStore } from "vuex"

import TheGlobalFooter from "@/commons/TheGlobalFooter.vue"
import TheGlobalHeader from "@/commons/TheGlobalHeader.vue"
import TheGlobalHint from "@/commons/TheGlobalHint.vue"
import TheToasterList from "@/commons/TheToasterList.vue"
import { eventGtag } from "@/composables/gtag"
import { useLocalStorageAutoSave, loadFromLocalStorage } from "@/composables/localStorage"

const store = useStore()

useLocalStorageAutoSave(store)

const createCompileWorker = () => {
  return store.dispatch("workerStore/createCompileWorker", {
    successCallback: debounce(() => {
      store.dispatch("toasterStore/add", { message: "completed to compile" })
    }),
    failCallback: debounce(() => {
      store.dispatch("toasterStore/add", { message: "failed compile", type: "error" })
    }),
  })
}
const clearAllDataAndClose = async () => {
  await store.dispatch("localStorageStore/clearFromLocalStorage")
  await store.dispatch("workerStore/terminateCompileWorker")

  nextTick(() => {
    window.open("about:blank", "_self")?.close()
  })
}

loadFromLocalStorage(store)
createCompileWorker()
setTimeout(() => {
  store.dispatch("workerStore/requestSimpleScriptObjectToWorker")
}, 2000)

onMounted(() => {
  setTimeout(() => {
    eventGtag("front page", "open")
  }, 4000)
})
</script>

<style lang="scss" scoped>
#app {
  display: grid;
  grid-template-rows: $global-hint-height $global-header-height 1fr auto;
  grid-template-columns: 1fr;
  width: 100%;
  min-height: 100vh;

  > .hint {
    position: fixed;
    top: 0;
    left: 0;
    z-index: $editor-z-index + 10;
    grid-row: 1;
    grid-column: 1;
    width: 100%;
    height: $global-hint-height;
  }

  > .header {
    position: fixed;
    top: $global-hint-height;
    left: 0;
    z-index: $editor-z-index + 10;
    grid-row: 2;
    grid-column: 1;
    width: 100%;
    height: $global-header-height;
  }

  > .main {
    grid-row: 3;
    grid-column: 1;
  }

  > .footer {
    grid-row: 4;
    grid-column: 1;
  }

  > .toaster {
    position: fixed;
    top: $global-fixed-height;
    right: 0;
    z-index: $toaster-z-index;
    margin: var(--space-size-s);
  }
}
</style>
