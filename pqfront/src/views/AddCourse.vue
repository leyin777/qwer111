<template>
  <div class="add-course-container">
    <el-card>
      <h2 style="text-align:center;">增加演讲</h2>
      <el-form :model="form" ref="formRef" label-width="100px" style="margin-top:20px;">
        <el-form-item label="演讲者名称" prop="speakername">
          <el-input v-model="form.speakername" :disabled="true" />
        </el-form-item>
        <el-form-item label="演讲题目" prop="title">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="演讲地点" prop="place">
          <el-input v-model="form.place" />
        </el-form-item>
        <el-form-item label="演讲时间" prop="time">
          <el-date-picker v-model="form.time" type="datetime" placeholder="选择时间" style="width:100%;" />
        </el-form-item>
        <el-form-item label="最大人数上限" prop="maxPeople">
          <el-input-number v-model="form.maxPeople" :min="1" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSubmit">确定</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const router = useRouter()
const formRef = ref(null)
const form = ref({
  speakername: '',
  title: '',
  place: '',
  time: '',
  maxPeople: 1
})

onMounted(() => {
  // 自动填充演讲者名称
  form.value.speakername = localStorage.getItem('username') || ''
})

async function handleSubmit() {
  // 前端校验
  const loginName = localStorage.getItem('username')
  if (form.value.speakername !== loginName) {
    ElMessage.error('只能添加自己的演讲')
    return
  }
  try {
    const payload = { ...form.value }
    if (payload.time instanceof Date) {
      payload.time = payload.time.toISOString().slice(0, 19).replace('T', ' ')
    }
    const res = await axios.post('/api/courses', payload)
    if (res.data.code === 0) {
      ElMessage.success('添加成功')
      router.push('/courses')
    } else {
      ElMessage.error(res.data.msg || '添加失败')
    }
  } catch (e) {
    ElMessage.error('网络错误')
  }
}
</script>

<style scoped>
.add-course-container {
  max-width: 500px;
  margin: 40px auto;
}
</style>