import Vue from "vue"
import Router from "vue-router"

import Script        from "./views/Script.vue"
import ScriptEditor  from "./views/ScriptEditor.vue"
import ScriptPreview from "./views/ScriptPreview.vue"
import ScriptText    from "./views/ScriptText.vue"

Vue.use Router

export default new Router
  mode: 'history'
  linkActiveClass: "-current"
  routes: [
    {
      path: "/"
      name: "home"
      component: => `import(/* webpackChunkName: "home"*/ "./views/Home.vue")`
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
      component: => `import(/* webpackChunkName: "variable"*/ "./views/Variable.vue")`
    }
    {
      path: "/color"
      name: "color"
      component: => `import(/* webpackChunkName: "color"*/ "./views/Color.vue")`
    }
    {
      path: "/property"
      name: "property"
      component: => `import(/* webpackChunkName: "property"*/ "./views/Property.vue")`
    }
    {
      path: "/setting"
      name: "setting"
      component: => `import(/* webpackChunkName: "setting"*/ "./views/Setting.vue")`
    }
  ]
