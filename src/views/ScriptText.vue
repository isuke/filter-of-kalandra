<template lang="pug">
.script-text
  header.header
    ul
      li(v-for="scriptName in $store.getters.scriptNames")
        a(@click.prevent="changeCurrentScript(scriptName)", href="") {{ scriptName }}
  filter-editor.text(v-model="$store.getters.simpleScriptTexts[currentScriptName]", mode="original-poe-filter", :config="{ readOnly: true, lineWrapping: true }")
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
  data: ->
    currentScriptName: undefined
  methods:
    changeCurrentScript: (scriptName) -> @currentScriptName = scriptName
  created: ->
    @currentScriptName = @$store.getters.scriptNames[0]
</script>

<style lang="scss" scoped>
.script-text {
  > .text {
    max-width: calc(100vw - #{$aside-size-width});
  }
}
</style>
