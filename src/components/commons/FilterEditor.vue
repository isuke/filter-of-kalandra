<template>
  <div class="filer-editor" :class="{ '-error': hasError }">
    <div class="textarea" ref="textareaElement"><span class="loading" v-if="!isPreparedEditor">Now Loading...</span></div>
  </div>
</template>

<script lang="ts" setup>
import debounce from "lodash.debounce"
import Monaco from "monaco-editor"
import { ref, watch, computed, nextTick, onMounted } from "vue"
import { useStore } from "vuex"

import type { CompileWorkerMessageUnknownError, CompileWorkerMessageSyntaxError } from "@/stores/workerStore"

type Props = {
  modelValue: string
  error?: CompileWorkerMessageUnknownError["result"] | CompileWorkerMessageSyntaxError["result"]
}
const props = defineProps<Props>()

const emits = defineEmits<{
  "update:modelValue": [value: string | undefined]
}>()

const store = useStore()

const textareaElement = ref<HTMLTextAreaElement>()
const isPreparedEditor = ref<boolean>(false)

let editor: Monaco.editor.IStandaloneCodeEditor | undefined
let errorDecorationCollection: Monaco.editor.IEditorDecorationsCollection

watch(
  () => props.error,
  (error) => {
    if (!editor) return

    if (error) {
      if (error.name === "SyntaxError") {
        const syntaxError = error
        const location = syntaxError.location

        errorDecorationCollection = editor.createDecorationsCollection([
          {
            range: {
              startLineNumber: location.start.line,
              startColumn: location.start.column,
              endLineNumber: location.end.line,
              endColumn: location.end.column,
            },
            options: {
              inlineClassName: "error",
              linesDecorationsClassName: "error-gutter",
              hoverMessage: {
                value: syntaxError.message,
              },
            },
          },
        ])
      } else if (error.name === "UnknownError") {
        const unknownError = error

        store.dispatch("toasterStore/add", { message: unknownError.message, type: "error" })
      }
    } else {
      errorDecorationCollection?.clear()
    }
  },
)

const hasError = computed(() => !!props.error)

const createMonaco = () => {
  import(/* webpackChunkName: "monaco" */ "monaco-editor").then((monaco) => {
    // monacoRange.value = monaco.Range

    editor = monaco.editor.create(textareaElement.value as HTMLTextAreaElement, {
      value: props.modelValue,
      theme: "advancedPoeFilterNightTheme",
      language: "advancedPoeFilter",
      wordWrap: "bounded",
      wordWrapColumn: 160,
      wrappingIndent: "indent",
    })

    editor.onDidChangeModelContent(
      debounce(() => {
        emits("update:modelValue", editor?.getValue())
      }, 1000),
    )

    // HACK
    nextTick(() => {
      window.editor = editor
    })

    isPreparedEditor.value = true
  })
}

const scrollToSection = (sectionName: string) => {
  if (!editor) return
  const match = editor.getModel()?.findMatches(`^(Show|Hide|Unset|Var|Prop)[^\n]+"${sectionName}"$`, true, true, true, null, false, 1)[0]
  if (match) {
    const lineNumber = match.range.startLineNumber
    editor.revealPositionInCenter({ lineNumber, column: 1 })
    editor.setPosition({ lineNumber, column: 1 })
    editor.focus()
  }
}

onMounted(() => {
  createMonaco()
})

defineExpose({
  scrollToSection,
})
</script>

<style lang="scss" scoped>
.filer-editor {
  height: 100%;
  border-color: $night-bg-color;
  border-style: solid;
  border-width: $border-height-bold;

  &.-error {
    border-color: $error-bg-color;
  }

  > .textarea {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    color: $night-ft-color;
    background-color: $night-bg-color;

    > .loading {
      font-size: var(--ft-size-l);
    }
  }
}
</style>
