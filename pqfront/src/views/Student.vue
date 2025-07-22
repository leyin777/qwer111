<template>
  <div class="student-container">
    <el-card>
      <div class="header">
        <h2>可参与演讲</h2>
      </div>
      <el-table :data="courseList" style="width: 100%; margin-top: 20px;">
        <el-table-column prop="title" label="演讲题目" />
        <el-table-column prop="place" label="地点" />
        <el-table-column prop="time" label="时间" />
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="primary" size="small" @click="goToQuiz(scope.row)">
              开始答题
            </el-button>
            <el-button type="warning" size="small" @click="goToFeedback(scope.row)" style="margin-left: 8px;">
              问题反馈
            </el-button>
            <el-button 
              type="success" 
              size="small" 
              @click="goToDiscussion(scope.row)" 
              style="margin-left: 8px;"
              :disabled="!isDiscussionTime(scope.row.time)"
            >
            讨论区
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
import { ElMessage } from 'element-plus';
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

function goToFeedback(course: Course) {
  router.push({ path: '/feedback', query: { courseId: course.id } });
}

function isDiscussionTime(speechTime: string): boolean {
  const now = new Date();
  const speechDate = new Date(speechTime);
  
  // 计算时间差（毫秒）
  const timeDiff = now.getTime() - speechDate.getTime();
  
  // 转换为分钟
  const diffMinutes = timeDiff / (1000 * 60);
  
  // 判断是否在讨论时间范围内（演讲开始后30分钟即可）
  return diffMinutes >= 30;
}

function goToDiscussion(course: Course) {
  if (isDiscussionTime(course.time)) {
    router.push({ path: '/discussion', query: { courseId: course.id } });
  } else {
    const now = new Date();
    const speechDate = new Date(course.time);
    const timeDiff = now.getTime() - speechDate.getTime();
    const diffMinutes = timeDiff / (1000 * 60);
    
    if (diffMinutes < 30) {
      ElMessage.warning('讨论区还未开放，请等待演讲开始后30分钟');
    } else {
      ElMessage.warning('讨论区暂未开放');
    }
  }
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
