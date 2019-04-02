<template lang="pug">
header.the-global-header
  router-link.item.logo(tag="h1", to="/", exact) Filter of Kalandra
  nav.nav
    ul.list
      router-link.item.script(tag="li", to="/script") Script
      router-link.item.variable(tag="li", to="/variable") Variable
      router-link.item.color(tag="li", to="/color") Color
      router-link.item.property(tag="li", to="/property") Property
      router-link.item.setting(tag="li", to="/setting") Setting
  .actions
    button.button.import(@click.prevent="$refs.importAllModal.open()") Import
    button.button.export(@click.prevent="exportAll") Export

  simple-modal.modal.import(
    ref="importAllModal",
    headerStr="Import",
    execStr="Import",
    :canExec="canOverwrite",
    @exec="importAll"
  )
    template(v-slot:content)
      .group
        input.checkbox(:id="`canOverwrite-${_uid}`", type="checkbox", v-model="canOverwrite")
        label.label.-attention(:for="`canOverwrite-${_uid}`") All exists data are removed when import JSON !
      .group
        input.radio(:id="`importType-dir-${_uid}`", type="radio", :name="`importType-${_uid}`", value="dir", v-model="importType")
        label.label(:for="`importType-dir-${_uid}`") Import Folder
        input.radio(:id="`importType-zip-${_uid}`", type="radio", :name="`importType-${_uid}`", value="zip", v-model="importType")
        label.label(:for="`importType-zip-${_uid}`") Import Zip
      .group
        input.file(v-show="importType == 'dir'", type="file", @change="changeImportFileList", webkitdirectory)
        input.file(v-show="importType == 'zip'", type="file", @change="changeImportZipFile", accept=".zip")
</template>

<script lang="coffee">
import SimpleModal from "@/components/SimpleModal.vue"

export default
  data: ->
    canOverwrite: false
    importType: 'dir'
    importFileList: undefined
    importZipFile: undefined
  components:
    "simple-modal": SimpleModal
  methods:
    changeImportFileList: (event) -> @importFileList = event.target.files
    changeImportZipFile:  (event) -> @importZipFile  = event.target.files[0]
    importAll: ->
      @$ga.event('import button', 'click') if process.env.NODE_ENV == "production"
      if @importType == 'dir'
        @$store.dispatch 'importAllFromFileList',
          fileList: @importFileList
          callback: => @$emit('add-toaster', "completed to import")
      else
        @$store.dispatch 'importAllFromZip',
          file: @importZipFile
          callback: => @$emit('add-toaster', "completed to import")
      @$refs.importAllModal.close('execed')
      @canOverwrite = false
    exportAll: ->
      @$ga.event('export button', 'click') if process.env.NODE_ENV == "production"
      @$emit('add-toaster', "started to export")
      setTimeout =>
        @$store.dispatch 'exportAll'
      , 600 # $duration-slow

</script>

<style lang="scss" scoped>
.the-global-header {
  display: inline-flex;
  flex-direction: row;
  align-items: stretch;
  padding-left:   var(--space-size-l);
  padding-right:  var(--space-size-l);
  background-color: $global-bg-color-night;
  color: $global-ft-color-night;

  .logo {
    align-self: center;
    padding-top:    var(--space-size-s);
    padding-bottom: var(--space-size-s);
    padding-right:  var(--space-size-l);
    font-size: var(--ft-size-l);
    cursor: pointer;

    &::after {
      content: "(α)";
      font-style: italic;
      font-size: var(--ft-size-m);
    }
  }

  > .nav {
    flex: 1;
    display: inline-flex;
    align-items: stretch;

    > .list {
      flex: 1;
      display: inline-flex;
      align-items: stretch;

      > .item {
        flex: 1;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        @ghost padding-left-right(var(--space-size-m));
        padding-bottom: var(--space-size-xs);
        @ghost border-top-radius(#{$border-radius-base});
        margin-top: var(--space-size-xs);
        cursor: pointer;

        &.script.-current   { @include bg-ft-color($script-color-hue  , "night"); }
        &.variable.-current { @include bg-ft-color($variable-color-hue, "night"); }
        &.color.-current    { @include bg-ft-color($color-color-hue   , "night"); }
        &.property.-current { @include bg-ft-color($property-color-hue, "night"); }
        &.setting.-current {
          background-color: $global-bg-color-day;
          color: $global-ft-color-day
        }
      }
    }
  }

  > .actions {
    display: inline-flex;
    align-items: center;

    > .button {
      @include button-skelton($global-accent-color-hue, "night");
      margin-left: var(--space-size-m);

      &.import {
        &::after { content: " ..."; }
      }
    }
  }
}

.the-global-header > .modal {
  /deep/ .content {
    display: flex;
    flex-direction: column;

    > .group {
      display: flex;
      flex-direction: row;

      &:not(:first-child) { margin-top: var(--space-size-m); }

      > .label {
        margin-right: 1em;

        &.-attention {
          color: $error-ft-color;
        }
      }

      > .checkbox {
        margin-right: 1em;
      }

      > .radio {
        margin-right: 1em;
      }

      > .file { /* no-op */ }
    }
  }
}
</style>
