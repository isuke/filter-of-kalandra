<template>
  <div class="script-text">
    <header class="header">
      <ul class="list">
        <li
          class="item"
          v-for="(scriptName, i) in store.getters.scriptNames"
          :key="i"
          @click.prevent="changeCurrentScript(scriptName)"
          :class="{ '-current': scriptName === currentScriptName }"
        >
          <div class="title">{{ scriptName }}</div>
        </li>
      </ul>
      <div class="actions">
        <button class="button copy" @click.prevent="copy">Copy to Clipboard</button>
        <button class="button reload" @click.prevent="reload">Reload</button>
      </div>
    </header>
    <pre class="text" ref="textElement" v-text="text" />
  </div>
</template>

<script lang="ts" setup>
import { ref, computed, watch, nextTick, onMounted } from "vue"
import { useStore } from "vuex"

import { eventGtag } from "@/composables/gtag"

const store = useStore()

const textElement = ref<HTMLPreElement | undefined>()

const currentScriptName = ref<string>(store.getters.scriptNames[0])

const texts = computed<{ [script: string]: string }>(() => store.state.simpleScriptTexts)
const text = computed<string>(() => {
  return currentScriptName.value ? texts.value[currentScriptName.value] : ""
})

watch(text, () => {
  nextTick(() => createMonaco())
})

const changeCurrentScript = (scriptName: string) => (currentScriptName.value = scriptName)
const createMonaco = () => {
  if (textElement.value?.childElementCount === 0 && text.value.length < 12000) {
    import(/* webpackChunkName: "monaco" */ "monaco-editor").then((monaco) => {
      monaco.editor.colorizeElement(textElement.value as HTMLPreElement, {
        mimeType: "advancedPoeFilter",
        theme: "advancedPoeFilterNightTheme",
        tabSize: 4,
      })
    })
  }
}
const copy = (): void => {
  eventGtag("text", "copy to clipboard")
  navigator.clipboard
    .writeText(text.value)
    .then(() => {
      store.dispatch("toasterStore/add", { message: "copied" })
    })
    .catch((error: Error) => {
      console.error(error.message)
    })
}
const reload = (): void => {
  store.dispatch("toasterStore/add", { message: "started to reload" })
  store.dispatch("workerStore/requestSimpleScriptTextsToWorker")
}

onMounted(() => reload())
</script>

<style lang="scss" scoped>
$my-sub-header-height: 3rem;
$my-sub-header-z-index: $base-z-index + 20;

.script-text {
  > .header {
    position: sticky;
    top: calc(#{$global-fixed-height} + #{$sub-header-height});
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    width: 100%;
    height: $sub-header-height;
    padding-left: var(--space-size-xl);
    color: $night-ft-color;
    background-color: $night-bg-color2;

    > .list {
      display: inline-flex;
      flex: 1;
      flex-direction: row;
      align-items: center;
      justify-content: center;

      > .item {
        display: inline-flex;
        flex: 1;
        align-items: center;
        cursor: pointer;

        > .title {
          font-weight: $bold-font-weight;
          color: $night-ft-accent-color3;
          border-color: $night-bg-color2;
          border-bottom-style: solid;
          border-bottom-width: $border-height-bold;
        }

        &.-current > .title {
          color: $night-ft-accent-color1;
          border-color: $night-ft-accent-color1;
        }
      }
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

  > .text {
    padding: 0.5em;
    overflow-x: scroll;
    font-family: $mono-font-family;
    color: $night-ft-color;
    background-color: $night-bg-color;
  }
}
</style>
