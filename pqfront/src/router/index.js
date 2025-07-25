import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import CourseList from '@/views/CourseList.vue'

// 其他页面组件也要用 ../views/xxx.vue 路径引入

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: () => import('@/views/Login.vue') },
  { path: '/register', component: () => import('@/views/Register.vue') },
  { path: '/speaker', component: () => import('@/views/CourseList.vue') },
  { path: '/admin', component: () => import('@/views/Admin.vue') },
  { path: '/student', component: () => import('@/views/Student.vue') },
  { path: '/add-course', component: () => import('@/views/AddCourse.vue') },
  { path: '/ans', component: () => import('../views/Ans.vue') },
  { path: '/ansinf', component: () => import('../views/ansinf.vue') },
  { path: '/feedback', component: () => import('../views/Feedback.vue') },
  { path: '/discussion', component: () => import('../views/Discussion.vue') },
  { path: '/addfile', component: () => import('../views/addfile.vue') }
  // 其他页面继续添加
]

const router = createRouter({
  history: createWebHistory(),
  routes
})


export default router