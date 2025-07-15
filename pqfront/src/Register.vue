<template>
  <div class="register-container">
    <h2>注册</h2>
    <form @submit.prevent="handleRegister">
      <div class="form-group">
        <label for="name">名称</label>
        <input id="name" v-model="name" type="text" required />
      </div>
      <div class="form-group">
        <label for="password">密码</label>
        <input id="password" v-model="password" type="password" required />
      </div>
      <div class="form-group">
        <label for="email">邮箱</label>
        <input id="email" v-model="email" type="email" required />
      </div>
      <div class="form-group">
        <label for="role">身份</label>
        <select id="role" v-model="role" required>
          <option value="" disabled>请选择身份</option>
          <option value="user">听众</option>
          <option value="admin">组织者</option>
          <option value="admin">演讲者</option>
        </select>
      </div>
      <button type="submit">确定注册</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const name = ref('')
const password = ref('')
const email = ref('')
const role = ref('')

function handleRegister() {
  // 这里可以添加注册逻辑
  alert(`名称：${name.value}\n密码：${password.value}\n邮箱：${email.value}\n身份：${role.value}`)
}
</script>

<style scoped>
.register-container {
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
input[type="password"],
input[type="email"],
select {
  width: 100%;
  padding: 8px 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
button {
  width: 100%;
  padding: 10px 0;
  margin-top: 10px;
  border: none;
  border-radius: 4px;
  background: #409eff;
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}
button:active {
  opacity: 0.85;
}
</style>