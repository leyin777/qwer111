<template>
  <div class="feedback-container">
    <h2>问题反馈</h2>
    <el-form :model="form" label-width="120px" class="feedback-form">
      <el-form-item label="请选择反馈类型">
        <el-checkbox-group v-model="form.types">
          <el-checkbox :value="'讲得太快'">讲得太快</el-checkbox>
          <el-checkbox :value="'讲得太慢'">讲得太慢</el-checkbox>
          <el-checkbox :value="'演讲本身太乏味'">演讲本身太乏味</el-checkbox>
          <el-checkbox :value="'题目出得质量不好'">题目出得质量不好</el-checkbox>
        </el-checkbox-group>
      </el-form-item>
      <el-form-item label="其他意见">
        <el-input v-model="form.comment" type="textarea" placeholder="请填写您的建议或意见" :rows="4" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitFeedback">提交反馈</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import { ElMessage } from 'element-plus'

const route = useRoute()
const router = useRouter()
const courseId = route.query.courseId
const userId = localStorage.getItem('userId')

const form = ref({
  types: [],
  comment: ''
})

async function submitFeedback() {
  if (!form.value.types.length && !form.value.comment) {
    ElMessage.warning('请至少选择一种反馈或填写意见')
    return
  }
  // 反馈类型映射
  const typeMap = {
    '讲得太快': 'tooFast',
    '讲得太慢': 'tooSlow',
    '演讲本身太乏味': 'boring',
    '题目出得质量不好': 'badQuestion'
  }
  const feedbackData = {
    qid: courseId,
    uid: userId,
    tooFast: form.value.types.includes('讲得太快') ? 1 : 0,
    tooSlow: form.value.types.includes('讲得太慢') ? 1 : 0,
    boring: form.value.types.includes('演讲本身太乏味') ? 1 : 0,
    badQuestion: form.value.types.includes('题目出得质量不好') ? 1 : 0,
    comment: form.value.comment
  }
  try {
    await axios.post('/api/feedback/submit', feedbackData)
    ElMessage.success('反馈提交成功，感谢您的参与！')
    router.back()
  } catch (e) {
    ElMessage.error('反馈提交失败，请稍后重试')
  }
}
</script>

<style scoped>
.feedback-container {
  max-width: 500px;
  margin: 40px auto;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  padding: 32px 24px 16px 24px;
}
.feedback-form {
  margin-top: 24px;
}
</style>
