<template>
  <div class="contact-form">
    <h1 class="title">Contact Form</h1>
    <form class="form" name="contact-form" method="post" data-netlify="true" data-netlify-honeypot="bot-field">
      <label class="label">Contact Type</label>
      <select class="select" name="type" v-model="inputContactType">
        <option v-for="contactType in contactTypes" :value="contactType" :key="contactType">{{ contactType }}</option>
      </select>
      <label class="label">{{ isEmailRequired ? "" : "[option]" }} Your Email for Replay</label>
      <input class="input" name="email" type="email" v-model="inputEmail" placeholder="foobar@example.com" :required="isEmailRequired" />
      <label class="label">Content</label>
      <textarea class="input" name="content" v-model="inputContent" :rows="rows" placeholder="English or Japanese" required />
      <input type="hidden" name="form-name" value="contact-form" />
      <p class="message" :class="{ '-success': status === 'SUCCESS', '-error': status === 'ERROR' }">{{ message }}</p>
      <input type="submit" class="button" @click.prevent="submit" value="Submit" />
    </form>
  </div>
</template>

<script lang="ts" setup>
import axios from "axios"
import { ref, computed } from "vue"

const contactTypes = ["Question", "Bug Report", "Idea", "Other"] as const
const inputContactType = ref<(typeof contactTypes)[number]>("Question")
const inputEmail = ref<string>("")
const inputContent = ref<string>("")
const message = ref<string>("")
const status = ref<"" | "SUCCESS" | "ERROR">("")

const rows = computed<number>(() => {
  const minRows = 2
  const result = inputContent.value.split("\n").length
  return result > minRows ? result : minRows
})
const isEmailRequired = computed<boolean>(() => inputContactType.value === "Question")

const encode = (data: { [name: string]: string }) => {
  Object.keys(data)
    .map((key) => `${encodeURIComponent(key)}=${encodeURIComponent(data[key])}`)
    .join("&")
}

const submit = () => {
  if (!inputContent.value) return

  if (isEmailRequired.value && !inputEmail.value) {
    message.value = "email is required when type is 'Question'"
    status.value = "ERROR"
    return
  }

  const data = {
    "form-name": "contact-form",
    "type": inputContactType.value,
    "email": inputEmail.value,
    "content": inputContent.value,
  }

  axios
    .post("/", encode(data), { headers: { "Content-Type": "application/x-www-form-urlencoded" } })
    .then((_response) => {
      inputContactType.value = "Question"
      inputEmail.value = ""
      inputContent.value = ""
      message.value = "Your message was sent successfully, Thank you!"
      status.value = "SUCCESS"
    })
    .catch((error) => {
      message.value = error.message
      status.value = "ERROR"
      console.error(error.message)
    })
}
</script>

<style lang="scss" scoped>
.contact-form {
  padding: var(--space-size-s);
  color: $day-ft-color;
  background-color: $day-bg-color;
  border-radius: $border-radius-base;

  > .title {
    display: flex;
    justify-content: center;
    margin-bottom: var(--ft-size-m);
    font-size: var(--ft-size-l);
    font-weight: $bold-font-weight;
  }

  > .form {
    display: grid;
    grid-template-columns: 1fr 2fr;
    grid-auto-rows: max-content;
    gap: var(--space-size-s);

    > .label {
      padding: 0.5em;
      text-align: right;
    }

    > .select {
      @include select;
    }

    > .input {
      @include text-input;
    }

    > .message {
      grid-column: span 2;
      text-align: center;

      &.-success {
        color: $success-ft-color;
      }

      &.-error {
        color: $error-ft-color;
      }
    }

    > .button {
      @include button-fill;

      grid-column: span 2;
    }
  }
}
</style>
