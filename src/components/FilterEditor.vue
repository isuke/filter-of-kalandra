<template lang="pug">
.filer-editor(:class="{ '-error': hasSyntaxError }")
  .textarea(ref="textarea")
    span.loading(v-if="!editor") Now Loading...
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
    errorDecorations: []
  watch:
    syntaxError: (error) ->
      if error
        if error.name == "SyntaxError"
          location = error.location
          @errorDecorations = @editor.deltaDecorations @errorDecorations, [
            {
              range: new monaco.Range(location.start.line, location.start.column, location.end.line, location.end.column)
              options:
                inlineClassName: "error"
                linesDecorationsClassName: "error-gutter"
                hoverMessage:
                  value: error.message
            }
          ]
        else
          console.error error
      else
        @editor.deltaDecorations @errorDecorations, []
        @errorDecorations = []
  computed:
    hasSyntaxError: -> !! @syntaxError
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
      match = @editor.getModel().findMatches(new RegExp("^(Show|Hide|Unset|Var|Prop)[^\n]+\"#{sectionName}\"$"), null, true, true, null, false, 1)[0]
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
  border: $border-height-bold $global-bg-color-day solid;

  &.-error {
    border: $border-height-bold $error-ft-color solid;
  }

  > .textarea {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;

    > .loading { font-size: var(--ft-size-l); }
  }
}
</style>
