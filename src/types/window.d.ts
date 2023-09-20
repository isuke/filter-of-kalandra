import Monaco from "monaco-editor"

export declare global {
  interface Window {
    editor: Monaco.editor.IStandaloneCodeEditor
  }
}
