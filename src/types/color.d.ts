// MEMO: Expression produces a union type that is too complex to represent.
// type Hexadecimal = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "a" | "b" | "c" | "d" | "e" | "f"
// type HexadecimalTwoDigits = `${Hexadecimal}${Hexadecimal}`
// export type ColorHex = `#${HexadecimalTwoDigits}${HexadecimalTwoDigits}${HexadecimalTwoDigits}`
export type ColorHex = `#${string}`
export type ColorRGB = [number, number, number]
export type ColorRGBString = `${number} ${number} ${number}`
