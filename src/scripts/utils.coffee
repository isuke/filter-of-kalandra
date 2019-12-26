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

leftPad = (val, str = '0', num = 2) ->
  (str.repeat(num) + val).slice(- num)

hexToRGB = (val) ->
  regexp = /#(([0-9]|[a-f]){2})(([0-9]|[a-f]){2})(([0-9]|[a-f]){2})/i
  match = regexp.exec(val)
  [
    Number.parseInt(match[1], 16),
    Number.parseInt(match[3], 16),
    Number.parseInt(match[5], 16)
  ]

rgbToHex = (val) ->
  "##{leftPad(val[0].toString(16))}#{leftPad(val[1].toString(16))}#{leftPad(val[2].toString(16))}"

download = (fileName, content, mime) ->
  downLoadLink = document.createElement("a")
  downLoadLink.download = fileName
  downLoadLink.href = URL.createObjectURL new Blob([content], type: mime)
  downLoadLink.dataset.downloadurl = [mime, downLoadLink.download, downLoadLink.href].join(":")
  downLoadLink.click()

export { forIn, round, isEmpty, leftPad, hexToRGB, rgbToHex, download }
