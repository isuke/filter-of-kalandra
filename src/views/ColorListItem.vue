<template lang="pug">
.color-list-item
  dl.list
    dt.term RGB
    dd.description {{ rgbStr }}
    dt.term HEX
    dd.description {{ hexLazy }}
    dt.term HSL
    dd.description {{ hslStr }}
    dt.term Luminosity
    dd.description {{ round(colorObjectLazy.luminosity()) }}
    dt.term Is Light?
    dd.description {{ colorObjectLazy.isLight() }}
  .previews
    .preview.background: span.item(:style="backgroundStyle") Item Name
    .preview.font: span.item(:style="fontStyle") Item Name
</template>

<script lang="coffee">
import Color from "color"
import debounce from "lodash.debounce"
import { round } from "@/scripts/utils.coffee"

export default
  props:
    name:
      type: String
      required: true
    hex:
      type: String
      required: true
  data: ->
    haxLazy: undefined
    colorObjectLazy: undefined
  watch:
    hex: debounce ->
      @hexLazy = @hex
      @colorObjectLazy = new Color(@hex)
    , 0
  computed:
    rgbStr: ->
      color = @colorObjectLazy.rgb().color
      "#{color[0]} #{color[1]} #{color[2]}"
    hslStr: ->
      color = @colorObjectLazy.hsl().color.map((c) => Math.round(c))
      "#{color[0]}° #{color[1]}% #{color[2]}%"
    backgroundStyle: ->
      {
        "background-color": @hexLazy
        "color": if @colorObjectLazy.isLight() then "black" else "white"
      }
    fontStyle: ->
      {
        "background-color": if @colorObjectLazy.isLight() then "black" else "white"
        "color": @hexLazy
        "border": "0.2em #{@hexLazy} solid"
      }
  methods:
    round: round
  created: ->
    @hexLazy = @hex
    @colorObjectLazy = new Color(@hex)
</script>

<style lang="scss" scoped>
.color-list-item {
  display: grid;

  > .list {
    display: grid;
    grid-auto-rows: max-content;
    grid-template-columns: 1fr 1fr;
    column-gap: var(--space-size-s);

    > .term { /* no-op */ }
    > .description { /* no-op */ }
  }

  > .previews {
    margin-top: var(--space-size-s);

    display: inline-grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--space-size-s);

    .preview {
      flex: 1;

      display: flex;
      align-items: center;
      justify-content: center;
      background-color: black;
      padding: 0.5rem;
      border-radius: $border-radius-base;

      > .item {
        padding: 0.5em;
      }
    }
  }
}
</style>
