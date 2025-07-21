/*
 Navicat Premium Dump SQL

 Source Server         : 108pq
 Source Server Type    : MySQL
 Source Server Version : 50727 (5.7.27)
 Source Host           : localhost:3306
 Source Schema         : 108666

 Target Server Type    : MySQL
 Target Server Version : 50727 (5.7.27)
 File Encoding         : 65001

 Date: 19/07/2025 14:59:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer_record
-- ----------------------------
DROP TABLE IF EXISTS `answer_record`;
CREATE TABLE `answer_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `qid` int(11) NULL DEFAULT NULL,
  `question_id` int(11) NULL DEFAULT NULL,
  `user_answer_index` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `correct` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer_record
-- ----------------------------
INSERT INTO `answer_record` VALUES (2, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (3, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (4, 1, 103, 103, '3', 0);
INSERT INTO `answer_record` VALUES (5, 1, 104, 104, '3', 0);
INSERT INTO `answer_record` VALUES (6, 1, 105, 105, '3', 0);
INSERT INTO `answer_record` VALUES (7, 3, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (8, 3, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (9, 3, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (10, 3, 104, 104, '1', 1);
INSERT INTO `answer_record` VALUES (11, 3, 105, 105, '0', 1);
INSERT INTO `answer_record` VALUES (12, 1, 101, 101, '1', 1);
INSERT INTO `answer_record` VALUES (13, 1, 102, 102, '3', 1);
INSERT INTO `answer_record` VALUES (14, 1, 103, 103, '1', 1);
INSERT INTO `answer_record` VALUES (15, 1, 104, 104, '2', 0);
INSERT INTO `answer_record` VALUES (16, 1, 105, 105, '3', 0);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `speakername` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `place` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` datetime NOT NULL,
  `max_people` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-14 12:20:25', 100);
INSERT INTO `course` VALUES (2, 'wanglaoshi', 'vue基础', '102', '2025-07-14 17:20:54', 120);

-- ----------------------------
-- Table structure for discussions
-- ----------------------------
DROP TABLE IF EXISTS `discussions`;
CREATE TABLE `discussions`  (
  `id` int(11) NOT NULL,
  `qid` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of discussions
-- ----------------------------

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int(11) NOT NULL,
  `qid` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `too_fast` int(11) NULL DEFAULT NULL,
  `too_slow` int(11) NULL DEFAULT NULL,
  `boring` int(11) NULL DEFAULT NULL,
  `bad_question` int(11) NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int(11) NULL DEFAULT NULL,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ansa` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ansb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ansc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ansd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `correct` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qid` int(11) NULL DEFAULT NULL,
  `accuracy` float NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (101, '中国的首都是哪座城市？', '上海', '北京', '深圳', '重庆', 'B', 1, 1);
INSERT INTO `question` VALUES (102, '2 + 2 = ?', '1', '2', '3', '4', 'D', 1, 1);
INSERT INTO `question` VALUES (103, '下列哪项是编程语言？', 'vue', 'python', 'css', 'html', 'B', 1, 0.666667);
INSERT INTO `question` VALUES (104, '地球上最大的动物是？', '大象', '蓝鲸', '老鼠', '麻雀', 'B', 1, 0.333333);
INSERT INTO `question` VALUES (105, '太阳从哪边升起？', '东', '南', '西', '北', 'A', 1, 0.333333);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
