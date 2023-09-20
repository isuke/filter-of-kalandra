<template>
  <transition-group class="simple-toaster-list" name="slide-list" tag="ul">
    <li class="item" v-for="item in items" :key="item.id" :class="`-${item.type}`" @click="store.dispatch('toasterStore/remove', { id: item.id })">
      {{ item.message }}
    </li>
  </transition-group>
</template>

<script lang="ts" setup>
import { useStore } from "vuex"

const store = useStore()

const items = store.state.toasterStore.items
</script>

<style lang="scss" scoped>
.simple-toaster-list {
  > .item {
    min-width: 6rem;
    max-width: 50vw;
    padding: var(--space-size-m);
    cursor: pointer;
    border-radius: $border-radius-base;
    opacity: 0.9;

    transition: {
      duration: $duration-slow;
      timing-function: ease;
      property: transform opacity;
    }

    @include shadow(3);

    &:not(:last-child) {
      margin-bottom: var(--space-size-s);
    }

    &.-normal {
      color: $day-ft-color;
      background-color: $day-bg-color;
    }

    &.-error {
      color: $night-ft-color;
      background-color: $error-bg-color;
    }

    &.slide-list-enter {
      opacity: 0;
      transform: translateX(100%);
    }

    &.slide-list-leave-to {
      opacity: 0;
      transform: translateX(100%);
    }
  }
}
</style>
