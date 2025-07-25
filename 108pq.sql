/*
<<<<<<< HEAD
 Navicat Premium Data Transfer

 Source Server         : 数据库
=======
 Navicat Premium Dump SQL

 Source Server         : 108666
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : 108pq

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

<<<<<<< HEAD
 Date: 25/07/2025 23:32:24
=======
 Date: 25/07/2025 18:35:37
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
<<<<<<< HEAD
-- Table structure for addfile
-- ----------------------------
DROP TABLE IF EXISTS `addfile`;
CREATE TABLE `addfile`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `filee` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `qid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addfile
-- ----------------------------
INSERT INTO `addfile` VALUES (1, '顶顶顶顶顶顶', 1);

-- ----------------------------
=======
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9
-- Table structure for answer_record
-- ----------------------------
DROP TABLE IF EXISTS `answer_record`;
CREATE TABLE `answer_record`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `qid` int NULL DEFAULT NULL,
  `question_id` int NULL DEFAULT NULL,
  `user_answer_index` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `correct` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
<<<<<<< HEAD
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;
=======
) ENGINE = InnoDB AUTO_INCREMENT = 118 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Records of answer_record
-- ----------------------------
INSERT INTO `answer_record` VALUES (78, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (79, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (80, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (81, 1, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (82, 1, 105, 105, '0', 1);
INSERT INTO `answer_record` VALUES (88, 2, 101, 101, '0', 0);
INSERT INTO `answer_record` VALUES (89, 2, 102, 102, '0', 0);
INSERT INTO `answer_record` VALUES (90, 2, 103, 103, '0', 0);
INSERT INTO `answer_record` VALUES (91, 2, 104, 104, '0', 0);
INSERT INTO `answer_record` VALUES (92, 2, 105, 105, '1', 0);
INSERT INTO `answer_record` VALUES (93, 3, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (94, 3, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (95, 3, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (96, 3, 104, 104, '0', 0);
INSERT INTO `answer_record` VALUES (97, 3, 105, 105, '1', 0);
INSERT INTO `answer_record` VALUES (98, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (99, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (100, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (101, 1, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (102, 1, 105, 105, '0', 1);
INSERT INTO `answer_record` VALUES (103, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (104, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (105, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (106, 1, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (107, 1, 105, 105, '3', 0);
INSERT INTO `answer_record` VALUES (108, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (109, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (110, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (111, 1, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (112, 1, 105, 105, '0', 1);
<<<<<<< HEAD
INSERT INTO `answer_record` VALUES (113, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (114, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (115, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (116, 1, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (117, 1, 105, 105, '0', 1);
INSERT INTO `answer_record` VALUES (118, 2, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (119, 2, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (120, 2, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (121, 2, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (122, 2, 105, 105, '0', 1);
INSERT INTO `answer_record` VALUES (123, 1, 101, 101, '0', 0);
INSERT INTO `answer_record` VALUES (124, 1, 102, 102, '1', 0);
INSERT INTO `answer_record` VALUES (125, 1, 103, 103, '2', 0);
INSERT INTO `answer_record` VALUES (126, 1, 104, 104, '2', 0);
INSERT INTO `answer_record` VALUES (127, 1, 105, 105, '1', 0);
=======
INSERT INTO `answer_record` VALUES (113, 1, 101, 101, '3', 0);
INSERT INTO `answer_record` VALUES (114, 1, 102, 102, '1', 0);
INSERT INTO `answer_record` VALUES (115, 1, 103, 103, '3', 0);
INSERT INTO `answer_record` VALUES (116, 1, 104, 104, '3', 0);
INSERT INTO `answer_record` VALUES (117, 1, 105, 105, '2', 0);
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `course_id` int NOT NULL COMMENT '课程ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'audience',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_course_id`(`course_id` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
<<<<<<< HEAD
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;
=======
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (10, '我是王老板', 'wanglaoban', 1, '2025-07-21 16:25:32', '');
INSERT INTO `comments` VALUES (11, '我是王老师', 'wanglaoshi', 1, '2025-07-21 16:26:06', '');
INSERT INTO `comments` VALUES (12, '1234', 'wangtongxue', 1, '2025-07-21 16:26:47', '');
INSERT INTO `comments` VALUES (13, '11', 'wanglaoshi', 1, '2025-07-25 17:18:54', '');
INSERT INTO `comments` VALUES (14, '11', 'wangtongxue', 1, '2025-07-25 17:19:58', '');
INSERT INTO `comments` VALUES (15, '11111', 'wangtongxue', 1, '2025-07-25 17:24:47', '');
INSERT INTO `comments` VALUES (16, '11', 'wangtongxue', 1, '2025-07-25 17:25:05', '');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `speakername` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `place` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `time` datetime NOT NULL,
  `max_people` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
<<<<<<< HEAD
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-25 16:10:25', 100);
=======
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-25 18:10:25', 100);
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9
INSERT INTO `course` VALUES (2, 'wanglaoshi', 'vue基础', '102', '2025-07-14 17:20:54', 120);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `qid` int NULL DEFAULT NULL,
  `uid` int NULL DEFAULT NULL,
  `too_fast` int NULL DEFAULT NULL,
  `too_slow` int NULL DEFAULT NULL,
  `boring` int NULL DEFAULT NULL,
  `bad_question` int NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (2, 1, 1, 1, 1, 1, 1, '11111111', '2025-07-19 17:48:26');
INSERT INTO `feedback` VALUES (3, 1, 3, 1, 0, 0, 0, '1', '2025-07-19 17:55:05');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
<<<<<<< HEAD
  `id` int NOT NULL AUTO_INCREMENT,
=======
  `id` int NULL DEFAULT NULL,
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9
  `text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `correct` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `qid` int NULL DEFAULT NULL,
<<<<<<< HEAD
  `accuracy` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;
=======
  `accuracy` float NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Records of question
-- ----------------------------
<<<<<<< HEAD
=======
INSERT INTO `question` VALUES (101, '中国的首都是哪座？', '上海', '北京', '深圳', '重庆', 'B', 1, 0.714286);
INSERT INTO `question` VALUES (102, '2 + 2 = ?', '1', '2', '3', '4', 'D', 1, 0.714286);
INSERT INTO `question` VALUES (103, '下列哪项是编程语言？', 'vue', 'python', 'css', 'html', 'B', 1, 0.714286);
INSERT INTO `question` VALUES (104, '地球上最大的动物是？', '大象', '蓝鲸', '老鼠', '麻雀', 'B', 1, 0.571429);
INSERT INTO `question` VALUES (105, '太阳从哪边升起？', '东', '南', '西', '北', 'A', 1, 0.428571);
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Table structure for rankk
-- ----------------------------
DROP TABLE IF EXISTS `rankk`;
CREATE TABLE `rankk`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NULL DEFAULT NULL,
  `qid` int NULL DEFAULT NULL,
  `accuracy` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ranking` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rankk
-- ----------------------------
<<<<<<< HEAD
INSERT INTO `rankk` VALUES (13, 1, 1, '100.00', '1');
INSERT INTO `rankk` VALUES (14, 3, 1, '60.00', '2');
INSERT INTO `rankk` VALUES (16, 2, 1, '0.00', '3');
=======
INSERT INTO `rankk` VALUES (13, 1, 1, '0.00', '2');
INSERT INTO `rankk` VALUES (14, 3, 1, '60.00', '1');
INSERT INTO `rankk` VALUES (16, 2, 1, '0.00', '2');
>>>>>>> aa160017106f85071d702a1b6dd5764135ac3ba9

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'wangtongxue', '111', '1111111111@qq.com', 'audience');
INSERT INTO `user` VALUES (2, 'zhangyetongxue', '222', '2222222222@qq.com', 'audience');
INSERT INTO `user` VALUES (3, 'linmiaotongxue', '333', '3333333333@qq.com', 'audience');
INSERT INTO `user` VALUES (4, 'wanglaoshi', '111', '4444444444@qq.com', 'speaker');
INSERT INTO `user` VALUES (5, 'zhangyelaoshi', '111', '5555555555@qq.com', 'speaker');
INSERT INTO `user` VALUES (6, 'linmiaolaoshi', '111', '6666666666@qq.com', 'speaker');
INSERT INTO `user` VALUES (7, 'wanglaoban', '111', '7777777777@qq.com', 'organizer');
INSERT INTO `user` VALUES (8, 'zhangyelaoban', '111', '8888888888@qq.com', 'organizer');
INSERT INTO `user` VALUES (9, 'linmiaolaoban', '111', '9999999999@qq.com', 'organizer');

SET FOREIGN_KEY_CHECKS = 1;
