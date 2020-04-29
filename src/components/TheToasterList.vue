<template lang="pug">
transition-group.simple-toaster-list(name="slide-list", tag="ul")
  li.item(
    v-for="item in items",
    :key="item.id",
    :class="`-${item.type}`"
    @click="remove(item.id)"
  ) {{ item.message }}
</template>

<script lang="coffee">
export default
  data: ->
    items: @$store.state.toasterStore.items
</script>

<style lang="scss" scoped>
.simple-toaster-list {
  > .item {
    padding: var(--space-size-m);
    border-radius: $border-radius-base;
    opacity: 0.9;
    min-width: 6rem;
    max-width: 50vw;

    cursor: pointer;

    @include shadow(3);

    @ghost transition(#{$duration-slow}, ease, transform, opacity);

    &:not(:last-child) { margin-bottom: var(--space-size-s); }

    &.-normal {
      background-color: $day-bg-color;
      color: $day-ft-color;
    }
    &.-error {
      background-color: $error-bg-color;
      color: $night-ft-color;
    }

    &.slide-list-enter {
      transform: translateX(100%);
      opacity: 0;
    }

    &.slide-list-leave-to {
      transform: translateX(100%);
      opacity: 0;
    }
  }
}
</style>
