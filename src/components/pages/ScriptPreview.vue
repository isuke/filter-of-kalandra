<template>
  <div class="script-preview">
    <header class="header">
      <div class="section-name">{{ currentSectionName }}</div>
      <div class="actions">
        <button class="button reload" @click.prevent="isAlt = !isAlt">ALT (Now {{ isAlt ? "ON" : "OFF" }})</button>
        <button class="button reload" @click.prevent="reload">Reload</button>
      </div>
    </header>
    <div class="script" v-for="scriptName in store.getters.scriptNames" :key="scriptName">
      <div class="name">{{ scriptName }}</div>
      <div class="items">
        <script-preview-item class="item" v-for="block in store.getters.blocks(scriptName, currentSectionName)" :key="block.id" :block="block" :isAlt="isAlt" />
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from "vue"
import { useStore } from "vuex"

const store = useStore()

import ScriptPreviewItem from "@/pages/ScriptPreviewItem.vue"

const currentSectionName = ref<string>(store.getters.sectionNames[0])
const isAlt = ref<boolean>(false)

const reload = () => {
  store.dispatch("toasterStore/add", { message: "started to reload" })
  store.dispatch("workerStore/requestSimpleScriptObjectToWorker")
}

const scrollToSection = (sectionName: string) => {
  store.dispatch("toasterStore/add", { message: `started to create preview '${sectionName}'` })
  setTimeout(() => {
    currentSectionName.value = sectionName
  }, 600 /* $duration-slow */)
}

onMounted(() => {
  window.addEventListener("keydown", (event: KeyboardEvent) => {
    if (event.key === "Alt") isAlt.value = true
  })
  window.addEventListener("keyup", (event: KeyboardEvent) => {
    if (event.key === "Alt") isAlt.value = true
  })
})

defineExpose({
  scrollToSection,
})
</script>

<style lang="scss" scoped>
$my-sub-header-height: 3rem;
$my-sub-header-z-index: $base-z-index + 20;
$my-section-name-z-index: $base-z-index + 10;

.script-preview {
  > .header {
    position: sticky;
    top: calc(#{$global-fixed-height} + #{$sub-header-height});
    z-index: $my-sub-header-z-index;
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    width: 100%;
    height: $sub-header-height;
    color: $night-ft-color;
    background-color: $night-bg-color2;

    > .section-name {
      flex: 1;
      padding: var(--space-size-m);
      font-size: var(--ft-size-l);
    }

    > .actions {
      display: inline-flex;
      align-items: center;

      > .button {
        @include button-fill;

        margin-right: var(--space-size-s);
      }
    }
  }

  > .script {
    > .name {
      position: sticky;
      top: calc(#{$global-fixed-height} + #{$sub-header-height} + #{$my-sub-header-height});
      z-index: $my-section-name-z-index;
      padding: var(--space-size-m);
      font-size: var(--ft-size-l);
      color: $night-ft-color;
      background-color: $night-bg-color3;
    }

    > .items {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      justify-content: space-between;
      width: 100%;
      height: 100%;
      padding: var(--space-size-m);
      background-image: url("./../../assets/images/preview-bg-594x1056.png");
      background-repeat: repeat-y;
      background-size: 100% auto;

      > .item {
        margin: var(--space-size-xs);
      }
    }
  }
}
</style>
