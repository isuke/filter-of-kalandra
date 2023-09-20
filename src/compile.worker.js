import { version, getObject, compile } from "advanced-poe-filter" // eslint-disable-line import/named -- TODO: fix advanced-poe-filter

console.info(`load: Advanced PoE Filter (Ver: ${version})`)

self.addEventListener("message", (event) => {
  try {
    let result
    if (event.data.type === "Object") {
      result = getObject(event.data.advancedScriptText, event.data.variables, event.data.properties, event.data.filterInfo, event.data.options)
    } else if (event.data.type === "Text") {
      result = compile(event.data.advancedScriptText, event.data.variables, event.data.properties, event.data.filterInfo, event.data.options)
    } else {
      console.error(`Unknown type: \`${event.data.type}\``)
    }
    self.postMessage({ status: "success", type: event.data.type, result })
  } catch (error) {
    if (error.name === "SyntaxError") {
      const syntaxError = error

      self.postMessage({
        status: "fail",
        result: {
          name: "SyntaxError",
          type: event.data.type,
          message: syntaxError.message,
          location: syntaxError.location,
        },
      })
    } else {
      self.postMessage({
        status: "fail",
        result: {
          name: "UnknownError",
          type: event.data.type,
          message: error.message,
        },
      })
    }
  }
})
