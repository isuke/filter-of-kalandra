<template lang="pug">
main.home
  h1.title
    | Filter of Kalandra
    span.beta β
  h2.version v{{ version }}
</template>

<script lang="coffee">
import packageJSON from "@/../package.json"

export default
  data: ->
    version: packageJSON.version
</script>

<style lang="scss" scoped>
.home {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .title {
    font-size: var(--ft-size-xxl);

    > .beta {
      font-style: italic;
      font-size: var(--ft-size-xl);
      &::before { content: "("; }
      &::after  { content: ")"; }
    }
  }

  > .version {
    font-size: var(--ft-size-l);
    margin-top: var(--space-size-m);

    &::before {
      content: "-";
      margin-right: 0.5em;
    }
    &::after {
      content: "-";
      margin-left: 0.5em;
    }
  }
}
</style>
