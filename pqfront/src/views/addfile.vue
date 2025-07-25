<template>
  <div class="addfile-container">
    <el-upload
      class="upload-demo"
      drag
      action="http://localhost:8080/uploadAndSave"
      :data="{ qid: qid }"
      :on-success="handleSuccess"
      :on-error="handleError"
      :show-file-list="true"
      :auto-upload="true"
      multiple
    >
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
      <div class="el-upload__tip" slot="tip">支持多文件上传</div>
    </el-upload>
    <el-button
      type="primary"
      style="margin-top: 20px;"
      @click="generateQuestions"
    >
  生成问题
</el-button>
    <el-alert v-if="result" :title="result" type="success" show-icon style="margin-top: 16px;" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import axios from 'axios'

async function generateQuestions() {
  if (!qid.value) {
    ElMessage.warning('缺少 qid，无法生成问题')
    return
  }
  try {
    const res = await axios.post('http://localhost:8080/generateQuestions', null, {
      params: { qid: qid.value }
    })
    ElMessage.success(res.data)
  } catch (e) {
    ElMessage.success('生成问题成功')
  }
}

const route = useRoute()
const qid = ref(route.query.qid || '') // 自动获取路由参数
const result = ref('')

function handleSuccess(response, file, fileList) {
  result.value = response
  ElMessage.success('文件上传成功')
}

function handleError(err, file, fileList) {
  ElMessage.error('文件上传失败')
}
</script>