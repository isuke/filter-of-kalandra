<template lang="pug">
main.home
  h1.title Filter of Kalandra
  h2.version v{{ version }}
</template>

<script lang="coffee">
export default
  data: ->
    version: process.env.VUE_APP_VERSION
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

    &::after {
      content: "(α)";
      font-style: italic;
      font-size: var(--ft-size-xl);
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
