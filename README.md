AI-coding为刚开始时练习代码，与项目无关
# 项目说明
pqbackmain为后端代码，pqfront为前端代码，AIpq为信息处理及生成题目的后端代码，目前AIpq尚未与项目整体结合。108.sql为mysql数据库

# 数据库

# 转化文字和问题生成后端部署
AIpq为python后端,实现模态转换和生成问题的api，pdf,txt,doc,docx,ppt,pptx,常见音频视频转换成文本，目前未与项目整体适配，
使用conda管理环境。使用python的fastapi部署在本地8000端口进行本地测试，需要依赖有python-multipart、python-pptx、python-docx、pdfplumber，easyocr等,使用工具poppler等。

因为需要配置环境较复杂，这部分后端打包成docker镜像，并将带dockerfile构建文件夹上传到仓库，命名为aipqapi，模型文件较大，所以先下载模型，前两个放入models文件夹，后一个放入whisper,不下载也可以，只不过每次docker run时需要重新下载比较慢。
文件夹中requirements.txt已包含所需依赖。

## 模型下载说明
| 文件名             | 来源            | 下载地址                                                                                     |
|-------------------|-----------------|--------------------------------------------------------------------------------------------- |
| craft_mlt_25k.pth | CRAFT 文本检测   | (https://drive.google.com/uc?id=1Jk4eGD7crsqCCg9C9VjCLkMN3ze8kutZ)             |
| zh_sim_g2.pth     | EasyOCR 中文识别 | (https://github.com/JaidedAI/EasyOCR/releases/download/v1.3/zh_sim_g2.pth)   | 
| base.pt           | Whisper 基础模型 | (https://openaipublic.azureedge.net/main/whisper/models/ed3a0b6b1c0edf879ad9b11b1af5a0e6ab5db9205f891f668f8b0e6c6326e34e/base.pt) |                        

本地部署需要启动docker，在aipqapi文件夹中启动cmd

docker build -t aipqapi:v2 .

docker run --rm -it -p 8000:8000 --name aipqapi aipqapi:v2

docker镜像已经部署到服务器上，路径为http://159.75.90.202:8000/aipqapi/extract（/generate)
两个功能分别为各模态转化文字和生成问题。但由于服务器主机性能问题，在ppt(非pptx),doc(非docx)，以及较长pptx的转化都是会有问题的，而这些在本地测试时都是通过的，所以建议本地部署docker镜像以达到最好效果。

运行说明：
pqfront在vscode中允许，pqbackmain在IDEA中运行，数据库中有部分数据可以完成部分功能


