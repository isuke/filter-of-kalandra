<template>
  <aside class="script-aside">
    <h1 class="title">Section Names</h1>
    <ul class="list">
      <li class="item" v-for="(sectionName, i) in store.getters.sectionNames" :key="i" @click="emits('click-section-name', sectionName)">{{ sectionName }}</li>
    </ul>
  </aside>
</template>

<script lang="ts" setup>
import { useStore } from "vuex"

const store = useStore()

const emits = defineEmits<{
  "click-section-name": [value: string]
}>()
</script>

<style lang="scss" scoped>
.script-aside {
  padding: var(--space-size-s) var(--space-size-l) var(--space-size-s) var(--space-size-l);

  > .title {
    font-size: var(--ft-size-l);
    color: $day-ft-accent-color2;
  }

  > .list {
    position: sticky;
    top: $global-fixed-height;
    max-height: calc(100vh - #{$global-fixed-height} - #{$sub-header-height});
    overflow-y: scroll;

    @include hide-scrollbar;

    > .item {
      margin-top: var(--space-size-s);
      margin-bottom: var(--space-size-s);
      color: $day-ft-accent-color3;
      cursor: pointer;
    }
  }
}
</style>
