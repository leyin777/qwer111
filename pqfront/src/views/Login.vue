<template>
  <div class="login-container">
    <el-card class="login-card">
      <h2 style="text-align:center;">登录</h2>
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef" label-width="70px">
        <el-form-item label="账户" prop="username">
          <el-input v-model="loginForm.username" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="loginForm.password" type="password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="身份" prop="role">
          <el-select v-model="loginForm.role" placeholder="请选择身份">
            <el-option label="管理者" value="admin" />
            <el-option label="演讲者" value="speaker" />
            <el-option label="学生" value="student" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleLogin">登录</el-button>
          <el-button type="success" @click="handleRegister" style="margin-left: 10px;">注册</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const router = useRouter()
const loginFormRef = ref(null)
const loginForm = ref({
  username: '',
  password: '',
  role: ''
})

const rules = {
  username: [{ required: true, message: '请输入账户', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  role: [{ required: true, message: '请选择身份', trigger: 'change' }]
}

const handleLogin = () => {
  loginFormRef.value.validate(async (valid) => {
    if (!valid) return
    try {
      // 假设后端登录接口为 /api/login，返回 {code:0, data:{role:xxx}, msg:""}
      const { username, password, role } = loginForm.value
      const res = await axios.post('/api/login', { username, password, role })
      if (res.data.code === 0) {
        localStorage.setItem('username', username)
        ElMessage.success('登录成功')
        // 根据身份跳转
        if (res.data.data.role === 'admin') {
          router.push('/admin')
        } else if (res.data.data.role === 'speaker') {
          router.push('/courses')
        } else if (res.data.data.role === 'student') {
          router.push('/student')
        }
      } else {
        ElMessage.error(res.data.msg || '登录失败')
      }
    } catch (e) {
      ElMessage.error('网络错误')
    }
  })
}

const handleRegister = () => {
  router.push('/register')
}
</script>

<style scoped>
.login-container {
  width: 100vw;
  height: 100vh;
  background: #f5f6fa;
  display: flex;
  align-items: center;
  justify-content: center;
}
.login-card {
  width: 350px;
  padding: 32px 24px 16px 24px;
  border-radius: 10px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
}
.el-form-item {
  margin-bottom: 22px;
}
.el-button {
  width: 100px;
}
</style>