<template lang="pug">
.script-editor
  filter-editor.textarea(v-model="$store.state.advancedScriptText", :syntax-error="$store.state.syntaxError")
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
</script>

<style lang="scss" scoped>
.script-editor {
}
</style>
