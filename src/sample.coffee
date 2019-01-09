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
    SetBorderColor       27 162 155
    SetTextColor         27 162 155
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
  properties: {
    scriptNames: ["No Name", "T2"]
    propNames: ["Map Tire", "Hoge2", "Hoge3"]
    values: [
      [ 1, "test1", ["a", "b", "c"] ]
      [ 2, "test2", ["x", "y", "z"] ]
    ]
  }
