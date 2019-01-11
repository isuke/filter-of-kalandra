<template lang="pug">
.filer-editor
  textarea.textarea(:value="value", ref="textarea")
</template>

<script lang="coffee">
import debounce from "lodash.debounce"
import CodeMirror from "codemirror"
import "codemirror/addon/selection/active-line"

export default
  model:
    prop: "value"
    event: "change"
  props:
    value:
      type: String
      required: true
    config:
      type: Object
      required: false
      default: -> {}
    mode:
      type: String
      required: false
      default: "advanced-poe-filter"
      validator: (value) -> ["advanced-poe-filter", "original-poe-filter"].includes value
    syntaxError:
      type: Object
      required: false
      default: -> undefined
  data: ->
    cm: undefined
    requireConf:
      indentUnit: 4
    defaultConf:
      smartIndent: false
      lineNumbers: true
      addModeClass: true
      styleActiveLine: true
    errorMark: undefined
  watch:
    value: (v) -> @cm.setValue v if @config.readOnly
    syntaxError: (e) ->
      @errorMark.clear() if @errorMark

      return unless e

      start = e.location.start
      end   = e.location.end
      startPos = { line: start.line - 1, ch: start.column - 1 }
      endPos   = { line: end.line   - 1, ch: 160 }
      @errorMark = @cm.markText startPos, endPos,
        className: 'cm-error'
  methods:
    createCM: ->
      conf = Object.assign { mode: @mode }, @defaultConf, @config, @requireConf

      @cm = CodeMirror.fromTextArea @$refs.textarea, conf

      @cm.setOption "styleActiveLine", nonEmpty: true

      @cm.on "change", debounce () =>
        @$emit 'change', @cm.getValue()
      , 500
  mounted: ->
    @createCM()
</script>

<style lang="scss" scoped>
.filer-editor {
}
</style>
