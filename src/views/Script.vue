<template lang="pug">
main.script
  script-header.header

  script-adide.aside(@click-section-name="scrollToSection")

  keep-alive
    router-view.main(ref="main")
</template>

<script lang="coffee">
import ScriptHeader from "@/views/ScriptHeader"
import ScriptAside from "@/views/ScriptAside"

export default
  components:
    "script-header": ScriptHeader
    "script-adide": ScriptAside
  methods:
    scrollToSection: (sectionName) ->
      @$refs.main.scrollToSection(sectionName) if @$refs.main.scrollToSection
</script>

<style lang="scss" scoped>
.script {
  display: grid;
  grid-template-rows: $sub-header-height 1fr;
  grid-template-columns: $aside-size-width calc(100vw - #{$aside-size-width});

  > .header {
    grid-row: 1;
    grid-column: 2;
    position: sticky;
    top: $global-header-height;
    z-index: $editor-z-index + 10;
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
