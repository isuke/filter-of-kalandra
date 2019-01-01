<template lang="pug">
.script-editor
  textarea.textarea(v-model.lazy="$store.state.scriptText", :rows="rows()")
</template>

<script lang="coffee">
export default
  methods:
    rows: -> @$store.state.scriptText.split("\n").length + 1
</script>

<style lang="scss" scoped>
.script-editor {
  > .textarea {
    font-family: "Courier New", Consolas, monospace;
    width: 100%;
  }
}
</style>
