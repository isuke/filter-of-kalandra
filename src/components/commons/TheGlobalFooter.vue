<template>
  <footer class="the-global-footer">
    <div class="copyright">© 2019 FUJIYAMA Isuke</div>
    <address class="info">
      <ul class="list">
        <li class="item"><a class="link" href="https://github.com/isuke" target="_blank" rel="noopener noreferrer">https://github.com/isuke</a></li>
      </ul>
    </address>
    <p class="policy">
      This website uses "Google Analytics". Google Analytics uses "cookies". cookies help the website operators analyze how visitors use the website. The site
      send visitors data (e.g. IP Address). The sended data don't include personal information.
    </p>
    <button class="clear" @click.prevent="clearAllModalElement?.open()">Clear All Local Data and Close This Tab</button>
    <contact-form class="form" />
    <simple-modal
      class="modal clear-modal"
      ref="clearAllModalElement"
      headerStr="Clear All Local Data and Close This Tab"
      execStr="Clear All"
      @exec="$emit('clear')"
    >
      <template v-slot:content>
        <p class="text">Are you sure?</p>
      </template>
    </simple-modal>
  </footer>
</template>

<script lang="ts" setup>
import { ref } from "vue"

import ContactForm from "@/commons/ContactForm.vue"
import SimpleModal from "@/commons/SimpleModal.vue"

const clearAllModalElement = ref<InstanceType<typeof SimpleModal>>()
</script>

<style lang="scss" scoped>
.the-global-footer {
  display: grid;
  grid-template-rows: auto auto auto auto;
  grid-template-columns: 1fr 2fr;
  grid-gap: var(--space-size-m);
  align-items: end;
  padding: var(--space-size-xl) var(--space-size-l);
  color: $night-ft-color;
  background-color: $night-bg-color;

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
