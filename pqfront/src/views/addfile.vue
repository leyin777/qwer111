
<template>
  <div class="addfile-container">
    <el-upload
      class="upload-demo"
      drag
      action="http://159.75.90.202:8000/aipqapi/extract"
      :data="{ uid: userId }"
      :headers="headers"
      :on-success="handleSuccess"
      :on-error="handleError"
      :show-file-list="true"
      multiple
    >
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
      <div class="el-upload__tip" slot="tip">支持多文件上传</div>
    </el-upload>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'

const userId = ref('')
const headers = {}

onMounted(() => {
  userId.value = localStorage.getItem('userId') || ''
})

function handleSuccess(response, file, fileList) {
  ElMessage.success('文件上传成功')
}
function handleError(err, file, fileList) {
  ElMessage.error('文件上传失败')
}
</script>

<style scoped>
.addfile-container {
  max-width: 500px;
  margin: 40px auto;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  padding: 32px 24px 16px 24px;
}
</style>
