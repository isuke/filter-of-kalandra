<template lang="pug">
dialog.simple-modal(ref="self", @click.self="close('cancelled')")
  .header
    h1.title {{ headerStr }}
    button.button.close(@click.prevent="close('cancelled')") ×
  .content
    slot(name="content")
  .footer
    button.button.import(@click.prevent="$emit('exec')", :disabled="! canExec") {{ execStr }}
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
    canExec:
      type: Boolean
      required: false
      default: true
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

    background-color: $night-bg-color;
    color: $night-ft-color;
    padding: var(--space-size-l);

    border-bottom: $border-height-extra-bold $day-night-border-color solid;

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
    background-color: $day-bg-color;
    color: $day-ft-color;
    padding: var(--space-size-l);
  }

  > .footer {
    display: inline-flex;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
    background-color: $day-bg-color;
    color: $day-ft-color;
    padding: var(--space-size-l);

    @ghost border-bottom-radius(#{$border-radius-base});

    > .button {
      @include button-fill();
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
