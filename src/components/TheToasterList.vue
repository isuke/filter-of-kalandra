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
  props:
    timeout:
      type: Number
      required: false
      default: 8000
  data: ->
    id: 0
    items: []
    defaultItemVals:
      message: ""
      type: "normal"
  methods:
    add: (payload) ->
      id = @id++

      item = if typeof payload == "string"
        Object.assign {}, @defaultItemVals, { id: id, message: payload }
      else
        Object.assign {}, @defaultItemVals, { id: id }, payload

      @items.push item

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
    opacity: 0.9;
    min-width: 6rem;
    max-width: 50vw;

    cursor: pointer;

    @include shadow(3);

    @ghost transition(#{$duration-slow}, ease, transform, opacity);

    &:not(:last-child) { margin-bottom: var(--space-size-s); }

    &.-normal {
      background-color: $global-bg-color-day;
      color: $global-ft-color-day;
    }
    &.-error {
      background-color: $error-bg-color;
      color: $global-ft-color-night;
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
