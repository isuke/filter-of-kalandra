forIn = (object, callback) =>
  Object.keys(object).forEach (key) =>
    callback(object[key], key)

round = (val, precision = 2) ->
  digit = Math.pow(10, precision)
  Math.round(val * digit) / digit

isEmpty = (val) ->
  if Array.isArray val
    val.length == 0
  else if typeof val == 'object'
    Object.key(val).length == 0
  else
    !val

download = (fileName, content, mime) ->
  downLoadLink = document.createElement("a")
  downLoadLink.download = fileName
  downLoadLink.href = URL.createObjectURL new Blob([content], type: mime)
  downLoadLink.dataset.downloadurl = [mime, downLoadLink.download, downLoadLink.href].join(":")
  downLoadLink.click()

export { forIn, round, isEmpty, download }
