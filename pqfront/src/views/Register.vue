<template>
  <div class="register-container">
    <el-card class="register-card">
      <h2 style="text-align:center;">注册</h2>
      <el-form :model="form" :rules="rules" ref="registerForm" label-width="70px" @submit.prevent="handleRegister">
        <el-form-item label="名称" prop="username">
          <el-input v-model="form.username" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" type="password" autocomplete="off" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="form.email" autocomplete="off" />
        </el-form-item>
        <el-form-item label="身份" prop="role">
          <el-select v-model="form.role" placeholder="请选择身份">
            <el-option label="学生" value="audience" />
            <el-option label="组织者" value="organizer" />
            <el-option label="演讲者" value="speaker" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleRegister">确定注册</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { useRouter } from 'vue-router'

const router = useRouter()
const registerForm = ref(null)
const form = ref({
  username: '',
  password: '',
  email: '',
  role: ''
})

const rules = {
  username: [{ required: true, message: '请输入名称', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
  ],
  role: [{ required: true, message: '请选择身份', trigger: 'change' }]
}

const handleRegister = () => {
  registerForm.value.validate(async (valid) => {
    if (valid) {
      // 发送注册请求
      try {
        const res = await fetch('/api/register', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(form.value)
        })
        const data = await res.json()
        if (data.success) {
          ElMessage.success('注册成功，请登录')
          router.push('/login')
        } else {
          ElMessage.error(data.message || '注册失败')
        }
      } catch (e) {
        ElMessage.error('网络错误')
      }
    }
  })
}
</script>

<style scoped>
.register-container {
  max-width: 400px;
  margin: 60px auto;
}
.register-card {
  padding: 32px 24px;
}
</style>