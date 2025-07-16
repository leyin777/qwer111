/*
 Navicat Premium Dump SQL

 Source Server         : 108666
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : 108pq

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 16/07/2025 19:48:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'wanglaoshi', '中国近代史', '101', '2025-07-14 12:20:25', 100);
INSERT INTO `course` VALUES (2, 'wanglaoshi', 'vue基础', '102', '2025-07-14 17:20:54', 120);

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
