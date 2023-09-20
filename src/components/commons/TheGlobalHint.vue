<template>
  <div class="the-global-hint">
    <p class="message">
      The site support only latest Chrome, Firefox and
      <a class="logo-link" href="https://brave.com/fil720" target="_blank" rel="noopener noreferrer">
        <img class="brave-logo" src="@/assets/images/brave-logotype-light.svg" />
      </a>
      on desktop.
    </p>
  </div>
</template>

<script lang="ts" setup></script>

<style lang="scss" scoped>
.the-global-hint {
  display: inline-flex;
  flex-direction: row;
  align-items: center;
  padding-right: var(--space-size-l);
  padding-left: var(--space-size-l);
  font-size: var(--ft-size-s);
  color: $night-ft-color;
  background-color: $night-bg-color;
  border-bottom: $border-height-base $night-ft-color solid;

  > .message {
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    width: 100%;
    height: 100%;
    overflow-x: scroll;
    white-space: nowrap;

    &::-webkit-scrollbar {
      display: none;
    }

    > .logo-link {
      display: inline-flex;
      flex-direction: row;
      align-items: center;
      height: 100%;

      &::after {
        display: none;
      }

      > .brave-logo {
        height: 75%;
        margin-right: 0.5em;
        margin-left: 0.5em;
      }
    }
  }
}
</style>
