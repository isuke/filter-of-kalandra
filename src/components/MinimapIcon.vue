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
      validator: (val) -> ["Red", "Green", "Blue", "Brown", "White", "Yellow"].includes val
    shape:
      type: String
      required: true
      validator: (val) -> ["Circle", "Diamond", "Hexagon", "Square", "Star", "Triangle"].includes val
  computed:
    style: ->
      switch @shape
        when "Circle"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -0}px", left: "#{@unit *  -4}px" }
                when "1", "Medium"  then { top: "#{@unit *  -0}px", left: "#{@unit *  -5}px" }
                when "2", "Small"   then { top: "#{@unit *  -0}px", left: "#{@unit *  -6}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -0}px", left: "#{@unit *  -7}px" }
                when "1", "Medium"  then { top: "#{@unit *  -0}px", left: "#{@unit *  -8}px" }
                when "2", "Small"   then { top: "#{@unit *  -0}px", left: "#{@unit *  -9}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -0}px", left: "#{@unit * -10}px" }
                when "1", "Medium"  then { top: "#{@unit *  -0}px", left: "#{@unit * -11}px" }
                when "2", "Small"   then { top: "#{@unit *  -0}px", left: "#{@unit * -12}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -0}px", left: "#{@unit * -13}px" }
                when "1", "Medium"  then { top: "#{@unit *  -1}px", left: "#{@unit *  -0}px" }
                when "2", "Small"   then { top: "#{@unit *  -1}px", left: "#{@unit *  -1}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -1}px", left: "#{@unit *  -2}px" }
                when "1", "Medium"  then { top: "#{@unit *  -1}px", left: "#{@unit *  -3}px" }
                when "2", "Small"   then { top: "#{@unit *  -1}px", left: "#{@unit *  -4}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -1}px", left: "#{@unit *  -5}px" }
                when "1", "Medium"  then { top: "#{@unit *  -1}px", left: "#{@unit *  -6}px" }
                when "2", "Small"   then { top: "#{@unit *  -1}px", left: "#{@unit *  -7}px" }
        when "Diamond"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -1}px", left: "#{@unit *  -8}px" }
                when "1", "Medium"  then { top: "#{@unit *  -1}px", left: "#{@unit *  -9}px" }
                when "2", "Small"   then { top: "#{@unit *  -1}px", left: "#{@unit * -10}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -1}px", left: "#{@unit * -11}px" }
                when "1", "Medium"  then { top: "#{@unit *  -1}px", left: "#{@unit * -12}px" }
                when "2", "Small"   then { top: "#{@unit *  -1}px", left: "#{@unit * -13}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -2}px", left: "#{@unit *  -0}px" }
                when "1", "Medium"  then { top: "#{@unit *  -2}px", left: "#{@unit *  -1}px" }
                when "2", "Small"   then { top: "#{@unit *  -2}px", left: "#{@unit *  -2}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -2}px", left: "#{@unit *  -3}px" }
                when "1", "Medium"  then { top: "#{@unit *  -2}px", left: "#{@unit *  -4}px" }
                when "2", "Small"   then { top: "#{@unit *  -2}px", left: "#{@unit *  -5}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -2}px", left: "#{@unit *  -6}px" }
                when "1", "Medium"  then { top: "#{@unit *  -2}px", left: "#{@unit *  -7}px" }
                when "2", "Small"   then { top: "#{@unit *  -2}px", left: "#{@unit *  -8}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -2}px", left: "#{@unit *  -9}px" }
                when "1", "Medium"  then { top: "#{@unit *  -2}px", left: "#{@unit * -10}px" }
                when "2", "Small"   then { top: "#{@unit *  -2}px", left: "#{@unit * -11}px" }
        when "Hexagon"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -2}px", left: "#{@unit * -12}px" }
                when "1", "Medium"  then { top: "#{@unit *  -2}px", left: "#{@unit * -13}px" }
                when "2", "Small"   then { top: "#{@unit *  -3}px", left: "#{@unit *  -0}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -3}px", left: "#{@unit *  -1}px" }
                when "1", "Medium"  then { top: "#{@unit *  -3}px", left: "#{@unit *  -2}px" }
                when "2", "Small"   then { top: "#{@unit *  -3}px", left: "#{@unit *  -3}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -3}px", left: "#{@unit *  -4}px" }
                when "1", "Medium"  then { top: "#{@unit *  -3}px", left: "#{@unit *  -5}px" }
                when "2", "Small"   then { top: "#{@unit *  -3}px", left: "#{@unit *  -6}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -3}px", left: "#{@unit *  -7}px" }
                when "1", "Medium"  then { top: "#{@unit *  -3}px", left: "#{@unit *  -8}px" }
                when "2", "Small"   then { top: "#{@unit *  -3}px", left: "#{@unit *  -9}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -3}px", left: "#{@unit * -10}px" }
                when "1", "Medium"  then { top: "#{@unit *  -3}px", left: "#{@unit * -11}px" }
                when "2", "Small"   then { top: "#{@unit *  -3}px", left: "#{@unit * -12}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -3}px", left: "#{@unit * -13}px" }
                when "1", "Medium"  then { top: "#{@unit *  -4}px", left: "#{@unit *  -0}px" }
                when "2", "Small"   then { top: "#{@unit *  -4}px", left: "#{@unit *  -1}px" }
        when "Square"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -4}px", left: "#{@unit *  -2}px" }
                when "1", "Medium"  then { top: "#{@unit *  -4}px", left: "#{@unit *  -3}px" }
                when "2", "Small"   then { top: "#{@unit *  -4}px", left: "#{@unit *  -4}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -4}px", left: "#{@unit *  -5}px" }
                when "1", "Medium"  then { top: "#{@unit *  -4}px", left: "#{@unit *  -6}px" }
                when "2", "Small"   then { top: "#{@unit *  -4}px", left: "#{@unit *  -7}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -4}px", left: "#{@unit *  -8}px" }
                when "1", "Medium"  then { top: "#{@unit *  -4}px", left: "#{@unit *  -9}px" }
                when "2", "Small"   then { top: "#{@unit *  -4}px", left: "#{@unit * -10}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -4}px", left: "#{@unit * -11}px" }
                when "1", "Medium"  then { top: "#{@unit *  -4}px", left: "#{@unit * -12}px" }
                when "2", "Small"   then { top: "#{@unit *  -4}px", left: "#{@unit * -13}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -5}px", left: "#{@unit *  -0}px" }
                when "1", "Medium"  then { top: "#{@unit *  -5}px", left: "#{@unit *  -1}px" }
                when "2", "Small"   then { top: "#{@unit *  -5}px", left: "#{@unit *  -2}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -5}px", left: "#{@unit *  -3}px" }
                when "1", "Medium"  then { top: "#{@unit *  -5}px", left: "#{@unit *  -4}px" }
                when "2", "Small"   then { top: "#{@unit *  -5}px", left: "#{@unit *  -5}px" }
        when "Star"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -5}px", left: "#{@unit *  -6}px" }
                when "1", "Medium"  then { top: "#{@unit *  -5}px", left: "#{@unit *  -7}px" }
                when "2", "Small"   then { top: "#{@unit *  -5}px", left: "#{@unit *  -8}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -5}px", left: "#{@unit *  -9}px" }
                when "1", "Medium"  then { top: "#{@unit *  -5}px", left: "#{@unit * -10}px" }
                when "2", "Small"   then { top: "#{@unit *  -5}px", left: "#{@unit * -11}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -5}px", left: "#{@unit * -12}px" }
                when "1", "Medium"  then { top: "#{@unit *  -5}px", left: "#{@unit * -13}px" }
                when "2", "Small"   then { top: "#{@unit *  -6}px", left: "#{@unit *  -0}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -6}px", left: "#{@unit *  -1}px" }
                when "1", "Medium"  then { top: "#{@unit *  -6}px", left: "#{@unit *  -2}px" }
                when "2", "Small"   then { top: "#{@unit *  -6}px", left: "#{@unit *  -3}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -6}px", left: "#{@unit *  -4}px" }
                when "1", "Medium"  then { top: "#{@unit *  -6}px", left: "#{@unit *  -5}px" }
                when "2", "Small"   then { top: "#{@unit *  -6}px", left: "#{@unit *  -6}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -6}px", left: "#{@unit *  -7}px" }
                when "1", "Medium"  then { top: "#{@unit *  -6}px", left: "#{@unit *  -8}px" }
                when "2", "Small"   then { top: "#{@unit *  -6}px", left: "#{@unit *  -9}px" }
        when "Triangle"
          switch @color
            when "Blue"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -6}px", left: "#{@unit * -10}px" }
                when "1", "Medium"  then { top: "#{@unit *  -6}px", left: "#{@unit * -11}px" }
                when "2", "Small"   then { top: "#{@unit *  -6}px", left: "#{@unit * -12}px" }
            when "Green"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -6}px", left: "#{@unit * -13}px" }
                when "1", "Medium"  then { top: "#{@unit *  -7}px", left: "#{@unit *  -0}px" }
                when "2", "Small"   then { top: "#{@unit *  -7}px", left: "#{@unit *  -1}px" }
            when "Brown"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -7}px", left: "#{@unit *  -2}px" }
                when "1", "Medium"  then { top: "#{@unit *  -7}px", left: "#{@unit *  -3}px" }
                when "2", "Small"   then { top: "#{@unit *  -7}px", left: "#{@unit *  -4}px" }
            when "Red"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -7}px", left: "#{@unit *  -5}px" }
                when "1", "Medium"  then { top: "#{@unit *  -7}px", left: "#{@unit *  -6}px" }
                when "2", "Small"   then { top: "#{@unit *  -7}px", left: "#{@unit *  -7}px" }
            when "White"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -7}px", left: "#{@unit *  -8}px" }
                when "1", "Medium"  then { top: "#{@unit *  -7}px", left: "#{@unit *  -9}px" }
                when "2", "Small"   then { top: "#{@unit *  -7}px", left: "#{@unit * -10}px" }
            when "Yellow"
              switch @size
                when "0", "Largest" then { top: "#{@unit *  -7}px", left: "#{@unit * -11}px" }
                when "1", "Medium"  then { top: "#{@unit *  -7}px", left: "#{@unit * -12}px" }
                when "2", "Small"   then { top: "#{@unit *  -7}px", left: "#{@unit * -13}px" }
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
