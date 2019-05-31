<template lang="pug">
footer.the-global-footer
  .copyright © 2019 HUJIYAMA Isuke
  address.info
    ul.list
      li.item: a.link(href="https://github.com/isuke", target="_blank", rel="noopener noreferrer") https://github.com/isuke
  p.policy
    | This website uses "Google Analytics".
    | Google Analytics uses "cookies".
    | cookies help the website operators analyze how visitors use the website.
    | The site send visitors data (e.g. IP Address).
    | The sended data don't include personal information.
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

  > .policy {
    margin-top: var(--space-size-m);
    color: $global-ft-non-accent-color-night;
    font-size: var(--ft-size-s);
  }
}
</style>
