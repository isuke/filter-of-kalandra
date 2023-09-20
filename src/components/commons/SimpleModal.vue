<template>
  <dialog class="simple-modal" ref="modelElement" @click.self="close('cancelled')">
    <div class="header">
      <h1 class="title">{{ props.headerStr }}</h1>
      <button class="button close" @click.prevent="close('cancelled')">×</button>
    </div>
    <div class="content">
      <slot name="content" />
    </div>
    <div class="footer">
      <button class="button import" @click.prevent="$emit('exec')" :disabled="!props.canExec">{{ props.execStr }}</button>
    </div>
  </dialog>
</template>

<script lang="ts" setup>
import { ref } from "vue"

type Props = {
  headerStr?: string
  execStr?: string
  canExec?: boolean
}
const props = withDefaults(defineProps<Props>(), {
  headerStr: "",
  execStr: "OK",
  canExec: true,
})

const modelElement = ref<HTMLDialogElement>()

const open = () => {
  modelElement.value?.showModal()
}

const close = (returnValue: string) => {
  modelElement.value?.close(returnValue)
}

defineExpose({ open, close })
</script>

<style lang="scss" scoped>
.simple-modal {
  min-width: 25rem;
  max-width: 85vw;

  @include shadow(2);

  &::backdrop {
    background-color: rgb(0 0 0 / 70%);
  }

  &[open] {
    animation:
      slide-down $duration-base $timing-base,
      fade-in $duration-base $timing-base;

    &::backdrop {
      animation: fade-in $duration-base $timing-base;
    }
  }

  > .header {
    display: inline-flex;
    align-items: center;
    width: 100%;
    padding: var(--space-size-l);
    color: $night-ft-color;
    background-color: $night-bg-color;
    border-bottom: $border-height-extra-bold $day-night-border-color solid;
    border-top-left-radius: $border-radius-base;
    border-top-right-radius: $border-radius-base;

    > .title {
      flex: 1;
      font-size: var(--ft-size-l);
    }

    > .button {
      font-size: var(--ft-size-l);
    }
  }

  > .content {
    padding: var(--space-size-l);
    color: $day-ft-color;
    background-color: $day-bg-color;
  }

  > .footer {
    display: inline-flex;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
    padding: var(--space-size-l);
    color: $day-ft-color;
    background-color: $day-bg-color;
    border-bottom-right-radius: #{$border-radius-base};
    border-bottom-left-radius: #{$border-radius-base};

    > .button {
      @include button-fill;
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
