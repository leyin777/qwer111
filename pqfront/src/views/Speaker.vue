<template>
  <div class="speaker-container">
    <el-card>
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>课程列表</h2>
        <el-button type="primary" @click="goAddCourse">增加课程</el-button>
      </div>
      <el-table :data="courseList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="title" label="课程题目" />
        <el-table-column prop="place" label="演讲地点" />
        <el-table-column prop="time" label="演讲时间" />
        <el-table-column prop="maxPeople" label="人数上限" />
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const courseList = ref([
  // 示例数据
  { title: 'Vue基础', place: 'A101', time: '2025-08-01 14:00', maxPeople: 100 },
  { title: 'SpringBoot实战', place: 'B202', time: '2025-08-05 10:00', maxPeople: 80 }
])

function goAddCourse() {
  router.push('/add-course')
}
</script>

<style scoped>
.speaker-container {
  max-width: 800px;
  margin: 40px auto;
}
</style>