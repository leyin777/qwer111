import { createRouter, createWebHistory } from 'vue-router'
import Login from '../Login.vue'
import Register from '../Register.vue'

const routes = [
  { path: '/', component: Login },
  { path: '/register', component: Register }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router