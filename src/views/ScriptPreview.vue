<template lang="pug">
.script-preview
  .section(v-for="sectionName in $store.getters.sectionNames")
    h1 {{ sectionName }}

    table.table
      thead.head
        tr.row
          th.head Block Name \ Script Name
          td.scriptname(v-for="scriptName in $store.getters.scriptNames") {{ scriptName }}
      tbody.body
        tr.row(v-for="block in $store.getters.blocks('No Name', sectionName)")
          th.blockname {{ getBlockNameStr(block.name) }}
          td.preveiw
            img.image(src="https://via.placeholder.com/160x64/B46000/707070")
            span.item(:style="getStyle(block)") Item Name
</template>

<script lang="coffee">
# TODO: move to utils
forIn = (object, callback) =>
  Object.keys(object).forEach (key) => callback(object[key], key)

export default
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
          "border": "1px #{@getColorStr(block.actions.SetBorderColor)} solid"  if block.actions.SetBorderColor
          "color": @getColorStr(block.actions.SetTextColor)                    if block.actions.SetTextColor
          "background-color": @getColorStr(block.actions.SetBackgroundColor)   if block.actions.SetBackgroundColor
          "font-size": "#{Math.round(block.actions.SetFontSize / 2)}px"                    if block.actions.SetFontSize
        }
      else
        {
          display: 'none'
        }
    getColorStr: (colorObject) ->
      "##{colorObject.rgb.r.toString(16)}#{colorObject.rgb.g.toString(16)}#{colorObject.rgb.b.toString(16)}" # TODO: alpha
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
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;

            > .image {}
            > .item {
              position: absolute;
              padding: 0.5em;
              opacity: 0.5;
              background-color: black;
              color: white;
              font-size: 11px;
            }
          }
        }
      }
    }
  }
}
</style>
