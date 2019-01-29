export default
  advancedScriptText: """
# Sample Script For Debug

Hide "Curerncies"
    Class "Currencies"
    BaseType Var("Sublime Currencies") Var("Lofty Currencies") Var("Precious Currencies") Var("Trivial Currencies") Var("Cheap Currencies")
    SetTextColor Var("Currency Color")
    SetBackgroundColor 0 0 0

    Mixin "Rareness"
        Show "Sublime"
            BaseType Var("Sublime Currencies")
            PlayAlertSound 1 300
            SetFontSize Plus(6)
            SetTextColor Negate()
            SetBackgroundColor Negate()

            Mixin "BaseType"
                Show "Mirror of Kalandra"
                    BaseType "Mirror of Kalandra"
                    PlayAlertSound ShMirror 300
                Show "Divine Orb"
                    BaseType "Divine Orb"
                    PlayAlertSound ShDivine 300
        Show "Lofty"
            BaseType Var("Lofty Currencies")
            PlayAlertSound 2 300
            SetFontSize Plus(4)

            Mixin "BaseType"
                Show "Chaos Orb"
                    BaseType "Chaos Orb"
                    PlayAlertSound ShChaos 300
        Show "Precious"
            BaseType Var("Precious Currencies")
            PlayAlertSound 3 300
            SetFontSize Plus(2)
        Show "Trivial"
            BaseType Var("Trivial Currencies")
        Hide "Cheap"
            BaseType Var("Cheap Currencies")

Show "Maps"
    Class "Maps"
    MapTier > Prop("Map Tire")
    Identified False
    SetBorderColor 250 251 252
    PlayAlertSound 1 300

Show "Gems"
    Class "Gems"
    SetBorderColor       Var("Skill Gem Color")
    SetTextColor         255 255 255
    SetBackgroundColor   Var("Skill Gem Color")
    SetFontSize 32

    Mixin "Level"
        Show "High Level"
            GemLevel >= 18
            SetBorderColor     Lighten(100%)
            SetTextColor       Negate()
            SetBackgroundColor Lighten(100%)
            SetFontSize Plus(6)
            MinimapIcon 1 Green Diamond

    Mixin "Special"
        Show "Drop Only"
            BaseType Var("Drop Only Gems")
            SetBorderColor     255 0 0
            SetTextColor       Negate()
            SetBackgroundColor Lighten(100%)
            MinimapIcon 1 Green Diamond
        Show "'E' Series"
            BaseType Var("'E' Series Gems")
            SetBorderColor     0 0 255
            SetTextColor       Negate()
            SetBackgroundColor Lighten(100%)
            SetFontSize Plus(6)
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
      name: "Sublime Currencies"
      items: [
        "Albino Rhoa Feather"
        "Divine Orb"
        "Exalted Orb"
        "Mirror of Kalandra"
        "Orb of Annulment"
      ]
    }
    {
      name: "Lofty Currencies"
      items: [
        "Blessed Orb"
        "Cartographer's Chisel"
        "Chaos Orb"
        "Gemcutter's Prism"
        "Orb of Alchemy"
        "Orb of Fusing"
        "Orb of Regret"
        "Orb of Scouring"
        "Regal Orb"
        "Vaal Orb"
      ]
    }
    {
      name: "Precious Currencies"
      items: [
        "Chromatic Orb"
        "Glassblower's Bauble"
        "Jeweller's Orb"
        "Orb of Alteration"
        "Orb of Chance"
        "Silver Coin"
      ]
    }
    {
      name: "Trivial Currencies"
      items: [
        "Armourer's Scrap"
        "Blacksmith's Whetstone"
        "Orb of Augmentation"
        "Orb of Transmutation"
      ]
    }
    {
      name: "Cheap Currencies"
      items: [
        "Portal Scroll"
        "Scroll of Wisdom"
      ]
    }

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
  colors: []
  properties: {
    scriptNames: ["T1", "T2"]
    propNames: ["Map Tire", "Hoge2", "Hoge3"]
    values: [
      [ 1, "test1", ["a", "b", "c"] ]
      [ 2, "test2", ["x", "y", "z"] ]
    ]
  }
