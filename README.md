AI-coding为刚开始时练习代码，与项目无关
pqbackmain为后端代码，pqfront为前端代码，AIpq为信息处理及生成题目的后端代码，目前AIpq尚未与项目整体结合。

# 项目说明
108666.sql为mysql数据库

AIpq为python后端,暂时实现模态转换，pdf,txt,doc,docx转换成文本，pqback是信息处理，目前未与项目整体适配，暂时无法完成测试用例，
使用conda管理环境。使用python的fastapi部署在本地8000端口进行本地测试，需要依赖有python-multipart、python-pptx、python-docx、pdfplumber、paddlepaddle、paddleocr 等

运行说明：
pqfront在vscode中运行，pqbackmain在IDEA中运行，可以完成主要功能。

