export default
  advancedScriptText: """
# This is Comment
# This is Comment
Show "Maps"
    Class "Maps"
    MapTier > Prop("Map Tire")
    Identified False
    SetBorderColor 250 251 252
    PlayAlertSound 1 300

Hide "Gems"
    Class "Gems"
    SetBorderColor       Var("Skill Gem Color")
    SetTextColor         Var("Skill Gem Color")
    SetBackgroundColor    0   0   0

    Mixin "Level"
        Show "High Level"
            GemLevel >= 18
            SetBorderColor Darken(20%)
            SetTextColor   Darken(20%)
            MinimapIcon 1 Green Diamond

    Mixin "Quality"
        Show "High Level"
            GemLevel >= 10
            SetBorderColor Darken(20%)
            SetTextColor   Darken(20%)
            MinimapIcon 1 Green Diamond
        Show "Middle Level"
            GemLevel >= 1
            SetBorderColor Darken(10%)
            SetTextColor   Darken(10%)
            MinimapIcon 1 Green Diamond

    Mixin "Special"
        Show "Drop Only"
            BaseType Var("Drop Only Gems")
            SetBackgroundColor Lighten(10%)
            SetFontSize 42
            MinimapIcon 1 Green Diamond
        Show "'E' Series"
            BaseType Var("'E' Series Gems")
            SetBorderColor     Negate()
            SetTextColor       Negate()
            SetBackgroundColor Negate()
            SetFontSize 45
            MinimapIcon 2 Green Diamond

Hide "Gears"
    Class "Gloves" "Boots" "Body Armours" "Helmets" "Shields"

    Mixin "Rarity"
        Show "Rare"
            Rarity Rare
            SetFontSize 45
            PlayEffect Yellow Temp
        Hide "Magic"
            Rarity Magic
            SetFontSize 36
        Hide "Normal"
            Rarity Normal
            SetFontSize 18

    Mixin "BaseType"
        Show "Special BodyArmour"
            BaseType "Sacrificial Garb"
            SetBackgroundColor 100 100 255 255
            PlayAlertSound 1 300
            PlayEffect Blue
        Show "Special Glove and Boots"
            BaseType "Two-Toned Boots" "Spiked Gloves" "Gripped Gloves" "Fingerless Silk Gloves" "Bone Helmet"
            SetBackgroundColor 50 50 255 255
            PlayAlertSound 2 300
            PlayEffect Blue Temp

    Mixin "Sockets and Link"
        Show "6L"
            LinkedSockets = 6
            SetBorderColor 255 0 0 255
            PlayAlertSound 3 300
            PlayEffect Red
        Show "6S"
            Sockets = 6
            SetBorderColor 0 255 0 255
            PlayAlertSound 4 300
            PlayEffect Red
        Show "RGB"
            SocketGroup RGB
            SetBorderColor 0 0 255 255
            PlayAlertSound 5 100
            PlayEffect Red Temp

  """
  variables: [
    {
      name: "'E' Series Gems"
      items: [
        "Enhance Support"
        "Enlighten Support"
        "Empower Support"
      ]
    }
    {
      name: "White Gems"
      items: [
        "Portal"
        "Detonate Mines"
      ]
    }
    {
      name: "Drop Only Gems"
      items: [
        "#'E' Series Gems"
        "#White Gems"
        "Added Chaos Damage Support"
        "Vaal"
      ]
    }
    {
      name: "Vendor Only Gems"
      items: [
        "Block Chance Reduction Support"
        "Mirror Arrow"
      ]
    }
    {
      name: "Equipments"
      items: [
        "#Weapons"
        "#Gears"
        "#Accessories"
      ]
    }
    {
      name: "Weapons"
      items: [
        "#One Hand Weapons"
        "#Two Hand Weapons"
      ]
    }
    {
      name: "One Hand Weapons"
      items: [
        "Claws"
        "Daggers"
        "Wands"
        "One Hand Swords"
        "Thrusting One Hand Swords"
        "One Hand Axes"
        "One Hand Maces"
        "Sceptres"
      ]
    }
    {
      name: "Two Hand Weapons"
      items: [
        "Bows"
        "Staves"
        "Two Hand Swords"
        "Two Hand Axes"
        "Two Hand Maces"
        "Fishing Rods"
      ]
    }
    {
      name: "Gears"
      items: [
        "Gloves"
        "Boots"
        "Body Armours"
        "Helmets"
        "Shields"
        "Quivers"
      ]
    }
    {
      name: "Accessories"
      items: [
        "Belts"
        "Amulets"
        "Rings"
      ]
    }
    {
      name: "Six Sockets Equipments"
      items: [
        "#Two Hand Weapons"
        "Body Armours"
      ]
    }
    {
      name: "Four Sockets Equipments"
      items: [
        "Gloves"
        "Boots"
        "Helmets"
      ]
    }
    {
      name: "Three Sockets Equipments"
      items: [
        "#One Hand Weapons"
        "Shields"
      ]
    }
  ]
  colors: [
    { name: "Normal Item Color"            , hex: "#c8c8c8" } # rgb: 200, 200, 200
    { name: "Magic Item Color"             , hex: "#8888ff" } # rgb: 136, 136, 255
    { name: "Rare Item Color"              , hex: "#ffff77" } # rgb: 255, 255, 119
    { name: "Unique Item Color"            , hex: "#af6025" } # rgb: 175,  96,  37
    { name: "Skill Gem Color"              , hex: "#1ba29b" } # rgb:  27, 162, 155
    { name: "Currency Color"               , hex: "#aa9e82" } # rgb: 170, 158, 130
    { name: "Quest Item Color"             , hex: "#4ae63a" } # rgb:  74, 230, 58
    { name: "Divination Card Color"        , hex: "#0ebaff" } # rgb:  14, 186, 255
    { name: "Default Text Color"           , hex: "#7f7f7f" } # rgb: 127, 127, 127
    { name: "Value Text Color"             , hex: "#ffffff" } # rgb: 255, 255, 255
    { name: "Augmented Value Text Color"   , hex: "#8888ff" } # rgb: 136, 136, 255
    { name: "Fire Damage Color"            , hex: "#960000" } # rgb: 150,   0,   0
    { name: "Cold Damage Color"            , hex: "#366492" } # rgb:  54, 100, 146
    { name: "Lightning Damage Color"       , hex: "#ffd700" } # rgb: 255, 215,   0
    { name: "Chaos Damage Color"           , hex: "#d02090" } # rgb: 208,  32, 144
    { name: "Crafted Mod Color"            , hex: "#b8daf2" } # rgb: 184, 218, 242
    { name: "Corrupted Color"              , hex: "#d20000" } # rgb: 210,   0,   0
    { name: "Supporter Pack New Item Color", hex: "#b46000" } # rgb: 180,  96,   0
    { name: "Supporter Pack Item Color"    , hex: "#a38d6d" } # rgb: 163, 141, 109
    { name: "Nemesis Mod Color"            , hex: "#ffc800" } # rgb: 255, 200,   0
    { name: "Nemesis Mod Outline Color"    , hex: "#ff2800" } # rgb: 255,  40,   0
    { name: "Bloodline Mod Color"          , hex: "#d200dc" } # rgb: 210,   0, 220
    { name: "Bloodline Mod Outline Color"  , hex: "#4a00a0" } # rgb:  74,   0, 160
    { name: "Torment Mod Color"            , hex: "#32e664" } # rgb:  50, 230, 100
    { name: "Torment Mod Outline Color"    , hex: "#006496" } # rgb:   0, 100, 150
    { name: "Title Color"                  , hex: "#e7b478" } # rgb: 231, 180, 120
    { name: "Favour Color"                 , hex: "#aa9e78" } # rgb: 170, 158, 120
    { name: "Pink"                         , hex: "#ffc0cb" } # rgb: 255, 192, 203
    { name: "Dodger Blue"                  , hex: "#1e90ff" } # rgb:  30, 144, 255
  ]
  properties: {
    scriptNames: ["No Name", "T2"]
    propNames: ["Map Tire", "Hoge2", "Hoge3"]
    values: [
      [ 1, "test1", ["a", "b", "c"] ]
      [ 2, "test2", ["x", "y", "z"] ]
    ]
  }
