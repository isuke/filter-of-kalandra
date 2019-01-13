<template lang="pug">
.color
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
        th {{ $store.getters.colorObject(i).rgb().color }}
        th {{ color.hex }}
        th {{ $store.getters.colorObject(i).hsl().color.map(c => Math.round(c)) }}
        th {{ round($store.getters.colorObject(i).luminosity()) }}
        th {{ $store.getters.colorObject(i).isLight() }}

  button(@click.prevent="$store.commit('addColor')") Add New Color
</template>

<script lang="coffee">
export default
  methods:
    # TODO: move to utils
    round: (val, precision = 2) ->
      digit = Math.pow(10, precision)
      Math.round(val * digit) / digit
</script>

<style lang="scss" scoped>
.color {
}
</style>
