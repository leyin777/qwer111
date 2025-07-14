# 项目说明
108.sql为mysql数据库
pqback为python后端,暂时实现模态转换，pdf,txt,doc,docx转换成文本
使用conda管理环境。
使用python的fastapi部署在本地8000端口进行本地测试
需要依赖有
//api部署
fastapi
uvicorn[standard]
python-multipart
//文本/PPT/PDF/doc/docx 解析
python-pptx
python-docx
pdfplumber
olefile # 读取旧 .ppt
pdf2image # PDF 转图片
Pillow # 图片处理（pdf2image 依赖）
//OCR
paddlepaddle # CPU 版（如需 GPU 换 paddlepaddle-gpu）
paddleocr
