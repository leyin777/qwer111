/*
 Navicat Premium Dump SQL

 Source Server         : 108666
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : 108

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 14/07/2025 23:31:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer`  (
  ` id` int NOT NULL,
  `user\_id` int NULL DEFAULT NULL,
  `question\_id` int NULL DEFAULT NULL,
  `answer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is\_correct` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (` id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES (1, 1, 1, NULL, NULL);
INSERT INTO `answer` VALUES (2, 1, 2, NULL, NULL);
INSERT INTO `answer` VALUES (3, 1, 3, NULL, NULL);
INSERT INTO `answer` VALUES (4, 1, 4, NULL, NULL);
INSERT INTO `answer` VALUES (5, 1, 5, NULL, NULL);
INSERT INTO `answer` VALUES (6, 1, 6, NULL, NULL);
INSERT INTO `answer` VALUES (7, 1, 7, NULL, NULL);
INSERT INTO `answer` VALUES (8, 1, 8, NULL, NULL);
INSERT INTO `answer` VALUES (9, 1, 9, NULL, NULL);
INSERT INTO `answer` VALUES (10, 1, 10, NULL, NULL);
INSERT INTO `answer` VALUES (11, 1, 11, NULL, NULL);
INSERT INTO `answer` VALUES (12, 1, 12, NULL, NULL);
INSERT INTO `answer` VALUES (13, 1, 13, NULL, NULL);
INSERT INTO `answer` VALUES (14, 1, 14, NULL, NULL);
INSERT INTO `answer` VALUES (15, 1, 15, NULL, NULL);
INSERT INTO `answer` VALUES (16, 2, 1, NULL, NULL);
INSERT INTO `answer` VALUES (17, 2, 2, NULL, NULL);
INSERT INTO `answer` VALUES (18, 2, 3, NULL, NULL);
INSERT INTO `answer` VALUES (19, 2, 4, NULL, NULL);
INSERT INTO `answer` VALUES (20, 2, 5, NULL, NULL);
INSERT INTO `answer` VALUES (21, 2, 6, NULL, NULL);
INSERT INTO `answer` VALUES (22, 2, 7, NULL, NULL);
INSERT INTO `answer` VALUES (23, 2, 8, NULL, NULL);
INSERT INTO `answer` VALUES (24, 2, 9, NULL, NULL);
INSERT INTO `answer` VALUES (25, 2, 10, NULL, NULL);
INSERT INTO `answer` VALUES (26, 2, 11, NULL, NULL);
INSERT INTO `answer` VALUES (27, 2, 12, NULL, NULL);
INSERT INTO `answer` VALUES (28, 2, 13, NULL, NULL);
INSERT INTO `answer` VALUES (29, 2, 14, NULL, NULL);
INSERT INTO `answer` VALUES (30, 2, 15, NULL, NULL);
INSERT INTO `answer` VALUES (31, 3, 1, '', NULL);
INSERT INTO `answer` VALUES (32, 3, 2, '', NULL);
INSERT INTO `answer` VALUES (33, 3, 3, '', NULL);
INSERT INTO `answer` VALUES (34, 3, 4, '', NULL);
INSERT INTO `answer` VALUES (35, 3, 5, '', NULL);
INSERT INTO `answer` VALUES (36, 3, 6, '', NULL);
INSERT INTO `answer` VALUES (37, 3, 7, '', NULL);
INSERT INTO `answer` VALUES (38, 3, 8, '', NULL);
INSERT INTO `answer` VALUES (39, 3, 9, '', NULL);
INSERT INTO `answer` VALUES (40, 3, 10, '', NULL);
INSERT INTO `answer` VALUES (41, 3, 11, '', NULL);
INSERT INTO `answer` VALUES (42, 3, 12, '', NULL);
INSERT INTO `answer` VALUES (43, 3, 13, '', NULL);
INSERT INTO `answer` VALUES (44, 3, 14, '', NULL);
INSERT INTO `answer` VALUES (45, 3, 15, '', NULL);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `speakername` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `place` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `maximum number of people` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', 'wanglaoshi', '中国近代史', 'C-108', '7.14 10：50', '100');
INSERT INTO `course` VALUES ('2', 'zhangyelaoshi', '中华优秀传统文化', 'B-204', '7.14 14：00', '50');
INSERT INTO `course` VALUES ('3', 'linmiaolaoshi', '高等数学', 'C-106', '7.14 15：50', '100');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question`  (
  `id` int NULL DEFAULT NULL,
  `quiz\_id` int NULL DEFAULT NULL,
  `question\_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `option\_a` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `option\_b` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `option\_c` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `option\_d` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `correct` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES (1, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (2, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (3, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (4, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (5, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (6, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (7, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (8, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (9, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (10, 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (11, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (12, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (13, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (14, 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `question` VALUES (15, 3, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'wangtongxue', '111', '1111111111@qq.com', 'audience');
INSERT INTO `user` VALUES ('2', 'zhangyetongxue', '222', '2222222222@qq.com', 'audience');
INSERT INTO `user` VALUES ('3', 'linmiaotongxue', '333', '3333333333@qq.com', 'audience');
INSERT INTO `user` VALUES ('4', 'wanglaoshi', '111', '4444444444@qq.com', 'speaker');
INSERT INTO `user` VALUES ('5', 'zhangyelaoshi', '111', '5555555555@qq.com', 'speaker');
INSERT INTO `user` VALUES ('6', 'linmiaolaoshi', '111', '6666666666@qq.com', 'speaker');
INSERT INTO `user` VALUES ('7', 'wanglaoban', '111', '7777777777@qq.com', 'organizer');
INSERT INTO `user` VALUES ('8', 'zhangyelaoban', '111', '8888888888@qq.com', 'organizer');
INSERT INTO `user` VALUES ('9', 'linmiaolaoban', '111', '9999999999@qq.com', 'organizer');

SET FOREIGN_KEY_CHECKS = 1;
