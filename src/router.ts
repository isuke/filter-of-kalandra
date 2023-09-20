import { createRouter, createWebHistory, RouteRecordRaw } from "vue-router"

import Script from "@/pages/Script.vue"
import ScriptEditor from "@/pages/ScriptEditor.vue"
import ScriptPreview from "@/pages/ScriptPreview.vue"
import ScriptText from "@/pages/ScriptText.vue"

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "home",
    component: () => import(/* webpackChunkName: "home"*/ "@/pages/Home.vue"),
  },
  {
    path: "/script",
    name: "script",
    component: Script,
    children: [
      {
        path: "editor",
        component: ScriptEditor,
        alias: "/script",
      },
      {
        path: "preview",
        component: ScriptPreview,
      },
      {
        path: "text",
        component: ScriptText,
      },
    ],
  },
  {
    path: "/variable",
    name: "variable",
    component: () => import(/* webpackChunkName: "variable"*/ "@/pages/Variable.vue"),
  },
  {
    path: "/color",
    name: "color",
    component: () => import(/* webpackChunkName: "color"*/ "@/pages/Color.vue"),
  },
  {
    path: "/property",
    name: "property",
    component: () => import(/* webpackChunkName: "property"*/ "@/pages/Property.vue"),
  },
  {
    path: "/setting",
    name: "setting",
    component: () => import(/* webpackChunkName: "setting"*/ "@/pages/Setting.vue"),
  },
]

// export default new Router({
//   mode: "history",
//   linkActiveClass: "-current",
//   scrollBehavior: function (to, from, savedPosition) {
//     if (savedPosition) {
//       return savedPosition
//     } else {
//       return {
//         x: 0,
//         y: 0,
//       }
//     }
//   },
//   routes: ,
// })

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  linkActiveClass: "-current",
  // scrollBehavior: (to, from, savedPosition) => {
  //   if (savedPosition) {
  //     return savedPosition
  //   } else {
  //     return {
  //       x: 0,
  //       y: 0,
  //     }
  //   }
  // },
  routes,
})

export default router
