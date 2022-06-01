/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : localhost:3306
 Source Schema         : entrepot

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 01/06/2022 20:56:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for h_e_g_info
-- ----------------------------
DROP TABLE IF EXISTS `h_e_g_info`;
CREATE TABLE `h_e_g_info`  (
  `id` int(11) NOT NULL COMMENT 'id',
  `g_code` int(11) NOT NULL COMMENT '货物入库批次号',
  `g_id` int(11) NOT NULL COMMENT '货物主键id',
  `g_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '类别',
  `g_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '货物名称',
  `e_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '仓库id',
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_entrepot
-- ----------------------------
DROP TABLE IF EXISTS `h_entrepot`;
CREATE TABLE `h_entrepot`  (
  `id` int(11) NOT NULL COMMENT '仓库基本信息表id',
  `e_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '仓库名字',
  `e_addr` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '仓库地址',
  `e_safety` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '仓库安全级别,A,B,C,D四个级别由高到低',
  `e_use_capacity` decimal(11, 2) DEFAULT NULL COMMENT '仓库使用容量',
  `e_capacity` decimal(11, 2) NOT NULL COMMENT '仓库总容量',
  `e_rent_time` date NOT NULL COMMENT '仓库租用起始时间',
  `e_till_time` int(11) NOT NULL COMMENT '仓库使用期限',
  `e_insulate` int(11) NOT NULL COMMENT '仓库隔离防护级别',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `is_valid` int(11) DEFAULT NULL COMMENT '是否弃用0为弃用，1为使用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_g_destroy
-- ----------------------------
DROP TABLE IF EXISTS `h_g_destroy`;
CREATE TABLE `h_g_destroy`  (
  `id` int(11) NOT NULL COMMENT '损毁表主键',
  `g_d_id` int(11) NOT NULL COMMENT '货物损坏的批次号加货物id号以 _ 符号隔开',
  `g_d_num` int(11) NOT NULL COMMENT '货物损坏数量',
  `g_d_time` datetime(0) NOT NULL COMMENT '货物损毁盘点时间',
  `g_d_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '货物损毁原因',
  `g_d_entrepot` int(11) DEFAULT NULL COMMENT '损毁货物存放仓库id',
  `g_d_people` int(11) DEFAULT NULL COMMENT '盘点损毁货物的人员id',
  `g_d_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '损毁货物的损毁程度',
  `g_d_mark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_g_into_e
-- ----------------------------
DROP TABLE IF EXISTS `h_g_into_e`;
CREATE TABLE `h_g_into_e`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `g_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '货物编号',
  `g_number` int(11) DEFAULT NULL COMMENT '货物批次号',
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '货物名称',
  `g_user_name` int(255) NOT NULL COMMENT '关联user表的id  货物人',
  `e_id` int(11) DEFAULT NULL COMMENT '仓库id',
  `g_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '货物级别',
  `g_type_id` int(11) NOT NULL COMMENT '关联货物的类型id',
  `g_status` int(255) NOT NULL COMMENT '0为未入库1为已入库2为已出库',
  `g_frequency` int(255) DEFAULT NULL COMMENT '货物的件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for h_g_type
-- ----------------------------
DROP TABLE IF EXISTS `h_g_type`;
CREATE TABLE `h_g_type`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `g_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '货物类型',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  `is_valid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_goods
-- ----------------------------
DROP TABLE IF EXISTS `h_goods`;
CREATE TABLE `h_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `g_into_code` int(11) DEFAULT NULL COMMENT '货物录入批次号',
  `g_p_code` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL COMMENT '货物生产编号',
  `g_name` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '货物名称',
  `g_num` int(11) DEFAULT NULL COMMENT '货物数量',
  `g_size` decimal(10, 2) NOT NULL COMMENT '产品大小，单位立方米',
  `g_produced_time` date DEFAULT NULL COMMENT '生产时间',
  `g_keep_time` int(11) DEFAULT NULL COMMENT '货物保质期,以天为单位',
  `g_rank` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL COMMENT 'A,B，C,D四个保管级别，由高到底',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `is_valid` int(11) DEFAULT NULL COMMENT '1为有效，0为无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci COMMENT = 'InnoDB free: 30720 kB' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of h_goods
-- ----------------------------
INSERT INTO `h_goods` VALUES (3, NULL, 'good001', '洗面奶', NULL, 0.03, '2021-04-15', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `h_goods` VALUES (4, NULL, 'good003', '洗面奶', NULL, 0.04, '2021-04-15', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `h_goods` VALUES (11, NULL, 'good007', '洗面奶', NULL, 0.05, '2021-04-13', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `h_goods` VALUES (12, NULL, '2', '恶风', NULL, 22.00, '2022-05-12', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `h_goods` VALUES (13, NULL, '34', '535', NULL, 355.00, '2022-05-30', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for h_module
-- ----------------------------
DROP TABLE IF EXISTS `h_module`;
CREATE TABLE `h_module`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '资源名称',
  `module_style` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '模块样式',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '地址',
  `parent_id` int(11) DEFAULT NULL,
  `parent_opt_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `grade` int(255) DEFAULT NULL COMMENT '等级',
  `opt_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '权限值',
  `orders` int(11) DEFAULT NULL,
  `is_valid` tinyint(4) DEFAULT NULL,
  `create_date` datetime(0) DEFAULT NULL,
  `update_date` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_move_entrepot
-- ----------------------------
DROP TABLE IF EXISTS `h_move_entrepot`;
CREATE TABLE `h_move_entrepot`  (
  `id` int(11) NOT NULL COMMENT '移库表id',
  `old_e_id` int(11) DEFAULT NULL COMMENT '原仓库id',
  `new_e_id` int(11) DEFAULT NULL COMMENT '先仓库id',
  `g_id` int(11) DEFAULT NULL COMMENT '货物id',
  `update_time` datetime(0) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_permission
-- ----------------------------
DROP TABLE IF EXISTS `h_permission`;
CREATE TABLE `h_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色ID',
  `module_id` int(11) DEFAULT NULL COMMENT '模块ID',
  `acl_value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '权限值',
  `create_date` datetime(0) DEFAULT NULL,
  `update_date` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_role
-- ----------------------------
DROP TABLE IF EXISTS `h_role`;
CREATE TABLE `h_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `role_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_date` datetime(0) DEFAULT NULL,
  `update_date` datetime(0) DEFAULT NULL,
  `is_valid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for h_user
-- ----------------------------
DROP TABLE IF EXISTS `h_user`;
CREATE TABLE `h_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `user_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户密码',
  `true_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `is_valid` int(4) DEFAULT 1 COMMENT '是否有效',
  `create_date` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_user
-- ----------------------------
INSERT INTO `h_user` VALUES (1, 'admin', 'gdyb21LQTcIANtvYMT7QVQ==', 'admin', '12190@qq.com', '13975863898', 1, '2022-06-01 15:27:24', '2022-06-01 15:27:27');

-- ----------------------------
-- Table structure for h_user_pwd
-- ----------------------------
DROP TABLE IF EXISTS `h_user_pwd`;
CREATE TABLE `h_user_pwd`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `user_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户密码',
  `true_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `is_valid` int(4) DEFAULT 1 COMMENT '是否有效',
  `create_date` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of h_user_pwd
-- ----------------------------
INSERT INTO `h_user_pwd` VALUES (1, 'admin', 'gdyb21LQTcIANtvYMT7QVQ==', 'admin', '12190@qq.com', '13975863898', 1, '2022-06-01 15:27:24', '2022-06-01 15:27:27');

-- ----------------------------
-- Table structure for moveentrepot
-- ----------------------------
DROP TABLE IF EXISTS `moveentrepot`;
CREATE TABLE `moveentrepot`  (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `oldentrepotcode` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL,
  `targetentrepotcode` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL,
  `gcode` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL,
  `gcnt` int(11) DEFAULT NULL,
  `gadminname` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL,
  `movetime` varchar(30) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci COMMENT = 'InnoDB free: 30720 kB' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of moveentrepot
-- ----------------------------
INSERT INTO `moveentrepot` VALUES (1, '4', '5', 'good001', 20, '李四', '2021/04/16/12:04:29');
INSERT INTO `moveentrepot` VALUES (2, '4', '1', 'good001', 20, '吴大大', '2021/04/19/06:12:13');
INSERT INTO `moveentrepot` VALUES (3, '4', '1', 'good001', 10, '吴大大', '2021/04/19/07:08:50');
INSERT INTO `moveentrepot` VALUES (4, '4', '1', 'good001', 20, '吴大大', '2021/04/19/07:26:38');

SET FOREIGN_KEY_CHECKS = 1;
