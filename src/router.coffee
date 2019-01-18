import Vue from "vue"
import Router from "vue-router"

import Home          from "./views/Home.vue"
import Script        from "./views/Script.vue"
import ScriptEditor  from "./views/ScriptEditor.vue"
import ScriptPreview from "./views/ScriptPreview.vue"
import ScriptText    from "./views/ScriptText.vue"
import Variable      from "./views/Variable.vue"
import Color         from "./views/Color.vue"
import Property      from "./views/Property.vue"

Vue.use Router

export default new Router
  linkActiveClass: "-current"
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
          alias: "/"
        }
        {
          path: "preview",
          component: ScriptPreview
        }
        {
          path: "text",
          component: ScriptText
        }
      ]
    }
    {
      path: "/variable"
      name: "variable"
      component: Variable
    }
    {
      path: "/color"
      name: "color"
      component: Color
    }
    {
      path: "/property"
      name: "property"
      component: Property
    }
  ]
