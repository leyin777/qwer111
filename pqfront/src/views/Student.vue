<template>
  <div class="student-container">
    <el-card>
      <div class="header">
        <h2>可参与课程</h2>
      </div>
      <el-table :data="courseList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="title" label="课程题目" />
        <el-table-column prop="place" label="地点" />
        <el-table-column prop="time" label="时间" />
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="primary" size="small" @click="goToQuiz(scope.row)">
              开始答题
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

interface Course {
  id: number;
  title: string;
  place: string;
  time: string;
  maxPeople: number;
}

const courseList = ref<Course[]>([]);
const router = useRouter();

function goToQuiz(course: Course) {
  // 跳转到/ans并带上课程id作为参数
  router.push({ path: '/ans', query: { courseId: course.id } });
}

onMounted(async () => {
  try {
    const res = await axios.get<Course[]>('/api/courses');
    courseList.value = res.data;
  } catch (e) {
    console.error('课程加载失败', e);
  }
});
</script>

<style scoped>
.student-container {
  max-width: 1000px;
  margin: 40px auto;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
