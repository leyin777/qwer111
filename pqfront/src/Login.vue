<template>
  <div class="login-container">
    <h2>登录</h2>
    <form @submit.prevent="handleLogin">
      <div class="form-group">
        <label for="username">账户</label>
        <input id="username" v-model="username" type="text" required />
      </div>
      <div class="form-group">
        <label for="password">密码</label>
        <input id="password" v-model="password" type="password" required />
      </div>
      <button type="submit">登录</button>
    </form>
    <button type="button" @click="handleRegister" class="register-btn">注册</button>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const username = ref('')
const password = ref('')
const router = useRouter()

function handleLogin() {
  // 这里可以添加登录逻辑
  alert(`账户：${username.value}\n密码：${password.value}`)
}

function handleRegister() {
   router.push('/register')
}
</script>

<style scoped>
.login-container {
  max-width: 350px;
  margin: 60px auto;
  padding: 32px 24px;
  border: 1px solid #eee;
  border-radius: 8px;
  background: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}
h2 {
  text-align: center;
  margin-bottom: 24px;
}
.form-group {
  margin-bottom: 18px;
}
label {
  display: block;
  margin-bottom: 6px;
  color: #333;
}
input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 10px 0;
  margin-bottom: 10px;
  border: none;
  border-radius: 4px;
  background: #42b983;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}
.register-btn {
  background: #409eff;
}
button:active {
  opacity: 0.85;
}
</style>