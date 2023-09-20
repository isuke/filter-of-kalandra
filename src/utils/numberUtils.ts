/**
 * Round to the specified fraction digits
 * @param val
 * @param fractionDigits
 * @returns
 */
const round = (val: number | undefined, fractionDigits: number = 2): number | undefined => {
  if (!val) return undefined

  const digit = Math.pow(10, fractionDigits)
  return Math.round(val * digit) / digit
}

export { round }
