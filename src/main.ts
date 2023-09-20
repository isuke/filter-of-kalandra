//
// styles
//
import "destyle.css"
import "./styles/sweep.css"
import "./styles/advancedPoeFilter.scss"
import "./styles/_bases.scss"

//
// scripts
//
import { createApp } from "vue"
import VueGtag from "vue-gtag"

import App from "@/App.vue"
import router from "@/router"
import store from "@/stores"

import "@/registerServiceWorker"
import "@/utils/monacoAdvancedPoeFilter"

createApp(App)
  .use(store)
  .use(router)
  .use(VueGtag, { config: { id: process.env.VUE_APP_GoogleAnalyticsID } })
  .mount("#app")
