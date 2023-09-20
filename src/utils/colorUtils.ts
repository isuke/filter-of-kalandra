import { ColorHex, ColorRGB } from "@/types/color"

const leftPad = (val: string | number, str: string = "0", num: number = 2): string => {
  return (str.repeat(num) + val).slice(-num)
}

/**
 * convert hex ex) `#ffffff` to rgb ex) `[255, 255, 255]`
 * @param val
 * @returns
 */
const hexToRGB = (val: ColorHex): ColorRGB => {
  const regexp = /#(([0-9]|[a-f]){2})(([0-9]|[a-f]){2})(([0-9]|[a-f]){2})/i
  const match = regexp.exec(val)

  if (!match) return [0, 0, 0]

  return [Number.parseInt(match[1], 16), Number.parseInt(match[3], 16), Number.parseInt(match[5], 16)]
}

/**
 * convert rgb ex) `[255, 255, 255]` to hex ex) `#ffffff`
 * @param val
 * @returns
 */
const rgbToHex = (val: ColorRGB): ColorHex => {
  return `#${leftPad(val[0].toString(16))}${leftPad(val[1].toString(16))}${leftPad(val[2].toString(16))}`
}

export { hexToRGB, rgbToHex }
