<template>
  <div class="script-editor">
    <filter-editor class="editor" ref="editorElement" v-model="advancedScriptText" :error="store.state.syntaxError" />
    <div class="hint">
      <p class="item">
        Do you want to edit by text editor?
        <a class="link" href="https://marketplace.visualstudio.com/items?itemName=isuke.vscode-advanced-poe-filter" target="_blank" rel="noopener noreferrer">
          There is vscode extension !
        </a>
      </p>
    </div>
  </div>
</template>

<script lang="ts" setup>
import debounce from "lodash.debounce"
import { ref, computed, watch } from "vue"
import { useStore } from "vuex"

import FilterEditor from "@/commons/FilterEditor.vue"
import { eventGtag } from "@/composables/gtag"

const store = useStore()

const editorElement = ref<InstanceType<typeof FilterEditor>>()

const advancedScriptText = computed<string>({
  get: () => {
    return store.state.advancedScriptText
  },
  set: (value) => {
    store.commit("setAdvancedScriptText", { advancedScriptText: value })
  },
})

watch(
  advancedScriptText,
  debounce(() => {
    eventGtag("script", "edit")
    store.dispatch("workerStore/requestSimpleScriptObjectToWorker")
  }, 2500),
)

const scrollToSection = (sectionName: string) => editorElement.value?.scrollToSection(sectionName)

defineExpose({
  scrollToSection,
})
</script>

<style lang="scss" scoped>
$my-hint-height: 30px;

.script-editor {
  max-width: calc(100vw - #{$aside-size-width});
  font-size: var(--ft-size-m);

  > .editor {
    height: calc(100% - #{$my-hint-height});
  }

  > .hint {
    display: flex;
    align-items: center;
    height: $my-hint-height;
    padding: var(--space-size-m);

    > .item {
      > .link {
        text-decoration: underline;
      }
    }
  }
}
</style>
