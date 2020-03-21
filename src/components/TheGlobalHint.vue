<template lang="pug">
.the-global-hint
  p.message
    | The site support only latest Chrome, Firefox and
    a.logolink(href="https://brave.com/fil720" target="_blank" rel="noopener noreferrer"): img.bravelogo(src="@/assets/images/brave-logotype-light.svg")
    | on desktop.
    span.attention
      a.link(href="https://filter-of-kalandra-doc.netlify.com/usage/#attention-when-using-with-firefox" target="_blank" rel="noopener noreferrer") Please see when use with Firefox
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

    > .logolink {
      display: inline-flex;
      flex-direction: row;
      align-items: center;
      height: 100%;

      &::after { display: none; }

      > .bravelogo {
        height: 75%;
        margin-left: 0.5em;
        margin-right: 0.5em;
      }
    }

    > .attention {
      margin-left: 1em;
      color: $warn-ft-color;
    }
  }
}
</style>
