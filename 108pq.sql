/*
 Navicat Premium Data Transfer

 Source Server         : 数据库
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : 108pq

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 26/07/2025 03:39:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addfile
-- ----------------------------
DROP TABLE IF EXISTS `addfile`;
CREATE TABLE `addfile`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `filee` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `qid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addfile
-- ----------------------------

-- ----------------------------
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
) ENGINE = InnoDB AUTO_INCREMENT = 138 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of answer_record
-- ----------------------------
INSERT INTO `answer_record` VALUES (128, 1, 143, 143, '0', 0);
INSERT INTO `answer_record` VALUES (129, 1, 144, 144, '1', 0);
INSERT INTO `answer_record` VALUES (130, 1, 145, 145, '0', 0);
INSERT INTO `answer_record` VALUES (131, 1, 146, 146, '1', 0);
INSERT INTO `answer_record` VALUES (132, 1, 147, 147, '0', 0);
INSERT INTO `answer_record` VALUES (133, 1, 148, 148, '1', 1);
INSERT INTO `answer_record` VALUES (134, 1, 149, 149, '1', 1);
INSERT INTO `answer_record` VALUES (135, 1, 150, 150, '2', 0);
INSERT INTO `answer_record` VALUES (136, 1, 151, 151, '3', 0);
INSERT INTO `answer_record` VALUES (137, 1, 152, 152, '2', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `comments` VALUES (18, '111111', 'wanglaoban', 6, '2025-07-26 03:33:50', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-25 16:10:25', 100);
INSERT INTO `course` VALUES (2, 'wanglaoshi', 'vue基础', '102', '2025-07-14 17:20:54', 120);
INSERT INTO `course` VALUES (4, 'zhangsan', '1', '2', '2025-07-25 18:50:01', 7);
INSERT INTO `course` VALUES (5, 'lisi', '2', '22222222', '2025-07-26 03:14:49', 100);
INSERT INTO `course` VALUES (6, 'liwu', '33', '3333', '2025-07-26 01:28:54', 100);

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (2, 1, 1, 1, 1, 1, 1, '11111111', '2025-07-19 17:48:26');
INSERT INTO `feedback` VALUES (3, 1, 3, 1, 0, 0, 0, '1', '2025-07-19 17:55:05');
INSERT INTO `feedback` VALUES (4, 6, 1, 1, 1, 1, 1, '1111111', '2025-07-26 03:31:25');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ansd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `correct` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `qid` int NULL DEFAULT NULL,
  `accuracy` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of question
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rankk
-- ----------------------------
INSERT INTO `rankk` VALUES (13, 1, 1, '100.00', '1');
INSERT INTO `rankk` VALUES (14, 3, 1, '60.00', '2');
INSERT INTO `rankk` VALUES (16, 2, 1, '0.00', '3');
INSERT INTO `rankk` VALUES (17, 1, 5, '0.00', '1');
INSERT INTO `rankk` VALUES (18, 1, 6, '40.00', '1');

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `user` VALUES (10, 'zhangsan', '111', '2803688794@qq.com', 'speaker');
INSERT INTO `user` VALUES (11, 'lisi', '111', '2803688794@qq.com', 'speaker');
INSERT INTO `user` VALUES (12, 'liwu', '111', '2803688794@qq.com', 'speaker');

SET FOREIGN_KEY_CHECKS = 1;
