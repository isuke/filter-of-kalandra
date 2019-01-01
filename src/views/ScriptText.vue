<template lang="pug">
.script-text
  p.text {{ $store.getters.outputText['No Name'] }}
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.script-text {
  > .text {
    font-family: "Courier New", Consolas, monospace;
    white-space: pre-wrap;
    word-wrap: break-word;
  }
}
</style>
