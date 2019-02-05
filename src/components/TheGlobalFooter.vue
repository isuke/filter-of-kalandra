<template lang="pug">
footer.the-global-footer
  .copyright © 2019 HUJIYAMA Isuke
  address.info
    ul.list
      li.item: a.link(href="https://github.com/isuke", target="_blank") https://github.com/isuke
</template>

<script lang="coffee">
export default {}
</script>


<style lang="scss" scoped>
.the-global-footer {
  display: flex;
  flex-direction: column;
  justify-content: center;
  @ghost padding-top-bottom(var(--space-size-xl));
  @ghost padding-left-right(var(--space-size-l));
  background-color: $global-bg-color-night;
  color: $global-ft-color-night;

  > .copyright { /* no-op */ }

  > .info {
    margin-top: var(--space-size-m);

    > .list {
      > .item {
        > .link {
          text-decoration: underline;
        }
      }
    }
  }
}
</style>
