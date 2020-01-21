<template lang="pug">
.contact-form
  h1.title Contact Form

  form.form(
    name="contact-form",
    method="post",
    data-netlify="true",
    data-netlify-honeypot="bot-field"
  )
    label.label Contact Type
    select.select(name="type", v-model="inputContactType")
      option(v-for="contactType in contactTypes", :value="contactType") {{ contactType }}

    label.label {{ isEmailRequired ? '' : '[opstion]' }} Your Email for Replay
    input.input(name="email", type="email", v-model="inputEmail", placeholder="foobar@example.com", :required="isEmailRequired")

    label.label Content
    textarea.input(name="content", v-model="inputContent", :rows="rows", placeholder="English or Japanese", required)

    input(type="hidden", name="form-name", value="contact-form")

    p.message(:class="{ '-success': status == 'SUCCESS', '-error': status == 'ERROR' }") {{ message }}

    button.button(@click.prevent="submit") Submit
</template>

<script lang="coffee">
import axios from "axios"

export default
  data: ->
    contactTypes: ['Question', 'Bug Report', 'Idea', 'Other']
    inputContactType: 'Question'
    inputEmail: ''
    inputContent: ''
    message: ''
    status: ''
  computed:
    rows: ->
      minRows = 2
      result = @inputContent.split("\n").length
      if result > minRows then result else minRows
    isEmailRequired: ->
      @inputContactType == 'Question'
  methods:
    encode: (data) ->
      Object
        .keys(data)
        .map (key) =>
          "#{encodeURIComponent(key)}=#{encodeURIComponent(data[key])}"
        .join('&')
    submit: ->
      return unless @inputContent

      if @isEmailRequired && !@inputEmail
        @message = "email is required when type is 'Question'"
        @status = 'ERROR'
        return

      data = {
        "form-name": "contact-form"
        type: @inputContactType
        email: @inputEmail
        content: @inputContent
      }

      axios.post '/',
        @encode(data), # MEMO: https://github.com/ljharb/qs
        {
          headers: { "Content-Type": "application/x-www-form-urlencoded" }
        }
      .then (_responce) =>
        @inputContactType = 'Question'
        @inputEmail       = ''
        @inputContent     = ''
        @message = 'Your message was sent successfully, Thank you!'
        @status = 'SUCCESS'
      .catch (error) =>
        @message = error.message
        @status = 'ERROR'
        console.error error.message
</script>

<style lang="scss" scoped>
.contact-form {
  background-color: $day-bg-color;
  color: $day-ft-color;
  border-radius: $border-radius-base;
  padding: var(--space-size-s);

  > .title {
    display: flex;
    justify-content: center;
    margin-bottom: var(--ft-size-m);

    font-size: var(--ft-size-l);
    font-weight: $bold-font-weight;
  }


  > .form {
    display: grid;
    grid-auto-rows: max-content;
    grid-template-columns: 1fr 2fr;
    gap: var(--space-size-s);

    > .label {
      padding: 0.5em;
      text-align: right;
    }

    > .select {
      @include select();
    }

    > .input {
      @include text-input();
    }

    > .message {
      grid-column: span 2;
      text-align: center;

      &.-success { color: $success-ft-color }
      &.-error   { color: $error-ft-color }
    }

    > .button {
      @include button-fill();

      grid-column: span 2;
    }
  }
}
</style>
