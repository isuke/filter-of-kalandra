import Sh01      from "@/assets/sounds/Sh01.webm"
import Sh02      from "@/assets/sounds/Sh02.webm"
import Sh03      from "@/assets/sounds/Sh03.webm"
import Sh04      from "@/assets/sounds/Sh04.webm"
import Sh05      from "@/assets/sounds/Sh05.webm"
import Sh06      from "@/assets/sounds/Sh06.webm"
import Sh07      from "@/assets/sounds/Sh07.webm"
import Sh08      from "@/assets/sounds/Sh08.webm"
import Sh09      from "@/assets/sounds/Sh09.webm"
import Sh10      from "@/assets/sounds/Sh10.webm"
import Sh11      from "@/assets/sounds/Sh11.webm"
import Sh12      from "@/assets/sounds/Sh12.webm"
import Sh13      from "@/assets/sounds/Sh13.webm"
import Sh14      from "@/assets/sounds/Sh14.webm"
import Sh15      from "@/assets/sounds/Sh15.webm"
import Sh16      from "@/assets/sounds/Sh16.webm"
import ShAlchemy from "@/assets/sounds/ShAlchemy.webm"
import ShBlessed from "@/assets/sounds/ShBlessed.webm"
import ShChaos   from "@/assets/sounds/ShChaos.webm"
import ShDivine  from "@/assets/sounds/ShDivine.webm"
import ShExalted from "@/assets/sounds/ShExalted.webm"
import ShFusing  from "@/assets/sounds/ShFusing.webm"
import ShGeneral from "@/assets/sounds/ShGeneral.webm"
import ShMirror  from "@/assets/sounds/ShMirror.webm"
import ShRegal   from "@/assets/sounds/ShRegal.webm"
import ShVaal    from "@/assets/sounds/ShVaal.webm"

export default
  methods:
    sound: (id, volume = 150) ->
      audioElem = new Audio()
      audioElem.src = switch id
        when  1,  "1", "Sh01" then Sh01
        when  2,  "2", "Sh02" then Sh02
        when  3,  "3", "Sh03" then Sh03
        when  4,  "4", "Sh04" then Sh04
        when  5,  "5", "Sh05" then Sh05
        when  6,  "6", "Sh06" then Sh06
        when  7,  "7", "Sh07" then Sh07
        when  8,  "8", "Sh08" then Sh08
        when  9,  "9", "Sh09" then Sh09
        when 10, "10", "Sh10" then Sh10
        when 11, "11", "Sh11" then Sh11
        when 12, "12", "Sh12" then Sh12
        when 13, "13", "Sh13" then Sh13
        when 14, "14", "Sh14" then Sh14
        when 15, "15", "Sh15" then Sh15
        when 16, "16", "Sh16" then Sh16
        when "ShAlchemy" then ShAlchemy
        when "ShBlessed" then ShBlessed
        when "ShChaos"   then ShChaos
        when "ShDivine"  then ShDivine
        when "ShExalted" then ShExalted
        when "ShFusing"  then ShFusing
        when "ShGeneral" then ShGeneral
        when "ShMirror"  then ShMirror
        when "ShRegal"   then ShRegal
        when "ShVaal"    then ShVaal
      audioElem.volume = volume / 300
      audioElem.play()
