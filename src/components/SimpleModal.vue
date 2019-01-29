<template lang="pug">
dialog.simple-modal(ref="self", @click.self="close('cancelled')")
  .header
    h1.title {{ headerStr }}
    button.button.close(@click.prevent="close('cancelled')") ×
  slot(name="content")
  .footer
    button.button.import(@click.prevent="$emit('exec')") {{ execStr }}
</template>

<script lang="coffee">
export default
  props:
    headerStr:
      type: String
      required: false
      default: ""
    execStr:
      type: String
      required: false
      default: "OK"
  methods:
    open: -> @$refs.self.showModal()
    close: (returnValue) -> @$refs.self.close(returnValue)
</script>

<style lang="scss" scoped>
.simple-modal {
  min-width: 25rem;
  max-width: 85vw;
  @include shadow(2);

  &::backdrop {
    background-color: rgba(0, 0, 0, 0.7);
  }

  &[open] {
    animation: slide-down $duration-base $timing-base, fade-in $duration-base $timing-base;

    &::backdrop { animation: fade-in $duration-base $timing-base; }
  }

  > .header {
    display: inline-flex;
    align-items: center;
    width: 100%;

    background-color: $global-bg-color-night;
    color: $global-ft-color-night;
    padding: var(--space-size-l);

    @ghost border-top-radius(#{$border-radius-base});

    > .title {
      flex: 1;
      font-size: var(--ft-size-l);
    }

    > .button {
      font-size: var(--ft-size-l);
    }
  }

  > .content {
    background-color: $global-bg-color-day;
    color: $global-ft-color-day;
    padding: var(--space-size-l);
  }

  > .footer {
    display: inline-flex;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
    background-color: $global-bg-color-day;
    color: $global-ft-color-day;
    padding: var(--space-size-l);

    @ghost border-bottom-radius(#{$border-radius-base});

    > .button {
      @include button-fill(0);
    }
  }
}

@keyframes slide-down {
  from {
    transform: translate(0, -1.5rem);
  }

  to {
    transform: translate(0, 0);
  }
}

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>
