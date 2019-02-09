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
      viewportMargin: Infinity
      extraKeys:
        Tab: => @cm.execCommand 'insertSoftTab'
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

      @cm
    scrollToSection: (sectionName) ->
      regexp = new RegExp("(Show|Hide) \"#{sectionName}\"")
      keyDocs = document.getElementsByClassName('cm-m-advanced-poe-filter cm-keyword')
      [].forEach.call keyDocs, (keyDoc) =>
        if regexp.test keyDoc.textContent
          y = keyDoc.getBoundingClientRect().top - (48 + 48) # TODO: header height
          window.scrollBy 0, y
          return
  mounted: ->
    window._cm = @createCM() # HACK
</script>

<style lang="scss" scoped>
.filer-editor {
}
</style>
