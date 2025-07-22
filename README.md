AI-coding为刚开始时练习代码，与项目无关
pqbackmain为后端代码，pqfront为前端代码，AIpq为信息处理及生成题目的后端代码，目前AIpq尚未与项目整体结合。

# 项目说明
108.sql为mysql数据库

AIpq为python后端,实现模态转换和生成问题的api，pdf,txt,doc,docx,ppt,pptx,常见音频视频转换成文本，目前未与项目整体适配，
使用conda管理环境。使用python的fastapi部署在本地8000端口进行本地测试，需要依赖有python-multipart、python-pptx、python-docx、pdfplumber，easyocr等,使用工具poppler等,因为需要配置环境较复杂，这部分后端打包成docker镜像，并将带dockerfile构建文件夹上传到仓库，命名为aipqapi，启动docker，docker build一下即可。docker镜像部署到服务器上

运行说明：
pqfront在vscode中允许，pqbackmain在IDEA中运行，数据库中有部分数据可以完成部分功能


