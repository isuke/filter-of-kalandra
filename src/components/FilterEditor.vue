<template lang="pug">
.filer-editor
  .textarea(ref="textarea")
</template>

<script lang="coffee">
import debounce from "lodash.debounce"

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
    syntaxError:
      type: Object
      required: false
      default: -> undefined
  data: ->
    editor: undefined
  watch:
    syntaxError: (e) -> null # TODO
  methods:
    createMonaco: ->
      `import(/* webpackChunkName: "monaco" */ "monaco-editor")`.then (monaco) =>
        @editor = monaco.editor.create @$refs.textarea,
          value: @value
          theme: "advancedPoeFilterTheme"
          language: "advancedPoeFilter"
          wordWrap: 'bounded'
          wordWrapColumn: 160
          wordWrapMinified: true
          wrappingIndent: "indent"

        @editor.onDidChangeModelContent debounce =>
          @$emit 'change', @editor.getValue()

        window.editor = @editor # HACK
    scrollToSection: (sectionName) ->
      match = @editor.getModel().findMatches(new RegExp("^(Show|Hide) \"#{sectionName}\""), null, true, true, null, false, 1)[0]
      if match
        lineNumber = match.range.startLineNumber
        @editor.revealPositionInCenter(lineNumber: lineNumber, column: 1)
        @editor.setPosition(lineNumber: lineNumber, column: 1)
        @editor.focus()
  mounted: ->
    @createMonaco()
</script>

<style lang="scss" scoped>
.filer-editor {
  height: 100%;

  > .textarea {
    height: 100%;
  }
}
</style>
