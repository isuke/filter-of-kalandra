<template>
  <main class="script">
    <script-header class="header" />
    <script-aside class="aside" @click-section-name="scrollToSection" />
    <router-view v-slot="{ Component }">
      <keep-alive>
        <component class="main" :is="Component" ref="mainElement" />
      </keep-alive>
    </router-view>
  </main>
</template>

<script lang="ts" setup>
import { ref } from "vue"

import ScriptAside from "@/pages/ScriptAside.vue"
import ScriptEditor from "@/pages/ScriptEditor.vue"
import ScriptHeader from "@/pages/ScriptHeader.vue"
import ScriptPreview from "@/pages/ScriptPreview.vue"
import ScriptText from "@/pages/ScriptText.vue"

import type { RouterView } from "vue-router"

const mainElement = ref<InstanceType<typeof ScriptEditor> | InstanceType<typeof ScriptPreview> | InstanceType<typeof ScriptText>>()

const scrollToSection = (sectionName: string) => {
  if (mainElement.value?.$el.className.includes("script-editor")) {
    void (mainElement.value as InstanceType<typeof ScriptEditor>).scrollToSection(sectionName)
  } else if (mainElement.value?.$el.className.includes("script-preview")) {
    void (mainElement.value as InstanceType<typeof ScriptPreview>).scrollToSection(sectionName)
  }
}
</script>

<style lang="scss" scoped>
.script {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: $aside-size-width calc(100vw - #{$aside-size-width});

  > .header {
    position: sticky;
    top: $global-fixed-height;
    z-index: $editor-z-index + 10;
    grid-row: 1;
    grid-column: 2;
  }

  > .aside {
    grid-row: 1 / -1;
    grid-column: 1;
  }

  > .main {
    grid-row: 2;
    grid-column: 2;
  }
}
</style>
