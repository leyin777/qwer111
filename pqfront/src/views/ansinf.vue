<template>
  <div class="ansinf-container">
    <h2>{{ courseTitle }} 演讲报告</h2>
    <h3 style="margin-top:24px;">答题情况</h3>
    <el-table :data="questionStats" style="width: 100%; margin-top: 12px;">
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
      <el-table-column prop="correctUserCount" label="答对人数">
        <template #default="scope">
          <span>{{ scope.row.correctUserCount }}</span>
        </template>
      </el-table-column>
    </el-table>
    <h3 style="margin-top:32px;">演讲反馈</h3>
    <el-table :data="feedbackStats" style="width: 100%; margin-top: 12px;">
      <el-table-column prop="label" label="反馈问题" />
      <el-table-column prop="count" label="提及人数" />
    </el-table>
    <div style="margin-top:24px;">
      <h4>其他反馈信息</h4>
      <el-table :data="feedbackComments" style="width: 100%;">
        <el-table-column prop="comment" label="评论内容" />
      </el-table>
    </div>
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
const feedbackStats = ref([])
const feedbackComments = ref([])

onMounted(async () => {
  // 获取课程信息
  let courseRes = null;
  if (!courseTitle.value) {
    courseRes = await axios.get('/api/courses/' + courseId)
    courseTitle.value = courseRes.data?.title || ''
  } else {
    courseRes = await axios.get('/api/courses/' + courseId)
  }
  // 获取题目列表及正确率，前端按id升序排序
  const res = await axios.get('/api/question/list', { params: { qid: courseId } })
  questionStats.value = (res.data || [])
    .sort((a, b) => a.id - b.id)
    .map((q, idx) => ({
      index: idx,
      content: q.text || q.content || q.question || '',
      accuracy: q.accuracy !== undefined ? q.accuracy : 0,
      correctUserCount: q.correctUserCount !== undefined ? q.correctUserCount : 0
    }))
  // 获取反馈统计
  const statsRes = await axios.get('/api/feedback/stats', { params: { qid: courseId } })
  const statsData = statsRes.data?.data || {}
  feedbackStats.value = [
    { label: '讲得太快', count: statsData.tooFastCount || 0 },
    { label: '讲得太慢', count: statsData.tooSlowCount || 0 },
    { label: '演讲本身太乏味', count: statsData.boringCount || 0 },
    { label: '题目出得质量不好', count: statsData.badQuestionCount || 0 }
  ]
  // 获取评论反馈
  const commentsRes = await axios.get('/api/feedback/comments', { params: { qid: courseId } })
  // 兼容后端返回格式
  if (Array.isArray(commentsRes.data)) {
    feedbackComments.value = commentsRes.data
  } else if (Array.isArray(commentsRes.data?.data)) {
    feedbackComments.value = commentsRes.data.data
  } else {
    feedbackComments.value = []
  }
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
