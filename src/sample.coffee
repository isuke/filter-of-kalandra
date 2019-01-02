export default {
  scriptText: """
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
            BaseType "Vaal" "Added Chaos Damage Support" "Detonate Mines" "Portal"
            SetBackgroundColor Lighten(10%)
            MinimapIcon 1 Green Diamond
        Show "'E' Series"
            BaseType "Enhance Support" "Enlighten Support" "Empower Support"
            SetBorderColor     Negate()
            SetTextColor       Negate()
            SetBackgroundColor Negate()
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
}
