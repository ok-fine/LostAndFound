/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : lost_and_found

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 24/12/2019 22:51:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_no` int(16) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `address` varchar(256) DEFAULT NULL,
  `admin_no` int(16) unsigned zerofill NOT NULL,
  PRIMARY KEY (`address_no`),
  KEY `admin_no` (`admin_no`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`admin_no`) REFERENCES `admin_info` (`admin_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
BEGIN;
INSERT INTO `address` VALUES (0000000000000001, '一号', 0000000000000001);
INSERT INTO `address` VALUES (0000000000000002, '二号', 0000000000000002);
INSERT INTO `address` VALUES (0000000000000003, '三号', 0000000000000003);
COMMIT;

-- ----------------------------
-- Table structure for admin_info
-- ----------------------------
DROP TABLE IF EXISTS `admin_info`;
CREATE TABLE `admin_info` (
  `admin_no` int(16) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(16) DEFAULT NULL,
  `password` varchar(16) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `is_system` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0',
  PRIMARY KEY (`admin_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin_info
-- ----------------------------
BEGIN;
INSERT INTO `admin_info` VALUES (0000000000000001, '111', '111', '1234', '1');
INSERT INTO `admin_info` VALUES (0000000000000002, '222', '222', '2222', '0');
INSERT INTO `admin_info` VALUES (0000000000000003, '333', '333', '3333', '0');
COMMIT;

-- ----------------------------
-- Table structure for applications
-- ----------------------------
DROP TABLE IF EXISTS `applications`;
CREATE TABLE `applications` (
  `apply_no` int(16) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `apply_user` int(16) unsigned zerofill DEFAULT NULL,
  `apply_item` int(16) unsigned zerofill DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  `get_time` datetime DEFAULT NULL,
  `reason` varchar(256) DEFAULT NULL,
  `status` enum('待审核','通过','拒绝') DEFAULT '待审核',
  `admin_no` int(16) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`apply_no`),
  KEY `apply_user` (`apply_user`),
  KEY `apply_item` (`apply_item`),
  KEY `admin_no` (`admin_no`),
  CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`apply_user`) REFERENCES `user_info` (`user_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `applications_ibfk_2` FOREIGN KEY (`apply_item`) REFERENCES `item_info` (`item_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `applications_ibfk_3` FOREIGN KEY (`admin_no`) REFERENCES `admin_info` (`admin_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of applications
-- ----------------------------
BEGIN;
INSERT INTO `applications` VALUES (0000000000000002, 0000000000000003, 0000000000000003, '2019-12-11 21:45:54', '2019-12-11 21:45:57', '3333', '待审核', 0000000000000003);
INSERT INTO `applications` VALUES (0000000000000004, 0000000000000005, 0000000000000005, '2019-12-11 21:46:55', '2019-12-11 21:46:58', '5555', '通过', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000011, 0000000000000002, 0000000000000002, '2019-12-15 20:01:34', '2019-11-12 12:12:00', 'csascx', '拒绝', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000015, 0000000000000002, 0000000000000004, '2019-12-17 17:07:25', '2019-11-12 12:12:00', '就是我的', '通过', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000016, 0000000000000002, 0000000000000005, '2019-12-13 17:46:06', '2019-11-12 12:12:00', 'dasda', '拒绝', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000017, 0000000000000002, 0000000000000007, '2019-12-15 21:33:38', '2019-12-15 21:33:41', '，结合本地撒', '通过', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000021, 0000000000000002, 0000000000000008, '2019-12-17 10:51:50', '2019-11-12 12:12:00', 'zdcsfs', '待审核', 0000000000000001);
INSERT INTO `applications` VALUES (0000000000000023, 0000000000000002, 0000000000000017, '2019-12-18 22:01:18', '2019-11-12 12:12:00', '想要', '待审核', 0000000000000002);
INSERT INTO `applications` VALUES (0000000000000024, 0000000000000002, 0000000000000018, '2019-12-18 22:01:26', '2019-11-12 12:12:00', '我觉得是我的', '待审核', 0000000000000002);
INSERT INTO `applications` VALUES (0000000000000025, 0000000000000002, 0000000000000006, '2019-12-18 22:01:41', '2019-11-12 12:12:00', '应该是我的吧', '待审核', 0000000000000003);
INSERT INTO `applications` VALUES (0000000000000026, 0000000000000002, 0000000000000014, '2019-12-24 15:20:01', '2019-11-12 12:12:00', 'wode ', '待审核', 0000000000000001);
COMMIT;

-- ----------------------------
-- Table structure for item_info
-- ----------------------------
DROP TABLE IF EXISTS `item_info`;
CREATE TABLE `item_info` (
  `item_no` int(16) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `status` enum('待认领','已认领') DEFAULT '待认领',
  `address_no` int(16) unsigned zerofill DEFAULT NULL,
  `admin_no` int(16) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`item_no`),
  KEY `address_no` (`address_no`),
  KEY `admin_no` (`admin_no`),
  CONSTRAINT `item_info_ibfk_1` FOREIGN KEY (`address_no`) REFERENCES `address` (`address_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_info_ibfk_2` FOREIGN KEY (`admin_no`) REFERENCES `admin_info` (`admin_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item_info
-- ----------------------------
BEGIN;
INSERT INTO `item_info` VALUES (0000000000000002, '手机', '不知道是谁的', '2019-12-10 21:39:44', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000003, '水杯', '哈哈哈', '2019-12-10 21:41:22', '待认领', 0000000000000003, 0000000000000003);
INSERT INTO `item_info` VALUES (0000000000000004, '伞', '嗯嗯嗯嗯', '2019-12-10 21:41:39', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000005, '书籍', '咳咳咳', '2019-12-10 21:41:58', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000006, '钥匙', '哈哈哈哈', '2019-12-13 10:15:38', '待认领', 0000000000000003, 0000000000000003);
INSERT INTO `item_info` VALUES (0000000000000007, '水杯2', '阿发生科技部', '2019-12-13 10:45:08', '已认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000008, '数据库', '不想上了', '2019-12-13 10:45:30', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000013, '钥匙链', '嘿嘿嘿', '2019-12-17 16:16:29', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000014, '充电器', '白色的充电器', '2019-12-17 17:05:40', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000015, '眼镜盒', '不是我的', '2019-12-18 21:16:16', '待认领', 0000000000000001, 0000000000000001);
INSERT INTO `item_info` VALUES (0000000000000017, '数据线', '阿凡达是S次', '2019-12-18 21:56:14', '待认领', 0000000000000002, 0000000000000002);
INSERT INTO `item_info` VALUES (0000000000000018, '2号的眼镜盒', '火车上的字和大佛寺', '2019-12-18 21:57:51', '待认领', 0000000000000002, 0000000000000002);
COMMIT;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_no` int(16) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `user_name` varchar(16) NOT NULL,
  `password` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`user_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
BEGIN;
INSERT INTO `user_info` VALUES (0000000000000002, 'aaa', 'aaa', '234');
INSERT INTO `user_info` VALUES (0000000000000003, 'bbb', 'bbb', '333');
INSERT INTO `user_info` VALUES (0000000000000005, 'ccc', 'ccc', '555');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
