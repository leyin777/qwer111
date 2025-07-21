<template>
  <div class="ans-container">
    <div v-if="isOutOfTime">
      <el-empty description="不在答题时间内" />
    </div>
    <div v-else>
      <div v-if="questions.length && !isFinished">
        <h2>第{{ currentIndex + 1 }}题：{{ questions[currentIndex].question }}</h2>
        <div class="options">
          <div
            v-for="(option, idx) in questions[currentIndex].options"
            :key="idx"
            class="option-row"
          >
            <el-button
              :type="getOptionType(idx)"
              class="option-btn"
              @click="selectOption(idx)"
              :disabled="answeredArr[currentIndex]"
              plain
            >
              {{ option }}
            </el-button>
          </div>
        </div>
        <div class="actions">
          <el-button @click="prevQuestion" :disabled="currentIndex === 0">Back</el-button>
          <el-button @click="nextQuestion" :disabled="!answeredArr[currentIndex]">Next</el-button>
        </div>
      </div>
      <div v-else-if="isFinished">
        <h2>答题结束！</h2>
        <p>您的得分：{{ score }} / {{ questions.length }}</p>
        <p>正确率：{{ ((score / questions.length) * 100).toFixed(1) }}%</p>
        <p v-if="userRank !== null">您的排名：{{ userRank }}</p>
       
        <el-button type="info" @click="showDetails = !showDetails" style="margin-top:12px;">{{ showDetails ? '收起排名' : '查看排名信息' }}</el-button>
        <el-table v-if="showDetails" :data="detailsList" style="width:100%;margin-top:12px;">
          <el-table-column prop="ranking" label="排名" width="80" />
          <el-table-column prop="username" label="用户名" />
          <el-table-column prop="score" label="得分" />
          <el-table-column prop="accuracy" label="正确率" />
        </el-table>
      </div>
      <div v-else class="loading-empty">
        <el-empty description="暂无题目或加载中..." />
      </div>
      <div v-else>
        <h2>答题结束！</h2>
        <p>您的得分：{{ score }} / {{ questions.length }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { ElButton } from 'element-plus'
import { useRoute } from 'vue-router'
import axios from 'axios'

const questions = ref([])
const route = useRoute()

const currentIndex = ref(0)
const selectedOptions = ref([])
const answeredArr = ref([])
const isFinished = ref(false)
const isOutOfTime = ref(false)
const showRankList = ref(false)
const rankList = ref([])
const userRank = ref(null)
const showDetails = ref(false)
const detailsList = ref([])

onMounted(async () => {
  const qid = route.query.courseId
  if (qid) {
    // 先获取课程信息，判断时间
    const courseRes = await axios.get('/api/courses/' + qid)
    const courseTime = courseRes.data?.time
    if (courseTime) {
      const createTime = new Date(courseTime).getTime()
      const now = Date.now()
      const twoHours = 2 * 60 * 60 * 1000
      if (now - createTime > twoHours) {
        isOutOfTime.value = true
        setTimeout(() => {
          window.$message ? window.$message.warning('不在答题时间内') : alert('不在答题时间内')
        }, 100)
        return
      }
    }
    const res = await axios.get('/api/question/list', { params: { qid } })
    // 关键：加上 id: q.id
    questions.value = (res.data || []).map(q => ({
      id: q.id, // 必须加
      question: q.content,
      options: [q.optionA, q.optionB, q.optionC, q.optionD],
      answer: q.correctIndex
    }))
    selectedOptions.value = Array(questions.value.length).fill(null)
    answeredArr.value = Array(questions.value.length).fill(false)
  }
})

const score = computed(() =>
  selectedOptions.value.reduce((acc, sel, idx) =>
    sel === questions.value[idx]?.answer ? acc + 1 : acc, 0)
)

async function selectOption(idx) {
  if (answeredArr.value[currentIndex.value]) return
  selectedOptions.value[currentIndex.value] = idx
  answeredArr.value[currentIndex.value] = true

  const userId = localStorage.getItem('userId')
  const question = questions.value[currentIndex.value]
  try {
    await axios.post('/api/question/answer', {
      userId: userId,
      questionId: question.id, // 直接用 question.id
      userAnswerIndex: idx,
      correct: idx === question.answer ? 1 : 0 // 传 0/1
    })
  } catch (e) {
    console.error('单题答题记录上传失败', e)
  }
}

function getOptionType(idx) {
  if (!answeredArr.value[currentIndex.value]) return ''
  const sel = selectedOptions.value[currentIndex.value]
  const ans = questions.value[currentIndex.value].answer
  if (idx === sel) {
    return sel === ans ? 'success' : 'danger'
  }
  if (idx === ans) {
    return 'success'
  }
  return ''
}

function nextQuestion() {
  if (currentIndex.value < questions.value.length - 1) {
    currentIndex.value++
  } else {
    isFinished.value = true
  }
}

function prevQuestion() {
  if (currentIndex.value > 0) {
    currentIndex.value--
  }
}

// 答题结束后计算排名
// audience 答题页面只在答题结束后请求排名
watch(isFinished, async (val) => {
  if (val) {
    // 只在全部答题完成后上传得分和请求排名
    const userId = localStorage.getItem('userId')
    const qid = route.query.courseId
    const total = questions.value.length
    const correctCount = score.value
    // 上传最终正确率（accuracy），只上传一条数据
    const accuracy = total ? Math.round((correctCount / total) * 100) : 0
    await axios.post('/api/rank/calculate', { uid: userId, qid, accuracy })
    // 获取个人排名（以正确率为主）
    const userRankRes = await axios.get('/api/rank/user', { params: { uid: userId, qid } })
    userRank.value = userRankRes.data?.rank ?? null
    // 获取全部排名并按正确率降序
    const rankListRes = await axios.get('/api/rank/list', { params: { qid } })
    let rawList = Array.isArray(rankListRes.data?.data) ? rankListRes.data.data : []
    rawList = rawList.map(item => ({
      username: item.username,
      score: item.score,
      accuracy: total ? ((item.score / total) * 100).toFixed(1) : 0,
      ranking: item.ranking ?? ''
    }))
    // 按正确率降序排序
    rawList.sort((a, b) => b.accuracy - a.accuracy)
    rankList.value = rawList.map((item, idx) => ({
      ranking: item.ranking || (idx + 1),
      ...item,
      accuracy: item.accuracy + '%'
    }))
    // 获取详细排名信息
    const detailsRes = await axios.get('/api/rank/details', { params: { qid } })
    detailsList.value = Array.isArray(detailsRes.data?.data) ? detailsRes.data.data : []
  }
})
</script>

<style scoped>
.ans-container {
  max-width: 500px;
  margin: 40px auto;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  padding: 32px 24px 16px 24px;
}
.options {
  display: flex;
  flex-direction: column;
  gap: 18px;
  margin: 32px 0 24px 0;
}
.option-row {
  display: flex;
  align-items: center;
  width: 100%;
}
.option-btn {
  flex: 1;
  text-align: left;
  font-size: 18px;
  height: 48px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}
.actions {
  display: flex;
  justify-content: space-between;
  margin-top: 24px;
}
</style>
