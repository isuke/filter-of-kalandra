<template lang="pug">
.script-text
  filter-editor.textarea(v-model="$store.getters.simpleScriptTexts['No Name']", mode="original-poe-filter", :config="{ readOnly: true }")
</template>

<script lang="coffee">
import FilterEditor from "@/components/FilterEditor.vue"

export default
  components:
    "filter-editor": FilterEditor
</script>

<style lang="scss" scoped>
.script-text {
}
</style>
