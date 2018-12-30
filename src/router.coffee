import Vue from "vue"
import Router from "vue-router"

import Home         from "./views/Home.vue"
import Script       from "./views/Script.vue"
import ScriptEditor from "./views/ScriptEditor.vue"
import ScriptText   from "./views/ScriptText.vue"

Vue.use Router

export default new Router
  routes: [
    {
      path: "/"
      name: "home"
      component: Home
    }
    {
      path: "/script"
      name: "script"
      component: Script
      children: [
        {
          path: "editor"
          component: ScriptEditor
        }
        {
          path: "text",
          component: ScriptText
        }
      ]
    }
  ]
