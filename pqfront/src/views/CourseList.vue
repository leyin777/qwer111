<template>
  <div>
    <el-card>
      <h2>演讲列表</h2>
      <el-table :data="courses" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="speakername" label="讲师" />
        <el-table-column prop="title" label="标题" />
        <el-table-column prop="place" label="地点" />
        <el-table-column prop="time" label="时间" />
        <el-table-column prop="maxPeople" label="最大人数" />
        <el-table-column label="操作" width="100">
    <template #default="scope">
      <div style="display: flex; flex-direction: column; gap: 8px; align-items: flex-start;">
        <el-button
          type="primary"
          size="small"
          @click="viewAnswerInfo(scope.row)"
        >演讲报告</el-button>
        <el-button
          type="success"
          size="small"
          @click="goToDiscussion(scope.row)"
          style="margin-top: 4px;"
          :disabled="!isDiscussionTime(scope.row.time)"
        >讨论区</el-button>
        <el-button
          type="danger"
          size="small"
          :disabled="scope.row.speakername !== username"
          @click="handleDelete(scope.row.id)"
        >删除</el-button>
      </div>
    </template>
  </el-table-column>
      </el-table>
    </el-card>
  </div>
  <el-button type="primary" @click="goAddCourse">新增演讲</el-button>
</template>

<script setup>
function viewAnswerInfo(course) {
  router.push({ path: '/ansinf', query: { courseId: course.id, title: course.title } })
}
import { ref, onMounted } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'

const router = useRouter()
function goAddCourse() {
  router.push('/add-course')
}

const courses = ref([])
const username = localStorage.getItem('username') || ''


onMounted(async () => {
  const res = await axios.get('/api/courses')
  courses.value = res.data
})

async function handleDelete(id) {
  ElMessageBox.confirm('确定要删除这门课程吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    const res = await axios.delete(`/api/courses/${id}`)
    if (res.data.code === 0) {
      ElMessage.success('删除成功')
      courses.value = courses.value.filter(course => course.id !== id)
    } else {
      ElMessage.error(res.data.msg || '删除失败')
    }
  }).catch(() => {})
}

function isDiscussionTime(speechTime) {
  const now = new Date();
  const speechDate = new Date(speechTime);
  const diffMinutes = (now.getTime() - speechDate.getTime()) / (1000 * 60);
  return diffMinutes >= 30;
}

function goToDiscussion(course) {
  if (isDiscussionTime(course.time)) {
    router.push({ path: '/discussion', query: { courseId: course.id } });
  } else {
    const now = new Date();
    const speechDate = new Date(course.time);
    const diffMinutes = (now.getTime() - speechDate.getTime()) / (1000 * 60);
    if (diffMinutes < 30) {
      ElMessage.warning('讨论区还未开放，请等待演讲开始后30分钟');
    } else {
      ElMessage.warning('讨论区暂未开放');
    }
  }
}
</script>