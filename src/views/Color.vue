<template lang="pug">
main.color
  table
    thead
      tr
        th Name
        th Input
        th RGB
        th Hex
        th HSL
        th Luminosity
        th Is Light?
    tbody
      tr(v-for="(color, i) in $store.state.colors")
        th: input(type="text", v-model="color.name")
        th: input(type="color", v-model="color.hex")
        th {{ getRGBStr(i) }}
        th {{ color.hex }}
        th {{ getHSLStr(i) }}
        th {{ round($store.getters.colorObject(i).luminosity()) }}
        th {{ $store.getters.colorObject(i).isLight() }}

  button(@click.prevent="$store.commit('addColor')") Add New Color
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
    # TODO: move to utils
    round: (val, precision = 2) ->
      digit = Math.pow(10, precision)
      Math.round(val * digit) / digit
</script>

<style lang="scss" scoped>
.color {
}
</style>
