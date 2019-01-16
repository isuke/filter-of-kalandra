<template lang="pug">
.script-preview
  .section(v-for="(scripts, sectionName) in simpleScriptObjectsForPreview")
    h1 {{ sectionName }}

    table.table
      thead.head
        tr.row
          th.head Block Name \ Script Name
          td.scriptname(v-for="scriptName in $store.getters.scriptNames") {{ scriptName }}
      tbody.body
        tr.row(v-for="(blocks, blockName) in scripts")
          th.blockname {{ blockName }}
          td.preveiw(v-for="(block, scriptName) in blocks")
            .image
              img.back(src="https://via.placeholder.com/160x64/B46000/707070")
              span.item(:style="getStyle(block)", @click.prevent="playAlertSound(block)") Item Name
</template>

<script lang="coffee">
import Color from "color"

import soundAudible from "@/mixins/soundAudible.coffee"

# TODO: move to utils
forIn = (object, callback) =>
  Object.keys(object).forEach (key) => callback(object[key], key)

export default
  mixins: [
    soundAudible
  ]
  computed:
    simpleScriptObjectsForPreview: ->
      result = {}
      forIn @$store.getters.simpleScriptObjects, (sections, scriptName) =>
        sections.forEach (section) =>
          result[section.name] = {} unless result[section.name]
          section.blocks.forEach (block) =>
            blockName = @getBlockNameStr(block.name)
            result[section.name][blockName] = {} unless result[section.name][blockName]
            result[section.name][blockName][scriptName] = {}
            result[section.name][blockName][scriptName].activity = block.activity
            result[section.name][blockName][scriptName].actions = block.actions
      result
  methods:
    getBlockNameStr: (blockNameObject) ->
      temp = []
      forIn blockNameObject, (val, key) =>
        if val
          temp.push("#{key} is \"#{val}\"")
        else
          temp.push("#{key} is Any")
      temp.join(' - ')
    getStyle: (block) ->
      if block.activity == 'Show'
        {
          "border": "0.2em #{@getColorStr(block.actions.SetBorderColor)} solid" if block.actions.SetBorderColor
          "color": @getColorStr(block.actions.SetTextColor)                     if block.actions.SetTextColor
          "background-color": @getColorStr(block.actions.SetBackgroundColor)    if block.actions.SetBackgroundColor
          "font-size": "#{Math.round(block.actions.SetFontSize / 2)}px"         if block.actions.SetFontSize
        }
      else
        {
          display: 'none'
        }
    getColorStr: (colorObject) ->
      color = new Color(colorObject.rgb)
      color.hex().replace('0x', '#') # TODO: alpha
    playAlertSound: (block) ->
      sound = if block.actions.PlayAlertSound
        block.actions.PlayAlertSound
      else if block.actions.PlayAlertSoundPositional
        block.actions.PlayAlertSoundPositional

      return unless sound

      @sound(sound.id, sound.volume)
</script>

<style lang="scss" scoped>
.script-preview {
  > .section {
    > .table {
      > .head {
        > .row {
          > .head {}
          > .scriptname {}
        }
      }
      > .body {
        > .row {
          > .blockname {}
          > .preveiw {
            > .image {
              display: flex;
              align-items: center;
              justify-content: center;
              position: relative;

              > .back {}
              > .item {
                position: absolute;
                margin: auto;
                padding: 0.5em;
                opacity: 0.5;
                background-color: black;
                color: white;
                font-size: 11px;
                cursor: pointer;
              }
            }
          }
        }
      }
    }
  }
}
</style>
