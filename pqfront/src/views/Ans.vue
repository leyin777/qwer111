<template>
  <div class="ans-container">
    <div v-if="!isFinished">
      <h2>第{{ currentIndex + 1 }}题：{{ questions[currentIndex].question }}</h2>
      <div class="options">
        <el-button
          v-for="(option, idx) in questions[currentIndex].options"
          :key="idx"
          :type="getOptionType(idx)"
          class="option-btn"
          @click="selectOption(idx)"
          :disabled="answeredArr[currentIndex]"
        >
          {{ option }}
        </el-button>
      </div>
      <div class="actions">
        <el-button @click="prevQuestion" :disabled="currentIndex === 0">Back</el-button>
        <el-button @click="nextQuestion" :disabled="!answeredArr[currentIndex]">Next</el-button>
      </div>
    </div>
    <div v-else>
      <h2>答题结束！</h2>
      <p>您的得分：{{ score }} / {{ questions.length }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { ElButton } from 'element-plus'

const questions = ref([
  {
    question: '中国的首都是哪座城市？',
    options: ['上海', '广州', '北京', '深圳'],
    answer: 2
  },
  {
    question: '2 + 2 = ?',
    options: ['2', '3', '4', '5'],
    answer: 2
  },
  {
    question: '下列哪项是编程语言？',
    options: ['Vue', 'Python', 'HTML', 'CSS'],
    answer: 1
  },
  {
    question: '地球上最大的动物是？',
    options: ['大象', '蓝鲸', '长颈鹿', '狮子'],
    answer: 1
  },
  {
    question: '太阳从哪边升起？',
    options: ['南', '北', '东', '西'],
    answer: 2
  }
])

const currentIndex = ref(0)
const selectedOptions = ref(Array(questions.value.length).fill(null))
const answeredArr = ref(Array(questions.value.length).fill(false))
const score = computed(() =>
  selectedOptions.value.reduce((acc, sel, idx) =>
    sel === questions.value[idx].answer ? acc + 1 : acc, 0)
)

const isFinished = ref(false)

function selectOption(idx) {
  if (answeredArr.value[currentIndex.value]) return
  selectedOptions.value[currentIndex.value] = idx
  answeredArr.value[currentIndex.value] = true
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
  gap: 16px;
  margin: 24px 0;
}
.option-btn {
  width: 100%;
  text-align: left;
}
.actions {
  display: flex;
  justify-content: space-between;
  margin-top: 24px;
}
</style>
