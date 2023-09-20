<template>
  <div class="minimap-icon"><img class="image" src="@/assets/images/minimap-icons.png" :style="style" /></div>
</template>

<script lang="ts" setup>
import * as advancedPoeFilterParser from "advanced-poe-filter-parser"
import { computed } from "vue"

type Props = {
  size: advancedPoeFilterParser.MinimapIconSize
  color: advancedPoeFilterParser.MinimapIconColor
  shape: advancedPoeFilterParser.MinimapIconShape
}

const props = defineProps<Props>()

const unit = 32

const style = computed<{ top: `${number}px`; left: `${number}px` }>(() => {
  let column
  switch (props.shape) {
    case "Circle":
      column = 0
      break
    case "Diamond":
      column = 1
      break
    case "Hexagon":
      column = 2
      break
    case "Square":
      column = 3
      break
    case "Star":
      column = 4
      break
    case "Triangle":
      column = 5
      break
    case "Cross":
      column = 6
      break
    case "Moon":
      column = 7
      break
    case "Raindrop":
      column = 8
      break
    case "Kite":
      column = 9
      break
    case "Pentagon":
      column = 10
      break
    case "UpsideDownHouse":
      column = 11
      break
  }

  let row
  switch (props.color) {
    case "Blue":
      row = 0 * 3
      break
    case "Green":
      row = 1 * 3
      break
    case "Brown":
      row = 2 * 3
      break
    case "Red":
      row = 3 * 3
      break
    case "White":
      row = 4 * 3
      break
    case "Yellow":
      row = 5 * 3
      break
    case "Cyan":
      row = 6 * 3
      break
    case "Grey":
      row = 7 * 3
      break
    case "Orange":
      row = 8 * 3
      break
    case "Pink":
      row = 9 * 3
      break
    case "Purple":
      row = 10 * 3
      break
  }

  switch (props.size) {
    case 0:
    case "0":
    case "Largest":
      row += 0
      break
    case 1:
    case "1":
    case "Medium":
      row += 1
      break
    case 2:
    case "2":
    case "Small":
      row += 2
      break
  }

  return {
    top: `${column * unit * -1}px`,
    left: `${row * unit * -1}px`,
  }
})
</script>

<style lang="scss" scoped>
.minimap-icon {
  position: relative;
  width: 32px;
  height: 32px;
  overflow: hidden;

  > .image {
    position: absolute;

    // top: -32px;
    // left: -32px;
  }
}
</style>
