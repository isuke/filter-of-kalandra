<template lang="pug">
.the-global-hint
  p.message The site support only latest chrome and firefox on desktop.
</template>

<script lang="coffee">
export default {}
</script>

<style lang="scss" scoped>
.the-global-hint {
  display: inline-flex;
  flex-direction: row;
  align-items: center;
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);
  background-color: $night-bg-color;
  color: $night-ft-color;
  font-size: var(--ft-size-s);

  border-bottom: $border-height-base $night-ft-color solid;

  > .message {
    width: 100%;
    height: 100%;
    display: inline-flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    overflow-x: scroll;
    white-space: nowrap;

    &::-webkit-scrollbar { display: none; }
  }
}
</style>
