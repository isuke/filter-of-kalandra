<template lang="pug">
.minimap-icon
  img.image(:src="spritImage", :style="style")
</template>

<script lang="coffee">
import spritImage from "@/assets/images/minimap-icons.png"

export default
  data: ->
    spritImage: spritImage
    unit: 32
  props:
    size:
      type: String
      required: true
      validator: (val) -> ["0", "1", "2", "Largest", "Medium", "Small"].includes val
    color:
      type: String
      required: true
      validator: (val) -> ["Blue", "Green", "Brown", "Red", "White", "Yellow", "Cyan", "Grey", "Orange", "Pink", "Purple"].includes val
    shape:
      type: String
      required: true
      validator: (val) -> ["Circle", "Diamond", "Hexagon", "Square", "Star", "Triangle", "Cross", "Moon", "Raindrop", "Kite", "Pentagon", "UpsideDownHouse"].includes val
  computed:
    style: ->
      column = switch @shape
        when "Circle"          then 0
        when "Diamond"         then 1
        when "Hexagon"         then 2
        when "Square"          then 3
        when "Star"            then 4
        when "Triangle"        then 5
        when "Cross"           then 6
        when "Moon"            then 7
        when "Raindrop"        then 8
        when "Kite"            then 9
        when "Pentagon"        then 10
        when "UpsideDownHouse" then 11

      row = switch @color
        when "Blue"   then 0  * 3
        when "Green"  then 1  * 3
        when "Brown"  then 2  * 3
        when "Red"    then 3  * 3
        when "White"  then 4  * 3
        when "Yellow" then 5  * 3
        when "Cyan"   then 6  * 3
        when "Grey"   then 7  * 3
        when "Orange" then 8  * 3
        when "Pink"   then 9  * 3
        when "Purple" then 10 * 3
      switch @size
        when "0", "Largest" then row += 0
        when "1", "Medium"  then row += 1
        when "2", "Small"   then row += 2

      { top: "#{column * @unit * -1}px", left: "#{row * @unit * -1}px" }
</script>

<style lang="scss" scoped>
.minimap-icon {
  @ghost size(32px);
  overflow: hidden;
  position: relative;

  > .image {
    position: absolute;
    // top: -32px;
    // left: -32px;
  }
}
</style>
