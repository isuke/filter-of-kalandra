//
// styles
//
import "codemirror/lib/codemirror.css";
import "codemirror/addon/fold/foldgutter.css";
import "./styles/codemirror.scss";
import "./styles/bases/_body.scss";

//
// scripts
//
import Vue from "vue";
import App from "./App.vue";
import router from "./router.coffee";
import store from "./store.coffee";
import "./registerServiceWorker";
import "./scripts/codemirrorAdvancedPoeFilter";

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
