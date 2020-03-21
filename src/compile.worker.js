import * as advancedPoeFilter from '@fok/advanced-poe-filter'

console.log(`load: Advanced PoE Filter (Ver: ${advancedPoeFilter.version})`)

self.addEventListener('message', (event) => {
  try {
    let result = undefined
    if (event.data.type === 'Object') {
      result = advancedPoeFilter.getObject(
        event.data.advancedScriptText,
        event.data.variables,
        event.data.properties,
        event.data.filterInfo,
        event.data.options
      )
    } else if (event.data.type === 'Text') {
      result = advancedPoeFilter.compile(event.data.advancedScriptText, event.data.variables, event.data.properties, event.data.filterInfo, event.data.options)
    } else {
      console.error(`Unkown type: \`${event.data.type}\``)
    }
    self.postMessage({ status: 'success', type: event.data.type, result })
  } catch (error) {
    if (error.name === 'SyntaxError') {
      self.postMessage({
        status: 'fail',
        result: {
          name: 'SyntaxError',
          type: event.data.type,
          message: error.message,
          location: error.location,
        },
      })
    } else {
      self.postMessage({
        status: 'fail',
        result: {
          name: 'Error',
          type: event.data.type,
          message: error.message,
        },
      })
    }
  }
})
