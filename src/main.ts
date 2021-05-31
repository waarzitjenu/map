import { createApp } from "vue";
import App from "./App.vue";
import "./registerServiceWorker";
import router from "./router";
import store from "./store";
import { ConfigWindow } from "./types/ConfigWindow";

declare let window: ConfigWindow;

const r = new Request("/config.json", { method: "GET" });
fetch(r)
  .then((data) => {
    return data.json();
  })
  .then((data) => {
    window.$config = data;
    createApp(App).use(store).use(router).mount("#app");
  });
