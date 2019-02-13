//
// styles
//
import "destyle.css";
import "./styles/sweep.css";
import "./styles/_bases.scss";

//
// scripts
//
import Vue from "vue";
import VueAnalytics from "vue-analytics";
import App from "./App.vue";
import router from "./router.coffee";
import store from "./store.coffee";
import "./scripts/monacoAdvancedPoeFilter.coffee";
import "./registerServiceWorker";

Vue.config.productionTip = false;

if (process.env.NODE_ENV === "production") {
  Vue.use(VueAnalytics, {
    id: process.env.VUE_APP_GoogleAnalyticsID,
    router
  });
}

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
