//
// styles
//
import "./styles/bases/_body.scss";

//
// scripts
//
import Vue from "vue";
import App from "./App.vue";
import router from "./router.coffee";
import store from "./store.coffee";
import "./registerServiceWorker";

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
