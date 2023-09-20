import { event } from "vue-gtag"

/**
 * send event to Gtag with value.
 * @remarks it work when NODE_ENV is production.
 * @param action
 * @param value
 */
const eventGtag = (action: string, value?: string): void => {
  if (process.env.NODE_ENV === "production") event(action, { method: "Google", value })
}

export { eventGtag }
