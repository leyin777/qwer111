# 讨论区功能说明

## 功能概述
在Student.vue页面新增了"即时讨论区"按钮，用户可以在演讲开始后30分钟到1小时之间进入讨论区进行交流。

## 功能特性

### 1. 时间控制
- 演讲开始前30分钟：按钮禁用，显示"讨论区还未开放"
- 演讲开始后30分钟到1小时：按钮可用，可以正常进入讨论区
- 演讲开始1小时后：按钮禁用，显示"讨论时间已结束"

### 2. 讨论区页面功能
- **演讲信息展示**：显示演讲标题、地点、时间
- **问题及答案展示**：显示该演讲的所有问题及正确答案
- **评论功能**：用户可以查看和发表评论

## 技术实现

### 前端文件
- `pqfront/src/views/Student.vue` - 修改了学生页面，添加讨论区按钮
- `pqfront/src/views/Discussion.vue` - 新增讨论区页面
- `pqfront/src/router/index.js` - 添加讨论区路由

### 后端文件
- `pqbackmain/src/main/java/com/example/controller/CommentController.java` - 评论控制器
- `pqbackmain/src/main/java/com/example/entity/Comment.java` - 评论实体类
- `pqbackmain/src/main/java/com/example/service/CommentService.java` - 评论服务
- `pqbackmain/src/main/java/com/example/mapper/CommentMapper.java` - 评论数据访问层
- `pqbackmain/src/main/resources/mapper/CommentMapper.xml` - MyBatis映射文件
- `pqbackmain/comments_table.sql` - 评论表创建SQL

## API接口

### 评论相关接口
- `GET /api/comments?courseId={courseId}` - 获取课程的所有评论
- `POST /api/comments` - 添加新评论
- `DELETE /api/comments/{id}` - 删除评论

### 数据格式
```json
// 评论对象
{
  "id": 1,
  "content": "评论内容",
  "username": "用户名",
  "courseId": 1,
  "createTime": "2024-01-01 12:00:00"
}
```

## 数据库表结构

### comments表
```sql
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL COMMENT '评论内容',
    username VARCHAR(100) NOT NULL COMMENT '用户名',
    course_id INT NOT NULL COMMENT '课程ID',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_course_id (course_id),
    INDEX idx_create_time (create_time)
);
```

## 使用说明

1. 用户登录后进入学生页面
2. 在演讲列表中，每个演讲都有"即时讨论区"按钮
3. 根据演讲时间，按钮会自动启用或禁用
4. 点击可用的"即时讨论区"按钮进入讨论页面
5. 在讨论页面可以查看演讲信息和问题答案
6. 点击"新增评论"按钮发表评论

## 注意事项

- 讨论区只在演讲开始后30分钟到1小时之间开放
- 评论功能目前使用匿名用户，后续可以集成用户系统
- 需要先创建comments表才能正常使用评论功能 