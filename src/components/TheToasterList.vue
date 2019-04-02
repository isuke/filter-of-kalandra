<template lang="pug">
transition-group.simple-toaster-list(name="slide-list", tag="ul")
  li.item(
    v-for="item in items",
    :key="item.id",
    @click="remove(item.id)"
  ) {{ item.message }}
</template>

<script lang="coffee">
export default
  props:
    timeout:
      type: Number
      required: false
      default: 8000
  data: ->
    id: 0
    items: []
  methods:
    add: (message) ->
      id = @id++

      @items.push id: id, message: message
      setTimeout =>
        @remove id
      , @timeout
      id
    remove: (id) ->
      index = @items.findIndex (item) => item.id == id
      return if index < 0
      @items.splice(index, 1)
      id
</script>

<style lang="scss" scoped>
.simple-toaster-list {
  > .item {
    padding: var(--space-size-m);
    border-radius: $border-radius-base;
    background-color: $global-bg-color-day;
    color: $global-ft-color-day;
    opacity: 0.9;
    min-width: 6rem;
    max-width: 50vw;

    cursor: pointer;

    @include shadow(3);

    @ghost transition(#{$duration-slow}, ease, transform, opacity);

    &:not(:last-child) { margin-bottom: var(--space-size-s); }

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
