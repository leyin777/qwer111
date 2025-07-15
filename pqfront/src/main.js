import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

console.log('main.js router:', router)

createApp(App).use(router).mount('#app')