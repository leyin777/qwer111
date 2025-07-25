# QuizMaster

# 项目说明
AI-coding为刚开始时练习代码，与项目无关
pqbackmain为java后端代码，pqfront为前端代码，AIpq为python文本处理及生成题目的后端代码,aipqapi为构建docker镜像的文件夹。108pq.sql为mysql数据库

# 项目概述
QuizMaster 是一个多模态教学互动平台，能够将各种格式的教学内容转化为互动测试题目，并通过网页应用实现教师、学生和组织者之间的高效互动。系统支持文本、PPT、PDF和音频等多种输入格式，利用AI技术自动生成高质量选择题，并提供全面的答题统计和反馈功能。

# 主要功能
1. 多模态输入处理
文本文件处理：提取纯文本内容

PowerPoint文件处理：提取幻灯片文本和备注

PDF文件处理：提取文本内容

音频文件处理：语音转文字

视频文件处理：提取字幕和画面文字

2. AI题目生成
自动生成四选一选择题

题目难度控制，避免肤浅问题

持续优化机制，通过反馈循环提高题目质量

题目生成时间控制在10秒以内

3. 用户交互与反馈

学生功能：

答题界面（开课后半小时内可以答题，半小时后关闭答题区）

答题统计（正确率、排名）

题目反馈（太难、太简单等）

参与题目讨论区（开课半小时后打开评论区）

 教师功能：

查看班级答题统计

接收学生反馈

管理课程内容

 组织者功能：

管理多个课程和测试

查看整体参与度和正确率

分析教学效果

## 前端结构表
pqfront

├─ index.html                # 项目入口 HTML 文件

├─ jsconfig.json             # JavaScript 配置文件，通常用于路径别名等

├─ package-lock.json         # npm 自动生成的依赖锁定文件，保证依赖一致性

├─ package.json              # 项目依赖及脚本配置文件

├─ pqfront.iml               # IDE（如 IntelliJ IDEA）生成的项目配置文件

├─ README_DISCUSSION.md      # 讨论相关的说明文档

├─ README.md                 # 项目主说明文档

├─ vite.config.js            # Vite 构建工具的配置文件

│

├─ public/                   # 公共资源目录，构建时会被直接复制到输出目录

│   └─ favicon.ico           # 网站图标

│

└─ src/                      # 源码目录

    ├─ App.vue               # Vue 根组件
    
    ├─ main.js               # 项目入口 JS 文件，初始化 Vue 应用
    
    ├─ assets/               # 静态资源目录（如样式、图片等）
    
    │   ├─ base.css          # 基础样式文件
    
    │   ├─ logo.svg          # 项目 logo
    
    │   └─ main.css          # 主样式文件
    
    │

    │
    
    ├─ router/               # 路由配置目录
    
    │   └─ index.js          # Vue Router 配置文件
    
    │
    
    └─ views/                # 页面级组件目录
    
        ├─ AddCourse.vue     # 添加课程页面
        
        ├─ Admin.vue         # 管理员页面
        
        ├─ Ans.vue           # 答案页面
        
        ├─ ansinf.vue        # 答案信息页面
        
        ├─ CourseList.vue    # 课程列表页面
        
        ├─ Discussion.vue    # 讨论区页面
        
        ├─ Feedback.vue      # 反馈页面
        
        ├─ Login.vue         # 登录页面
        
        ├─ Register.vue      # 注册页面
        
        ├─ Speaker.vue       # 演讲者页面
        
        └─ Student.vue       # 学生页面
## 后端结构表
pqbackmain

├─ src/

│ ├─ main/

│ │ ├─ java/

│ │ │ └─ com/

│ │ │ └─ example/

│ │ │ ├─ Application.java # Spring Boot 启动类，项目入口

│ │ │ │

│ │ │ ├─ controller/ # 控制器层，处 HTTP 请求

│ │ │ ├─ entity/ # 实体类，数据库表映射

│ │ │ ├─ mapper/ # MyBatis Mapper 接口，数据库操作

│ │ │ ├─service/ # 业务逻辑层

│ │ └─ resources/

│ │ ├─ application.properties # Spring Boot 配置文件（属性格式）

│ │ ├─ application.yml # Spring Boot 配置文件（YAML 格式）

│ │ └─ mapper/ # MyBatis 映射文件（SQL 语句）

## 前端部署
使用VS CODE打开pqfront文件夹，在终端运行下面三条语句完成相关配置（要以管理员身份打开），安装好后重启软件即可
1. 安装 Vue 3 相关依赖
npm install vue@next vue-router@4

2. 安装 Element Plus（UI 组件库）
npm install element-plus

3. 安装 Axios（HTTP 请求库）
npm install axios

## java后端部署
使用IDEA打开pqbackmain文件夹，等待相关依赖下载即可（采用java17，若有报错请检查Java版本）

## 数据库部署
使用navicat创建一个名为108pq的mysql数据库，然后运行108pq.sql文件，即部署完成。不使用navicat图形界面，直接使用mysql命令也可以。

## python转化文字和问题生成后端本地部署和远程部署
AIpq为python后端,实现模态转换和生成问题的api，pdf,txt,doc,docx,ppt,pptx,常见音频视频转换成文本，
使用conda管理环境。使用python的fastapi部署在本地8000端口进行本地测试，需要依赖有python-multipart、python-pptx、python-docx、pdfplumber，easyocr等,使用工具poppler等。aipqapi文件夹中requirements.txt已包含所需依赖。（如使用镜像源，需要找有pytorch-gpu版本的源，本项目使用的easyocr依赖pytorch，图片识别时gpu加速需要使用cuda，需要安装pytorch-gpu版本调用cuda库,常用的清华源是不支持下载带cuda版本的pytorch的，同理docekrfile中默认使用清华源安装依赖，所以有需要请自行更改。如果不安装cuda版本的pytorch也可以，只不过使用cpu运行，在转化较多图片的文件时速度较慢，测试用pptx花费约2-3分钟，而测试用pdf则无这个问题）
### 本地直接部署
直接下载AIpq项目，并下载工具poppler(用于将pdf转化为图片)和libreoffice(将ppt，doc转化成pptx,docx)配置系统环境变量，方便程序调用。运行main.py后等待模型下载完成即可

### 本地docker部署
因为配置环境较复杂，需要相应依赖，模型，工具。这部分后端使用docker部署，打包成docker镜像。带dockerfile构建文件夹已经上传到仓库，命名为aipqapi，模型文件较大未上传，所以先下载模型，前两个放入models文件夹，后一个放入whisper,不下载也可以（记得删掉dockerfile中相关导入模型的命令），只不过每次docker run时需要重新下载比较慢。


#### 模型下载说明
| 文件名             | 来源            | 下载地址                                                                                     |
|-------------------|-----------------|--------------------------------------------------------------------------------------------- |
| craft_mlt_25k.pth | CRAFT 文本检测   |  https://github.com/JaidedAI/EasyOCR/releases/download/pre-v1.1.6/craft_mlt_25k.zip|
| zh_sim_g2.pth     | EasyOCR 中文识别 | https://github.com/JaidedAI/EasyOCR/releases/download/v1.3/zh_sim_g2.zip   | 
| base.pt           | Whisper 基础模型 | https://openaipublic.azureedge.net/main/whisper/models/ed3a0b6b1c0edf879ad9b11b1af5a0e6ab5db9205f891f668f8b0e6c6326e34e/base.pt|                        

本地部署需要启动docker，在aipqapi文件夹中启动cmd。

docker build -t aipqapi:v2 .

docker run --rm -it -p 8000:8000 --name aipqapi aipqapi:v2

### 远程部署
docker镜像已经部署到服务器上，路径为http://159.75.90.202:8000/aipqapi/extract（/generate)
两个功能分别为各模态转化文字和生成问题。但由于服务器主机性能问题（免费试用的双核2GB内存），在ppt(非pptx),doc(非docx)，以及较长pptx的转化都是会有问题的，这些在本地测试时都是通过的。且使用的ai apikey是免费的，有输入字数限制，，新AIpq使用另外apikey,所以建议本地部署以达到最好效果。也可以docker run 时更改一下apikey的环境变量。新的key写在AIpq中aiapiclient.py中作为默认值

<img width="536" height="255" alt="image" src="https://github.com/user-attachments/assets/51f82c3a-9624-4560-bde2-5f0475ad471c" />



运行说明：
pqfront在vscode中允许，pqbackmain在IDEA中运行，数据库中有部分数据可以完成部分功能


