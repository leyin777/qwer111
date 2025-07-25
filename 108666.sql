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

 Date: 25/07/2025 16:14:47
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
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-25 16:10:25', 100);
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qid` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `too_fast` int(11) NULL DEFAULT NULL,
  `too_slow` int(11) NULL DEFAULT NULL,
  `boring` int(11) NULL DEFAULT NULL,
  `bad_question` int(11) NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `question` VALUES (101, '中国的首都是哪座？', '上海', '北京', '深圳', '重庆', 'B', 1, 0.833333);
INSERT INTO `question` VALUES (102, '2 + 2 = ?', '1', '2', '3', '4', 'D', 1, 0.833333);
INSERT INTO `question` VALUES (103, '下列哪项是编程语言？', 'vue', 'python', 'css', 'html', 'B', 1, 0.833333);
INSERT INTO `question` VALUES (104, '地球上最大的动物是？', '大象', '蓝鲸', '老鼠', '麻雀', 'B', 1, 0.666667);
INSERT INTO `question` VALUES (105, '太阳从哪边升起？', '东', '南', '西', '北', 'A', 1, 0.5);

-- ----------------------------
-- Table structure for rank
-- ----------------------------
DROP TABLE IF EXISTS `rank`;
CREATE TABLE `rank`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `qid` int(11) NULL DEFAULT NULL,
  `accuracy` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ranking` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rank
-- ----------------------------
INSERT INTO `rank` VALUES (13, 1, 1, '100.00', '1');
INSERT INTO `rank` VALUES (14, 3, 1, '60.00', '2');
INSERT INTO `rank` VALUES (16, 2, 1, '0.00', '3');

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
