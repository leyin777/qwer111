<template>
  <div class="discussion-container">
    <el-card>
      <!-- 演讲名称 -->
      <div class="speech-header">
        <h2>{{ courseInfo.title }}</h2>
        <p class="speech-info">
          <span>地点：{{ courseInfo.place }}</span>
          <span style="margin-left: 20px;">时间：{{ courseInfo.time }}</span>
        </p>
      </div>

      <!-- 问题题目及正确答案 -->
      <div class="questions-section">
        <h3>演讲问题及正确答案</h3>
        <el-table :data="questions" style="width: 100%; margin-top: 20px;">
          <el-table-column prop="content" label="问题题目" />
          <el-table-column label="正确答案">
            <template #default="scope">
              {{ getCorrectAnswer(scope.row) }}
            </template>
          </el-table-column>
        </el-table>
      </div>

      <!-- 讨论区 -->
      <div class="discussion-section">
        <div class="discussion-header">
          <h3>讨论区</h3>
          <el-button type="primary" @click="showAddCommentDialog = true">
            新增评论
          </el-button>
        </div>
        
        <div class="comments-list">
          <div v-if="comments.length === 0" class="no-comments">
            暂无评论，快来发表第一条评论吧！
          </div>
          <div v-else class="comment-item" v-for="comment in comments" :key="comment.id">
            <div class="comment-header">
              <span class="username">{{ comment.username }}</span>
              <span class="time">{{ formatTime(comment.createTime) }}</span>
            </div>
            <div class="comment-content">
              {{ comment.content }}
            </div>
          </div>
        </div>
      </div>
    </el-card>

    <!-- 新增评论对话框 -->
    <el-dialog v-model="showAddCommentDialog" title="新增评论" width="500px">
      <el-form :model="newComment" label-width="80px">
        <el-form-item label="评论内容">
          <el-input
            v-model="newComment.content"
            type="textarea"
            :rows="4"
            placeholder="请输入您的评论内容"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showAddCommentDialog = false">取消</el-button>
          <el-button type="primary" @click="addComment">发表评论</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { ElMessage } from 'element-plus';
import axios from 'axios';

interface Course {
  id: number;
  title: string;
  place: string;
  time: string;
  maxPeople: number;
}

interface Question {
  id: number;
  content: string;
  optionA: string;
  optionB: string;
  optionC: string;
  optionD: string;
  correctIndex: number;
  qid: number;
}

interface Comment {
  id: number;
  content: string;
  username: string;
  createTime: string;
  courseId: number;
}

const route = useRoute();
const courseInfo = ref<Course>({} as Course);
const questions = ref<Question[]>([]);
const comments = ref<Comment[]>([]);
const showAddCommentDialog = ref(false);
const newComment = ref({
  content: ''
});

onMounted(async () => {
  const courseId = route.query.courseId;
  if (courseId) {
    await loadCourseInfo(Number(courseId));
    await loadQuestions(Number(courseId));
    await loadComments(Number(courseId));
  }
});

async function loadCourseInfo(courseId: number) {
  try {
    const res = await axios.get<Course>(`/api/courses/${courseId}`);
    courseInfo.value = res.data;
  } catch (e) {
    console.error('课程信息加载失败', e);
    ElMessage.error('课程信息加载失败');
  }
}

async function loadQuestions(courseId: number) {
  try {
    // 使用courseId作为qid来获取问题
    const res = await axios.get<Question[]>(`/api/question/list?qid=${courseId}`);
    questions.value = res.data;
  } catch (e) {
    console.error('问题加载失败', e);
    ElMessage.error('问题加载失败');
  }
}

async function loadComments(courseId: number) {
  try {
    const res = await axios.get<Comment[]>(`/api/comments?courseId=${courseId}`);
    comments.value = res.data;
  } catch (e) {
    console.error('评论加载失败', e);
    ElMessage.error('评论加载失败');
  }
}

function getCorrectAnswer(question: Question): string {
  const options = [question.optionA, question.optionB, question.optionC, question.optionD];
  const optionLabels = ['A', 'B', 'C', 'D'];
  return `${optionLabels[question.correctIndex]}. ${options[question.correctIndex]}`;
}

function formatTime(timeStr: string): string {
  if (!timeStr) return '';
  const date = new Date(timeStr);
  return date.toLocaleString('zh-CN');
}

async function addComment() {
  if (!newComment.value.content.trim()) {
    ElMessage.warning('请输入评论内容');
    return;
  }

  try {
    const courseId = Number(route.query.courseId);
    const res = await axios.post('/api/comments', {
      content: newComment.value.content,
      courseId: courseId
    });
    
    // 重新加载评论列表
    await loadComments(courseId);
    
    // 清空输入框并关闭对话框
    newComment.value.content = '';
    showAddCommentDialog.value = false;
    
    ElMessage.success('评论发表成功');
  } catch (e) {
    console.error('评论发表失败', e);
    ElMessage.error('评论发表失败');
  }
}
</script>

<style scoped>
.discussion-container {
  max-width: 1200px;
  margin: 40px auto;
}

.speech-header {
  border-bottom: 1px solid #eee;
  padding-bottom: 20px;
  margin-bottom: 30px;
}

.speech-header h2 {
  margin: 0 0 10px 0;
  color: #333;
}

.speech-info {
  color: #666;
  margin: 0;
}

.questions-section {
  margin-bottom: 40px;
}

.questions-section h3 {
  margin-bottom: 20px;
  color: #333;
}

.discussion-section {
  border-top: 1px solid #eee;
  padding-top: 30px;
}

.discussion-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.discussion-header h3 {
  margin: 0;
  color: #333;
}

.comments-list {
  min-height: 200px;
}

.no-comments {
  text-align: center;
  color: #999;
  padding: 40px 0;
}

.comment-item {
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
  background-color: #fafafa;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.username {
  font-weight: bold;
  color: #409eff;
}

.time {
  color: #999;
  font-size: 12px;
}

.comment-content {
  color: #333;
  line-height: 1.6;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style> 