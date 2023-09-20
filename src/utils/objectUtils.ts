/**
 * return true when value is empty array or empty object.
 * @param value
 * @returns
 * return true when value is empty array or empty object.
 * otherwise, EcmaScript-specific comparisons are performed
 */
const isEmpty = (value: unknown): boolean => {
  if (Array.isArray(value)) {
    return value.length === 0
  } else if (typeof value === "object") {
    return Object.keys(value as object).length === 0
  } else {
    return !value
  }
}

export { isEmpty }
