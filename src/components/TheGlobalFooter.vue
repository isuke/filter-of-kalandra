<template lang="pug">
footer.the-global-footer
  .copyright © 2019 FUJIYAMA Isuke
  address.info
    ul.list
      li.item: a.link(href="https://github.com/isuke", target="_blank", rel="noopener noreferrer") https://github.com/isuke
  p.policy
    | This website uses "Google Analytics".
    | Google Analytics uses "cookies".
    | cookies help the website operators analyze how visitors use the website.
    | The site send visitors data (e.g. IP Address).
    | The sended data don't include personal information.
  button.clear(@click.prevent="$refs.clearAllModal.open()") Clear All Local Data and Close This Tab
  contact-form.form

  simple-modal.modal.clearmodal(
    ref="clearAllModal",
    headerStr="Clear All Local Data and Close This Tab",
    execStr="Clear All",
    @exec="$emit('clear')"
  )
    template(v-slot:content)
      p.text Are you sure?

</template>

<script lang="coffee">
import SimpleModal from "@/components/SimpleModal.vue"
import ContactForm from "@/components/ContactForm.vue"

export default
  components:
    "simple-modal": SimpleModal
    "contact-form": ContactForm
</script>


<style lang="scss" scoped>
.the-global-footer {
  display: grid;
  grid-template-rows: auto auto auto auto;
  grid-template-columns: 1fr 2fr;
  grid-gap: var(--space-size-m);
  align-items: end;
  @ghost padding-top-bottom(var(--space-size-xl));
  @ghost padding-left-right(var(--space-size-l));
  background-color: $night-bg-color;
  color: $night-ft-color;

  > .copyright {
    grid-row: 1;
    grid-column: 1;
  }

  > .info {
    grid-row: 2;
    grid-column: 1;

    > .list {
      > .item {
        > .link {
          text-decoration: underline;
        }
      }
    }
  }

  > .policy {
    grid-row: 3;
    grid-column: 1;

    font-size: var(--ft-size-s);
  }

  > .clear {
    grid-row: 4;
    grid-column: 1;
    margin-bottom: var(--space-size-s);
    font-size: var(--ft-size-s);

    @include button-fill($danger-ft-color);
  }

  > .form {
    grid-row: 1 / -1;
    grid-column: 2;
  }
}
</style>
