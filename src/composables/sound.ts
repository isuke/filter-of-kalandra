import Sh01 from "@/assets/sounds/Sh01.webm"
import Sh02 from "@/assets/sounds/Sh02.webm"
import Sh03 from "@/assets/sounds/Sh03.webm"
import Sh04 from "@/assets/sounds/Sh04.webm"
import Sh05 from "@/assets/sounds/Sh05.webm"
import Sh06 from "@/assets/sounds/Sh06.webm"
import Sh07 from "@/assets/sounds/Sh07.webm"
import Sh08 from "@/assets/sounds/Sh08.webm"
import Sh09 from "@/assets/sounds/Sh09.webm"
import Sh10 from "@/assets/sounds/Sh10.webm"
import Sh11 from "@/assets/sounds/Sh11.webm"
import Sh12 from "@/assets/sounds/Sh12.webm"
import Sh13 from "@/assets/sounds/Sh13.webm"
import Sh14 from "@/assets/sounds/Sh14.webm"
import Sh15 from "@/assets/sounds/Sh15.webm"
import Sh16 from "@/assets/sounds/Sh16.webm"
import ShAlchemy from "@/assets/sounds/ShAlchemy.webm"
import ShBlessed from "@/assets/sounds/ShBlessed.webm"
import ShChaos from "@/assets/sounds/ShChaos.webm"
import ShDivine from "@/assets/sounds/ShDivine.webm"
import ShExalted from "@/assets/sounds/ShExalted.webm"
import ShFusing from "@/assets/sounds/ShFusing.webm"
import ShGeneral from "@/assets/sounds/ShGeneral.webm"
import ShMirror from "@/assets/sounds/ShMirror.webm"
import ShRegal from "@/assets/sounds/ShRegal.webm"
import ShVaal from "@/assets/sounds/ShVaal.webm"

import type * as advancedPoeFilterParser from "advanced-poe-filter-parser"

const playSound = (sound: advancedPoeFilterParser.Sound): void => {
  const audioElement = new Audio()
  switch (sound.id) {
    case "1":
    case "Sh01":
      audioElement.src = Sh01
      break
    case "2":
    case "Sh02":
      audioElement.src = Sh02
      break
    case "3":
    case "Sh03":
      audioElement.src = Sh03
      break
    case "4":
    case "Sh04":
      audioElement.src = Sh04
      break
    case "5":
    case "Sh05":
      audioElement.src = Sh05
      break
    case "6":
    case "Sh06":
      audioElement.src = Sh06
      break
    case "7":
    case "Sh07":
      audioElement.src = Sh07
      break
    case "8":
    case "Sh08":
      audioElement.src = Sh08
      break
    case "9":
    case "Sh09":
      audioElement.src = Sh09
      break
    case "10":
    case "Sh10":
      audioElement.src = Sh10
      break
    case "11":
    case "Sh11":
      audioElement.src = Sh11
      break
    case "12":
    case "Sh12":
      audioElement.src = Sh12
      break
    case "13":
    case "Sh13":
      audioElement.src = Sh13
      break
    case "14":
    case "Sh14":
      audioElement.src = Sh14
      break
    case "15":
    case "Sh15":
      audioElement.src = Sh15
      break
    case "16":
    case "Sh16":
      audioElement.src = Sh16
      break
    case "ShAlchemy":
      audioElement.src = ShAlchemy
      break
    case "ShBlessed":
      audioElement.src = ShBlessed
      break
    case "ShChaos":
      audioElement.src = ShChaos
      break
    case "ShDivine":
      audioElement.src = ShDivine
      break
    case "ShExalted":
      audioElement.src = ShExalted
      break
    case "ShFusing":
      audioElement.src = ShFusing
      break
    case "ShGeneral":
      audioElement.src = ShGeneral
      break
    case "ShMirror":
      audioElement.src = ShMirror
      break
    case "ShRegal":
      audioElement.src = ShRegal
      break
    case "ShVaal":
      audioElement.src = ShVaal
      break
  }
  audioElement.volume = (sound.volume || 0) / 300
  audioElement.play()
}

export { playSound }
