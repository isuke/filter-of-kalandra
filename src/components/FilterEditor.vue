<template lang="pug">
.filer-editor
  textarea.textarea(:value="value", ref="textarea")
</template>

<script lang="coffee">
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
  data: ->
    cm: undefined
    requireConf:
      indentUnit: 4
    defaultConf:
      smartIndent: false
      lineNumbers: true
      addModeClass: true
      styleActiveLine: true
  methods:
    createCM: ->
      conf = Object.assign { mode: @mode }, @defaultConf, @config, @requireConf

      @cm = CodeMirror.fromTextArea @$refs.textarea, conf

      @cm.setOption "styleActiveLine", nonEmpty: true

      @cm.on "change", => @$emit 'change', @cm.getValue()
  mounted: ->
    @createCM()
</script>

<style lang="scss" scoped>
.filer-editor {
}
</style>
