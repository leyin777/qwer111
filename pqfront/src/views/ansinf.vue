<template>
  <div class="ansinf-container">
    <h2>{{ courseTitle }} 答题情况</h2>
    <el-table :data="questionStats" style="width: 100%; margin-top: 24px;">
      <el-table-column prop="index" label="题号" width="80">
        <template #default="scope">
          第{{ scope.row.index + 1 }}题
        </template>
      </el-table-column>
      <el-table-column prop="content" label="题目" />
      <el-table-column prop="accuracy" label="正确率">
        <template #default="scope">
          <span>{{ (scope.row.accuracy * 100).toFixed(1) }}%</span>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const courseId = route.query.courseId
const courseTitle = ref(route.query.title || '')
const questionStats = ref([])

onMounted(async () => {
  // 如果没有带title参数则请求一次
  if (!courseTitle.value) {
    const courseRes = await axios.get('/api/courses/' + courseId)
    courseTitle.value = courseRes.data?.title || ''
  }
  // 获取题目列表及正确率，前端按id升序排序
  const res = await axios.get('/api/question/list', { params: { qid: courseId } })
  questionStats.value = (res.data || [])
    .sort((a, b) => a.id - b.id)
    .map((q, idx) => ({
      index: idx,
      content: q.text || q.content || q.question || '',
      accuracy: q.accuracy !== undefined ? q.accuracy : 0
    }))
  console.log('题目正确率', questionStats.value)
})
</script>

<style scoped>
.ansinf-container {
  max-width: 700px;
  margin: 40px auto;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  padding: 32px 24px 16px 24px;
}
</style>
