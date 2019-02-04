<template lang="pug">
ul.color-list
  li.color(v-for="(color, i) in $store.state.colors", :id="color.name")
    input.name(type="text", v-model="color.name")
    button.button.delete(@click="$store.commit('removeColor', { index: i })") ×
    input.input(type="color", v-model="color.hex")
    dl.list
      dt.term RGB
      dd.description {{ getRGBStr(i) }}
      dt.term HEX
      dd.description {{ color.hex }}
      dt.term HSL
      dd.description {{ getHSLStr(i) }}
      dt.term Luminosity
      dd.description {{ round($store.getters.colorObject(i).luminosity()) }}
      dt.term Is Light?
      dd.description {{ $store.getters.colorObject(i).isLight() }}
    .previews
      .preview.background: span.item(:style="getBackgroundStyle(color, i)") Item Name
      .preview.font: span.item(:style="getFontStyle(color, i)") Item Name
</template>

<script lang="coffee">
export default
  methods:
    getRGBStr: (index) ->
      color = @$store.getters.colorObject(index).rgb().color
      "#{color[0]} #{color[1]} #{color[2]}"
    getHSLStr: (index) ->
      color = @$store.getters.colorObject(index).hsl().color.map((c) => Math.round(c))
      "#{color[0]}° #{color[1]}% #{color[2]}%"
    getBackgroundStyle: (color, index) ->
      colorObject = @$store.getters.colorObject(index)
      {
        "background-color": color.hex
        "color": if colorObject.isLight() then "black" else "white"
      }
    getFontStyle: (color, index) ->
      colorObject = @$store.getters.colorObject(index)
      {
        "background-color": if colorObject.isLight() then "black" else "white"
        "color": color.hex
        "border": "0.2em #{color.hex} solid"
      }
    # TODO: move to utils
    round: (val, precision = 2) ->
      digit = Math.pow(10, precision)
      Math.round(val * digit) / digit
</script>

<style lang="scss" scoped>
.color-list {
  display: grid;
  grid-auto-rows: max-content;
  grid-template-columns: repeat(auto-fill, minmax(20rem, 1fr));
  grid-auto-flow: row;
  gap: var(--space-size-s);
  padding: var(--space-size-s);

  background-color: $global-bg-color-day;
  color: $global-ft-color-day;

  > .color {
    display: grid;
    gap: var(--space-size-s);
    grid-template-rows: auto auto 1fr 3rem;
    grid-template-columns: 1fr 2rem;

    @include card();
    @include bg-ft-color($color-color-hue, "day");

    > .name {
      grid-row: 1;
      grid-column: 1;
      font-size: var(--ft-size-l);

      @include text-input();
    }

    > .button {
      grid-row: 1;
      grid-column: 2;
      font-size: var(--ft-size-l);
    }

    > .input {
      grid-row: 2;
      grid-column: 1 / -1;
    }

    > .list {
      grid-row: 3;
      grid-column: 1 / -1;
      display: grid;
      grid-auto-rows: max-content;
      grid-template-columns: 1fr 1fr;
      column-gap: var(--space-size-s);

      > .term { /* no-op */ }
      > .description { /* no-op */ }
    }

    > .previews {
      grid-row: 4;
      grid-column: 1 / -1;

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
}
</style>
