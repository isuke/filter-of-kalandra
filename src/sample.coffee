export default
  advancedScriptText: """
#
# Usage
#

# Tala moana!
# Filter of Kalandra is next level filter generator.


## Simple Usage

# The simplest filter is applied as follows

Show "Simple Example"
    Class "Currency"
    SetBackgroundColor 50 0 0 255

# It is almost the same as conventional writing style,
# but you need a name after 'Show'.
# This name is required.

# This Script is converted as follows by compile.

#: ################################################################################
#: # Simple Example                                                               #
#: ################################################################################
#: Show
#:     Class "Currency"
#:     SetBackgroundColor 50 0 0 255

## Variable

# Please click the 'Variable' on the top menu.
# (Pleace click the 'Script' and return here after check 'Variable' page.)
# You will be able to find names like 'Currencies' or 'White Gems' and more.
# These are 'Variable'.
# You can use these by 'Var' keyword.

Show "Variable Example"
    Class "Gem"
    BaseType Var("White Gems")
    SetBackgroundColor 255 255 255 255

# This Script is converted as follows by compile.

#: ################################################################################
#: # Variable Example                                                             #
#: ################################################################################
#: Show
#:     Class "Gem"
#:     BaseType "Portal" "Detonate Mines"
#:     SetBackgroundColor 255 255 255 255

# You can add/remove variables free.


## Color

# Please click the 'Color' on the top menu.
# This page makes color management easier.
# How to use 'Color' is exactly the same as 'Variable'.

Show "Color Example"
    Class "Currency"
    SetBackgroundColor 50 0 0 255
    SetTextColor Var("Currency Color")

#: ################################################################################
#: # Color Example                                                                #
#: ################################################################################
#: Show
#:     Class "Currency"
#:     SetBackgroundColor 50 0 0 255
#:     SetTextColor 170 158 130 255


## Property

# Please click the 'Property' on the top menu.
# You will be able to find script names, 'T1' and 'T2'.
# And you can also find some property names and values.
# These are 'Property'.

# You can use these by 'Prop' keyword.

Show "Property Example"
    Class "Map"
    MapTier >= Prop("Show Map Tire")
    SetBackgroundColor 10 10 10 255

# This Script is converted as follows TWO FILES by compile.

#: ################################################################################
#: # Property Example                                                             #
#: ################################################################################
#: Show
#:     Class "Map"
#:     MapTier >= 0
#:     SetBackgroundColor 10 10 10 255

#: ################################################################################
#: # Property Example                                                             #
#: ################################################################################
#: Show
#:     Class "Map"
#:     MapTier >= 11
#:     SetBackgroundColor 10 10 10 255

# This generator can create multiple files at once!

# You can add/remove property free.
# However, the maximum number of scripts is two (Current version).


## Mixin

# 'Mixin' is very important keyword.
# First, please look at the script below.

Show "Mixin Example"
    Class "Gem"
    SetBorderColor       Var("Skill Gem Color")
    SetTextColor         255 255 255
    SetBackgroundColor   Var("Skill Gem Color")
    SetFontSize 32

    Mixin "Level"
        Show "High Level"
            GemLevel >= 18
            SetFontSize 38
        Show "Middle Level"
            GemLevel >= 10
            SetFontSize 36

# This Script is converted as follows by compile.

#: ################################################################################
#: # Mixin Example                                                                #
#: ################################################################################
#: # Level is "High Level"
#: Show
#:     Class "Gem"
#:     GemLevel >= 18
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 38
#:
#: # Level is "Middle Level"
#: Show
#:     Class "Gem"
#:     GemLevel >= 10
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 36
#:
#: # Level is Any
#: Show
#:     Class "Gem"
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 32

# This means that all Gem colors are specified,
# while those with GemLevel equal to or larger than 18 are setFontSize 38,
# and those with GemLevel equal to or larger than 10 are indicated with SetFontSize 36.

# Let's see a more complicated example.

Show "Complex Mixin Example"
    Class "Gems"
    SetBorderColor       Var("Skill Gem Color")
    SetTextColor         255 255 255
    SetBackgroundColor   Var("Skill Gem Color")
    SetFontSize 32

    Mixin "Level"
        Show "High Level"
            GemLevel >= 18
            SetFontSize 38
        Show "Middle Level"
            GemLevel >= 10
            SetFontSize 36

    Mixin "Special"
        Show "Drop Only"
            BaseType Var("Drop Only Gems")
            SetBorderColor 70 70 0
        Show "'E' Series"
            BaseType Var("'E' Series Gems")
            SetBorderColor 70 0 0

# This Script is converted as follows by compile.

#: ################################################################################
#: # Complex Mixin Example                                                        #
#: ################################################################################
#: # Level is "High Level" - Special is "Drop Only"
#: Show
#:     Class "Gems"
#:     GemLevel >= 18
#:     BaseType "#'E' Series Gems" "#White Gems" "Added Chaos Damage Support" "Vaal"
#:     SetBorderColor 70 70 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 38
#:
#: # Level is "High Level" - Special is "'E' Series"
#: Show
#:     Class "Gems"
#:     GemLevel >= 18
#:     BaseType "Enhance Support" "Enlighten Support" "Empower Support"
#:     SetBorderColor 70 0 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 38
#:
#: # Level is "High Level" - Special is Any
#: Show
#:     Class "Gems"
#:     GemLevel >= 18
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 38
#:
#: # Level is "Middle Level" - Special is "Drop Only"
#: Show
#:     Class "Gems"
#:     GemLevel >= 10
#:     BaseType "#'E' Series Gems" "#White Gems" "Added Chaos Damage Support" "Vaal"
#:     SetBorderColor 70 70 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 36
#:
#: # Level is "Middle Level" - Special is "'E' Series"
#: Show
#:     Class "Gems"
#:     GemLevel >= 10
#:     BaseType "Enhance Support" "Enlighten Support" "Empower Support"
#:     SetBorderColor 70 0 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 36
#:
#: # Level is "Middle Level" - Special is Any
#: Show
#:     Class "Gems"
#:     GemLevel >= 10
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 36
#:
#: # Level is Any - Special is "Drop Only"
#: Show
#:     Class "Gems"
#:     BaseType "#'E' Series Gems" "#White Gems" "Added Chaos Damage Support" "Vaal"
#:     SetBorderColor 70 70 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 32
#:
#: # Level is Any - Special is "'E' Series"
#: Show
#:     Class "Gems"
#:     BaseType "Enhance Support" "Enlighten Support" "Empower Support"
#:     SetBorderColor 70 0 0 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 32
#:
#: # Level is Any - Special is Any
#: Show
#:     Class "Gems"
#:     SetBorderColor 27 162 155 255
#:     SetTextColor 255 255 255 255
#:     SetBackgroundColor 27 162 155 255
#:     SetFontSize 32

# This means that gems with 'High Level' AND 'Drop Only' gets SetFontSize 36 AND SetBorderColor is yellow.

# Mixin can nest.

Hide "Nested Mixin Example"
    Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"

    Mixin "Rarity"
        Hide "Rare"
            Rarity Rare
            SetFontSize 45
            PlayEffect Yellow Temp

            Mixin "Shaper/Elder"
                Show "Shaper"
                    ShaperItem True
                    SetBackgroundColor 0 0 255 200
                    PlayEffect White
                Show "Elder"
                    ElderItem True
                    SetBackgroundColor 20 20 255 200
                    PlayEffect White
        Hide "Magic"
            Rarity Magic
            SetFontSize 36
        Hide "Normal"
            Rarity Normal
            SetFontSize 18

# This Script is converted as follows by compile.

#: ################################################################################
#: # Nested Mixin Example                                                         #
#: ################################################################################
#: # Rarity is "Rare" - Shaper/Elder is "Shaper"
#: Show
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     Rarity Rare
#:     ShaperItem True
#:     SetFontSize 45
#:     PlayEffect White
#:     SetBackgroundColor 0 0 255 200
#:
#: # Rarity is "Rare" - Shaper/Elder is "Elder"
#: Show
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     Rarity Rare
#:     ElderItem True
#:     SetFontSize 45
#:     PlayEffect White
#:     SetBackgroundColor 20 20 255 200
#:
#: # Rarity is "Rare" - Shaper/Elder is Any
#: Hide
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     Rarity Rare
#:     DisableDropSound True
#:     SetFontSize 45
#:
#: # Rarity is "Magic"
#: Hide
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     Rarity Magic
#:     DisableDropSound True
#:     SetFontSize 36
#:
#: # Rarity is "Normal"
#: Hide
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     Rarity Normal
#:     DisableDropSound True
#:     SetFontSize 18
#:
#: # Rarity is Any
#: Hide
#:     Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"
#:     DisableDropSound True
#:

  """
  properties: {
    scriptNames: ["T1", "T2"]
    propNames: ["Show Map Tire"]
    values: [
      [ 0 ]
      [ 11 ]
    ]
  }
