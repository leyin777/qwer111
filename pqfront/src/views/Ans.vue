<template>
  <div class="ans-container">
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
    </div>
    <div v-else class="loading-empty">
      <el-empty description="暂无题目或加载中..." />
    </div>
    <div v-else>
      <h2>答题结束！</h2>
      <p>您的得分：{{ score }} / {{ questions.length }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElButton } from 'element-plus'
import { useRoute } from 'vue-router'
import axios from 'axios'

const questions = ref([])
const route = useRoute()

const currentIndex = ref(0)
const selectedOptions = ref([])
const answeredArr = ref([])
const isFinished = ref(false)

onMounted(async () => {
  const qid = route.query.courseId
  if (qid) {
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
