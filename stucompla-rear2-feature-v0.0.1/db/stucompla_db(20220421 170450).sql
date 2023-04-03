/*
 Navicat Premium Data Transfer

 Source Server         : Mysql8.0
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : stucompla_db

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 21/04/2022 17:04:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'xzj', '9b2b811c25f6c3012e3d4fde6a92fe51d0fafe15', '2022-04-02 16:53:40', '2022-04-02 16:53:40', 2);
INSERT INTO `admin` VALUES (2, 'xzj1', '86fd513b1fed27e71af44b8428e6c3f780c9c3b1', '2022-04-02 17:00:33', '2022-04-02 17:00:33', 2);
INSERT INTO `admin` VALUES (3, 'xzj2', '3aef3934d534dfa96549a7e4a598c34a457395ae', '2022-04-02 17:02:01', '2022-04-02 17:02:01', 2);
INSERT INTO `admin` VALUES (4, 'xzj3', '716f6d0c7ae60f2c7787da7ec5759945b97bfe02', '2022-04-02 17:02:50', '2022-04-02 17:02:50', 2);
INSERT INTO `admin` VALUES (5, 'xzj4', '5113d2a6f1f3bc9a37223144a70576896aa95e34', '2022-04-02 17:25:38', '2022-04-02 17:25:38', 3);
INSERT INTO `admin` VALUES (6, 'xzj5', 'a4f899e4ea252afa60549fa77aa8fe14f0a1b4f0', '2022-04-03 14:36:06', '2022-04-03 14:36:06', 2);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '种类ID',
  `category_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '种类名',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `post_num` int(0) NULL DEFAULT NULL COMMENT '帖子数',
  `view_num` int(0) NULL DEFAULT NULL COMMENT '浏览量',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '技术交流', '这是一个大家可以交流技术的板块', 0, 0, NULL);
INSERT INTO `category` VALUES (2, '校园生活', '大家可以交流生活', 0, 0, NULL);
INSERT INTO `category` VALUES (3, '意见反馈', '小伙伴们有什么建议都可以给我们反馈', 0, 0, NULL);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NULL DEFAULT NULL,
  `post_id` int(0) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 150 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (15, 1, 22, '2022-04-11 11:31:00');
INSERT INTO `collect` VALUES (120, 1, 17, '2022-04-12 13:53:21');
INSERT INTO `collect` VALUES (121, 1, 7, '2022-04-12 13:53:30');
INSERT INTO `collect` VALUES (137, 1, 20, '2022-04-12 16:47:19');
INSERT INTO `collect` VALUES (146, 1, 33, '2022-04-14 10:47:08');
INSERT INTO `collect` VALUES (147, 1, 27, '2022-04-14 13:40:06');
INSERT INTO `collect` VALUES (149, 1, 32, '2022-04-16 16:56:04');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `post_id` int(0) NULL DEFAULT NULL COMMENT '帖子ID',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父评论ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '评论人ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, '1321321', 'http://localhost:8086/image/1646014140416_1498118003659767808.png,http://localhost:8086/image/1646014140427_1498118003705905152.png', 3, NULL, 1, '2022-02-28 10:09:03');
INSERT INTO `comment` VALUES (2, '看看我的图片', 'http://localhost:8086/image/1646041521061_1498232846442168320.png,http://localhost:8086/image/1646041521061_1498232846450556929.png,http://localhost:8086/image/1646041521062_1498232846450556928.png', 3, NULL, 1, '2022-02-28 17:45:24');
INSERT INTO `comment` VALUES (3, '你看看', 'http://localhost:8086/image/1646041803088_1498234029315588096.png', 3, NULL, 1, '2022-02-28 17:50:08');
INSERT INTO `comment` VALUES (6, '图片证明', 'http://localhost:8086/image/1646044331417_1498244633900220416.png', 3, NULL, 1, '2022-02-28 18:32:13');
INSERT INTO `comment` VALUES (7, '12312313', NULL, 3, NULL, 1, '2022-02-28 18:32:55');
INSERT INTO `comment` VALUES (8, '165115', NULL, 3, NULL, 1, '2022-02-28 18:34:05');
INSERT INTO `comment` VALUES (9, '123', NULL, 3, NULL, 1, '2022-02-28 18:35:00');
INSERT INTO `comment` VALUES (10, '4654646', 'http://localhost:8086/image/1646044971494_1498247318577741824.png', 3, NULL, 1, '2022-02-28 18:42:56');
INSERT INTO `comment` VALUES (11, '31313', NULL, 3, NULL, 1, '2022-02-28 18:43:07');
INSERT INTO `comment` VALUES (12, 'hahhahahahha 好厉害', '', 20, NULL, 6, '2022-04-09 18:42:03');
INSERT INTO `comment` VALUES (13, '我是测试员，测试一下评论', '', 20, NULL, 2, '2022-04-10 18:21:55');
INSERT INTO `comment` VALUES (14, '我是测试员，测试一下评论2', '', 20, NULL, 2, '2022-04-10 18:22:01');
INSERT INTO `comment` VALUES (15, '我是测试员，测试一下评论3', '', 20, NULL, 2, '2022-04-10 18:22:05');
INSERT INTO `comment` VALUES (16, '我是测试员，测试一下评论4', '', 20, NULL, 2, '2022-04-10 18:22:09');
INSERT INTO `comment` VALUES (17, '我是测试员，测试一下评论5', '', 20, NULL, 2, '2022-04-10 18:22:11');
INSERT INTO `comment` VALUES (18, '我是测试员，测试一下评论6', '', 20, NULL, 2, '2022-04-10 18:22:16');
INSERT INTO `comment` VALUES (19, '测试评论，但是还没整合图片', NULL, 26, NULL, 1, '2022-04-13 10:19:36');
INSERT INTO `comment` VALUES (20, 'Android源码怎么导入呢？', NULL, 32, NULL, 1, '2022-04-14 10:32:50');
INSERT INTO `comment` VALUES (21, '感谢楼主！', NULL, 32, NULL, 1, '2022-04-14 10:33:34');
INSERT INTO `comment` VALUES (22, '不错！', NULL, 33, NULL, 1, '2022-04-14 10:47:34');
INSERT INTO `comment` VALUES (23, '感谢分享！', NULL, 33, NULL, 1, '2022-04-14 10:47:53');
INSERT INTO `comment` VALUES (24, '123123\n', NULL, 27, NULL, 1, '2022-04-14 13:40:10');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '二手商品id',
  `goods_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二手商品名称',
  `goods_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二手商品详情',
  `goods_images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二手商品图片',
  `goods_price` double(10, 2) NULL DEFAULT NULL COMMENT '二手商品定价',
  `goods_category_id` int(0) NULL DEFAULT NULL COMMENT '二手商品分类id',
  `goods_count` int(0) NULL DEFAULT NULL COMMENT '二手商品数量',
  `goods_status` tinyint(0) NULL DEFAULT NULL COMMENT '二手商品上架状态：0-下架 1-上架',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '二手商品发布时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '二手商品信息更新时间',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '发布人id',
  `view_num` int(0) NULL DEFAULT NULL COMMENT '点击数',
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (6, '有线耳机', '刚用没多久的，音质也很好，由于换了蓝牙耳机，现低价出售！！！', '1650119194030_1515335846453182464.jpeg', 15.50, 66, 5, 1, '2022-04-16 22:26:51', '2022-04-20 14:15:00', 1, 10);
INSERT INTO `goods` VALUES (7, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:28', '2022-04-20 15:39:23', 1, 5);
INSERT INTO `goods` VALUES (8, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:43', '2022-04-17 11:10:43', 1, 0);
INSERT INTO `goods` VALUES (9, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:44', '2022-04-20 18:02:27', 1, 1);
INSERT INTO `goods` VALUES (10, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:44', '2022-04-20 15:26:25', 1, 9);
INSERT INTO `goods` VALUES (11, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:44', '2022-04-20 15:47:59', 1, 5);
INSERT INTO `goods` VALUES (12, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:45', '2022-04-18 15:48:41', 1, 8);
INSERT INTO `goods` VALUES (13, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 0, 1, '2022-04-17 11:10:45', '2022-04-20 18:02:31', 1, 9);
INSERT INTO `goods` VALUES (14, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:46', '2022-04-20 12:41:18', 1, 13);
INSERT INTO `goods` VALUES (15, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:46', '2022-04-20 12:47:55', 1, 61);
INSERT INTO `goods` VALUES (16, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:46', '2022-04-20 14:49:21', 1, 5);
INSERT INTO `goods` VALUES (17, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:46', '2022-04-20 14:40:13', 1, 70);
INSERT INTO `goods` VALUES (18, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:47', '2022-04-19 10:08:23', 1, 2);
INSERT INTO `goods` VALUES (19, '有线耳机2', '音质好，质量好，低价出售了', '1650164916761_1515527621486706688.jpeg', 13.00, 66, 1, 1, '2022-04-17 11:10:47', '2022-04-20 14:06:26', 1, 55);

-- ----------------------------
-- Table structure for goods_category
-- ----------------------------
DROP TABLE IF EXISTS `goods_category`;
CREATE TABLE `goods_category`  (
  `category_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '二手商品分类id',
  `category_level` tinyint(0) NOT NULL DEFAULT 0 COMMENT '二手商品分类级别(1-一级分类 2-二级分类 3-三级分类)',
  `parent_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '二手商品父分类id',
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '二手商品分类名称',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '二手商品分类创建时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '二手商品分类修改时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_category
-- ----------------------------
INSERT INTO `goods_category` VALUES (1, 1, 0, '日用百货', '2022-04-15 16:55:02', '2022-04-15 16:55:02');
INSERT INTO `goods_category` VALUES (2, 1, 0, '书籍文具', '2022-04-15 16:57:10', '2022-04-15 16:57:10');
INSERT INTO `goods_category` VALUES (3, 1, 0, '数码产品', '2022-04-15 16:57:46', '2022-04-15 16:57:46');
INSERT INTO `goods_category` VALUES (4, 1, 0, '代步工具', '2022-04-15 16:58:25', '2022-04-15 16:58:25');
INSERT INTO `goods_category` VALUES (5, 1, 0, '课外娱乐', '2022-04-15 16:58:57', '2022-04-15 16:58:57');
INSERT INTO `goods_category` VALUES (6, 1, 0, '衣服首饰', '2022-04-15 17:00:18', '2022-04-15 17:00:18');
INSERT INTO `goods_category` VALUES (7, 1, 0, '美妆洗护', '2022-04-15 17:00:32', '2022-04-15 17:00:32');
INSERT INTO `goods_category` VALUES (8, 1, 0, '其它', '2022-04-15 17:00:46', '2022-04-15 17:00:46');
INSERT INTO `goods_category` VALUES (9, 2, 1, '日用家居', '2022-04-15 17:01:55', '2022-04-15 17:01:55');
INSERT INTO `goods_category` VALUES (10, 2, 1, '电器家具', '2022-04-15 17:07:43', '2022-04-15 17:07:43');
INSERT INTO `goods_category` VALUES (11, 2, 2, '书籍', '2022-04-15 17:08:00', '2022-04-15 17:08:00');
INSERT INTO `goods_category` VALUES (12, 2, 2, '文具', '2022-04-15 17:08:04', '2022-04-15 17:08:04');
INSERT INTO `goods_category` VALUES (13, 2, 3, '手机', '2022-04-15 17:08:22', '2022-04-15 17:08:22');
INSERT INTO `goods_category` VALUES (14, 2, 3, '电脑', '2022-04-15 17:08:24', '2022-04-15 17:08:24');
INSERT INTO `goods_category` VALUES (15, 2, 3, '配件', '2022-04-15 17:08:27', '2022-04-15 17:08:27');
INSERT INTO `goods_category` VALUES (16, 2, 3, '网络产品', '2022-04-15 17:08:41', '2022-04-15 17:08:41');
INSERT INTO `goods_category` VALUES (17, 2, 3, '智能设备', '2022-04-15 17:08:48', '2022-04-15 17:08:48');
INSERT INTO `goods_category` VALUES (18, 2, 4, '代步工具', '2022-04-15 17:11:14', '2022-04-15 17:11:14');
INSERT INTO `goods_category` VALUES (19, 2, 5, '运动器材', '2022-04-15 17:11:44', '2022-04-15 17:11:44');
INSERT INTO `goods_category` VALUES (20, 2, 5, '手工品', '2022-04-15 17:12:22', '2022-04-15 17:12:22');
INSERT INTO `goods_category` VALUES (21, 2, 6, '服饰', '2022-04-15 17:12:50', '2022-04-15 17:12:50');
INSERT INTO `goods_category` VALUES (22, 2, 6, '鞋子', '2022-04-15 17:13:11', '2022-04-15 17:13:11');
INSERT INTO `goods_category` VALUES (23, 2, 6, '箱包', '2022-04-15 17:13:24', '2022-04-15 17:13:24');
INSERT INTO `goods_category` VALUES (24, 2, 6, '配饰', '2022-04-15 17:15:18', '2022-04-15 17:15:18');
INSERT INTO `goods_category` VALUES (25, 2, 7, '美妆', '2022-04-15 17:15:39', '2022-04-15 17:15:39');
INSERT INTO `goods_category` VALUES (26, 2, 7, '洗护', '2022-04-15 17:15:53', '2022-04-15 17:15:53');
INSERT INTO `goods_category` VALUES (27, 2, 8, '其它学生用品', '2022-04-15 17:16:23', '2022-04-15 17:16:23');
INSERT INTO `goods_category` VALUES (28, 3, 9, '床上用品', '2022-04-15 17:17:33', '2022-04-15 17:17:33');
INSERT INTO `goods_category` VALUES (29, 3, 9, '餐饮用具', '2022-04-15 17:19:48', '2022-04-15 17:19:48');
INSERT INTO `goods_category` VALUES (30, 3, 9, '收纳装饰', '2022-04-15 17:19:50', '2022-04-15 17:19:50');
INSERT INTO `goods_category` VALUES (31, 3, 9, '雨伞/日用', '2022-04-15 17:19:51', '2022-04-15 17:19:51');
INSERT INTO `goods_category` VALUES (32, 3, 9, '绿植宠物', '2022-04-15 17:19:54', '2022-04-15 17:19:54');
INSERT INTO `goods_category` VALUES (33, 3, 10, '台灯', '2022-04-15 17:19:59', '2022-04-15 17:19:59');
INSERT INTO `goods_category` VALUES (34, 3, 10, '小桌子', '2022-04-15 17:20:08', '2022-04-15 17:20:08');
INSERT INTO `goods_category` VALUES (35, 3, 10, '插排', '2022-04-15 17:20:09', '2022-04-15 17:20:09');
INSERT INTO `goods_category` VALUES (36, 3, 10, '风扇', '2022-04-15 17:20:09', '2022-04-15 17:20:09');
INSERT INTO `goods_category` VALUES (37, 3, 10, '电吹风', '2022-04-15 17:20:10', '2022-04-15 17:20:10');
INSERT INTO `goods_category` VALUES (38, 3, 10, '小电器', '2022-04-15 17:20:11', '2022-04-15 17:20:11');
INSERT INTO `goods_category` VALUES (39, 3, 11, '教材', '2022-04-15 17:21:42', '2022-04-15 17:21:42');
INSERT INTO `goods_category` VALUES (40, 3, 11, '笔记/资料', '2022-04-15 17:21:43', '2022-04-15 17:21:43');
INSERT INTO `goods_category` VALUES (41, 3, 11, '动漫书', '2022-04-15 17:21:43', '2022-04-15 17:21:43');
INSERT INTO `goods_category` VALUES (42, 3, 11, '电子书', '2022-04-15 17:21:43', '2022-04-15 17:21:43');
INSERT INTO `goods_category` VALUES (43, 3, 11, '考证考试用书', '2022-04-15 17:21:44', '2022-04-15 17:21:44');
INSERT INTO `goods_category` VALUES (44, 3, 11, '小说/文学', '2022-04-15 17:21:45', '2022-04-15 17:21:45');
INSERT INTO `goods_category` VALUES (45, 3, 12, '笔记本', '2022-04-15 17:22:00', '2022-04-15 17:22:00');
INSERT INTO `goods_category` VALUES (46, 3, 12, '文具', '2022-04-15 17:22:36', '2022-04-15 17:22:36');
INSERT INTO `goods_category` VALUES (47, 3, 12, '台历挂历', '2022-04-15 17:22:37', '2022-04-15 17:22:37');
INSERT INTO `goods_category` VALUES (48, 3, 12, '书法画材', '2022-04-15 17:22:38', '2022-04-15 17:22:38');
INSERT INTO `goods_category` VALUES (50, 3, 13, '华为', '2022-04-15 17:24:19', '2022-04-15 17:24:19');
INSERT INTO `goods_category` VALUES (51, 3, 13, '小米', '2022-04-15 17:24:20', '2022-04-15 17:24:20');
INSERT INTO `goods_category` VALUES (52, 3, 13, 'vivo', '2022-04-15 17:24:20', '2022-04-15 17:24:20');
INSERT INTO `goods_category` VALUES (53, 3, 13, 'oppo', '2022-04-15 17:24:21', '2022-04-15 17:24:21');
INSERT INTO `goods_category` VALUES (54, 3, 13, '荣耀', '2022-04-15 17:24:22', '2022-04-15 17:24:22');
INSERT INTO `goods_category` VALUES (55, 3, 13, '三星', '2022-04-15 17:24:22', '2022-04-15 17:24:22');
INSERT INTO `goods_category` VALUES (56, 3, 13, '魅族', '2022-04-15 17:24:23', '2022-04-15 17:24:23');
INSERT INTO `goods_category` VALUES (57, 3, 13, '苹果', '2022-04-15 17:24:23', '2022-04-15 17:24:23');
INSERT INTO `goods_category` VALUES (58, 3, 13, '其它手机', '2022-04-15 17:24:24', '2022-04-15 17:24:24');
INSERT INTO `goods_category` VALUES (59, 3, 14, '笔记本电脑', '2022-04-15 17:24:40', '2022-04-15 17:24:40');
INSERT INTO `goods_category` VALUES (60, 3, 14, '平板电脑', '2022-04-15 17:25:06', '2022-04-15 17:25:06');
INSERT INTO `goods_category` VALUES (61, 3, 14, '台式电脑', '2022-04-15 17:25:06', '2022-04-15 17:25:06');
INSERT INTO `goods_category` VALUES (62, 3, 14, '整体一体机', '2022-04-15 17:25:08', '2022-04-15 17:25:08');
INSERT INTO `goods_category` VALUES (63, 3, 15, '充电器/数据线', '2022-04-15 17:25:32', '2022-04-15 17:25:32');
INSERT INTO `goods_category` VALUES (64, 3, 15, '充电宝', '2022-04-15 17:26:37', '2022-04-15 17:26:37');
INSERT INTO `goods_category` VALUES (65, 3, 15, '壳/膜/挂件', '2022-04-15 17:26:37', '2022-04-15 17:26:37');
INSERT INTO `goods_category` VALUES (66, 3, 15, '耳机', '2022-04-15 17:26:38', '2022-04-15 17:26:38');
INSERT INTO `goods_category` VALUES (67, 3, 15, '支架', '2022-04-15 17:26:38', '2022-04-15 17:26:38');
INSERT INTO `goods_category` VALUES (68, 3, 15, '鼠标/键盘', '2022-04-15 17:26:39', '2022-04-15 17:26:39');
INSERT INTO `goods_category` VALUES (69, 3, 15, '显示器', '2022-04-15 17:26:39', '2022-04-15 17:26:39');
INSERT INTO `goods_category` VALUES (70, 3, 15, 'U盘', '2022-04-15 17:27:45', '2022-04-15 17:27:45');
INSERT INTO `goods_category` VALUES (71, 3, 15, '移动硬盘', '2022-04-15 17:28:30', '2022-04-15 17:28:30');
INSERT INTO `goods_category` VALUES (72, 3, 15, '其它配件', '2022-04-15 17:28:32', '2022-04-15 17:28:32');
INSERT INTO `goods_category` VALUES (73, 3, 16, '路由器', '2022-04-15 17:30:11', '2022-04-15 17:30:11');
INSERT INTO `goods_category` VALUES (74, 3, 16, '无线网卡', '2022-04-15 17:30:12', '2022-04-15 17:30:12');
INSERT INTO `goods_category` VALUES (75, 3, 16, '网线', '2022-04-15 17:30:12', '2022-04-15 17:30:12');
INSERT INTO `goods_category` VALUES (76, 3, 17, '智能手表/运动手环', '2022-04-15 17:30:13', '2022-04-15 17:30:13');
INSERT INTO `goods_category` VALUES (77, 3, 17, '智能平衡车', '2022-04-15 17:30:14', '2022-04-15 17:30:14');
INSERT INTO `goods_category` VALUES (78, 3, 17, '智能健康秤', '2022-04-15 17:30:22', '2022-04-15 17:30:22');
INSERT INTO `goods_category` VALUES (79, 3, 18, '自行车', '2022-04-15 17:30:51', '2022-04-15 17:30:51');
INSERT INTO `goods_category` VALUES (80, 3, 18, '电动车', '2022-04-15 17:31:44', '2022-04-15 17:31:44');
INSERT INTO `goods_category` VALUES (81, 3, 18, '摩托车', '2022-04-15 17:31:45', '2022-04-15 17:31:45');
INSERT INTO `goods_category` VALUES (82, 3, 18, '平衡车', '2022-04-15 17:31:45', '2022-04-15 17:31:45');
INSERT INTO `goods_category` VALUES (83, 3, 18, '滑板/车', '2022-04-15 17:31:46', '2022-04-15 17:31:46');
INSERT INTO `goods_category` VALUES (84, 3, 18, '滑轮/溜冰鞋', '2022-04-15 17:31:46', '2022-04-15 17:31:46');
INSERT INTO `goods_category` VALUES (85, 3, 18, '代步周边', '2022-04-15 17:31:53', '2022-04-15 17:31:53');
INSERT INTO `goods_category` VALUES (86, 3, 19, '球类', '2022-04-15 17:32:29', '2022-04-15 17:32:29');
INSERT INTO `goods_category` VALUES (87, 3, 19, '运动装备', '2022-04-15 17:33:21', '2022-04-15 17:33:21');
INSERT INTO `goods_category` VALUES (88, 3, 19, '健身器材', '2022-04-15 17:33:22', '2022-04-15 17:33:22');
INSERT INTO `goods_category` VALUES (89, 3, 20, '书法', '2022-04-15 17:33:23', '2022-04-15 17:33:23');
INSERT INTO `goods_category` VALUES (90, 3, 20, '绘画', '2022-04-15 17:33:24', '2022-04-15 17:33:24');
INSERT INTO `goods_category` VALUES (91, 3, 20, '工艺品', '2022-04-15 17:33:26', '2022-04-15 17:33:26');
INSERT INTO `goods_category` VALUES (92, 3, 21, '女装', '2022-04-15 17:34:39', '2022-04-15 17:34:39');
INSERT INTO `goods_category` VALUES (93, 3, 21, '男装', '2022-04-15 17:37:16', '2022-04-15 17:37:16');
INSERT INTO `goods_category` VALUES (94, 3, 21, '袜子', '2022-04-15 17:37:16', '2022-04-15 17:37:16');
INSERT INTO `goods_category` VALUES (95, 3, 22, '男鞋', '2022-04-15 17:37:17', '2022-04-15 17:37:17');
INSERT INTO `goods_category` VALUES (96, 3, 22, '女鞋', '2022-04-15 17:37:17', '2022-04-15 17:37:17');
INSERT INTO `goods_category` VALUES (97, 3, 22, '拖鞋', '2022-04-15 17:37:18', '2022-04-15 17:37:18');
INSERT INTO `goods_category` VALUES (98, 3, 23, '女士包袋', '2022-04-15 17:37:18', '2022-04-15 17:37:18');
INSERT INTO `goods_category` VALUES (99, 3, 23, '男士包袋', '2022-04-15 17:37:19', '2022-04-15 17:37:19');
INSERT INTO `goods_category` VALUES (100, 3, 23, '功能类箱包', '2022-04-15 17:37:19', '2022-04-15 17:37:19');
INSERT INTO `goods_category` VALUES (101, 3, 24, '服配', '2022-04-15 17:37:20', '2022-04-15 17:37:20');
INSERT INTO `goods_category` VALUES (102, 3, 24, '首饰', '2022-04-15 17:37:21', '2022-04-15 17:37:21');
INSERT INTO `goods_category` VALUES (103, 3, 24, '手表', '2022-04-15 17:37:21', '2022-04-15 17:37:21');
INSERT INTO `goods_category` VALUES (104, 3, 24, '眼镜', '2022-04-15 17:37:24', '2022-04-15 17:37:24');
INSERT INTO `goods_category` VALUES (105, 3, 25, '护肤', '2022-04-15 17:40:22', '2022-04-15 17:40:22');
INSERT INTO `goods_category` VALUES (106, 3, 25, '彩妆', '2022-04-15 17:40:22', '2022-04-15 17:40:22');
INSERT INTO `goods_category` VALUES (107, 3, 25, '美容美体', '2022-04-15 17:40:23', '2022-04-15 17:40:23');
INSERT INTO `goods_category` VALUES (108, 3, 25, '化妆工具', '2022-04-15 17:40:23', '2022-04-15 17:40:23');
INSERT INTO `goods_category` VALUES (109, 3, 26, '洗浴用品', '2022-04-15 17:40:24', '2022-04-15 17:40:24');
INSERT INTO `goods_category` VALUES (110, 3, 26, '清洁用品', '2022-04-15 17:40:24', '2022-04-15 17:40:24');
INSERT INTO `goods_category` VALUES (111, 3, 26, '纸品湿巾', '2022-04-15 17:40:24', '2022-04-15 17:40:24');
INSERT INTO `goods_category` VALUES (112, 3, 26, '个人护理', '2022-04-15 17:40:28', '2022-04-15 17:40:28');
INSERT INTO `goods_category` VALUES (113, 3, 27, '其它学生用品', '2022-04-15 17:41:28', '2022-04-15 17:41:28');

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '访问地址',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '存储路径',
  `content_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片类型',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '原名称',
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0-删除、1-正常）',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('1485242289885413376', 1, '1642944331004_1485242289885413376.jpeg', 'D:\\stucompla\\images\\2022_01_23\\jpeg\\1485242289885413376.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-01-23 21:25:31', '2022-01-23 21:25:31');
INSERT INTO `image` VALUES ('1485422280958935040', 1, '1642987244220_1485422280958935040.jpeg', 'D:\\stucompla\\images\\2022_01_24\\jpeg\\1485422280958935040.jpeg', 'image/jpeg', 'binary-tunnel-numbers-24762.jpeg', '1', '2022-01-24 09:20:44', '2022-01-24 09:20:44');
INSERT INTO `image` VALUES ('1485422479852830720', 1, '1642987291668_1485422479852830720.png', 'D:\\stucompla\\images\\2022_01_24\\png\\1485422479852830720.png', 'image/png', '网上花店.png', '1', '2022-01-24 09:21:32', '2022-01-24 09:21:32');
INSERT INTO `image` VALUES ('1485422502879559680', 1, '1642987297159_1485422502879559680.png', 'D:\\stucompla\\images\\2022_01_24\\png\\1485422502879559680.png', 'image/png', '回家网.png', '1', '2022-01-24 09:21:37', '2022-01-24 09:21:37');
INSERT INTO `image` VALUES ('1485422580331577344', 1, '1642987315625_1485422580331577344.png', 'D:\\stucompla\\images\\2022_01_24\\png\\1485422580331577344.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-01-24 09:21:56', '2022-01-24 09:21:56');
INSERT INTO `image` VALUES ('1485423491502178304', 1, '1642987532865_1485423491502178304.png', 'D:\\stucompla\\images\\2022_01_24\\png\\1485423491502178304.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '1', '2022-01-24 09:25:33', '2022-01-24 09:25:33');
INSERT INTO `image` VALUES ('1485423596967952384', 1, '1642987558009_1485423596967952384.jpeg', 'D:\\stucompla\\images\\2022_01_24\\jpeg\\1485423596967952384.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-01-24 09:25:58', '2022-01-24 09:25:58');
INSERT INTO `image` VALUES ('1493821236113965056', 1, '1644989711202_1493821236113965056.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493821236113965056.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 13:35:11', '2022-02-16 13:35:11');
INSERT INTO `image` VALUES ('1493823930836844544', 1, '1644990353675_1493823930836844544.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493823930836844544.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 13:45:54', '2022-02-16 13:45:54');
INSERT INTO `image` VALUES ('1493824703691882496', 1, '1644990537937_1493824703691882496.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493824703691882496.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 13:48:58', '2022-02-16 13:48:58');
INSERT INTO `image` VALUES ('1493828416322011136', 1, '1644991423098_1493828416322011136.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493828416322011136.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 14:03:43', '2022-02-16 14:03:43');
INSERT INTO `image` VALUES ('1493829735900381184', 1, '1644991737709_1493829735900381184.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493829735900381184.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 14:08:58', '2022-02-16 14:08:58');
INSERT INTO `image` VALUES ('1493832091752857600', 1, '1644992299389_1493832091752857600.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493832091752857600.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 14:18:19', '2022-02-16 14:18:19');
INSERT INTO `image` VALUES ('1493832434393939968', 1, '1644992381081_1493832434393939968.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493832434393939968.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 14:19:41', '2022-02-16 14:19:41');
INSERT INTO `image` VALUES ('1493835500941869056', 1, '1644993112202_1493835500941869056.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493835500941869056.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 14:31:52', '2022-02-16 14:31:52');
INSERT INTO `image` VALUES ('1493837158400786432', 1, '1644993507372_1493837158400786432.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493837158400786432.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 14:38:27', '2022-02-16 14:38:27');
INSERT INTO `image` VALUES ('1493842509531578368', 1, '1644994783181_1493842509531578368.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493842509531578368.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 14:59:43', '2022-02-16 14:59:43');
INSERT INTO `image` VALUES ('1493843411311132672', 1, '1644994998182_1493843411311132672.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493843411311132672.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 15:03:18', '2022-02-16 15:03:18');
INSERT INTO `image` VALUES ('1493846171347714048', 1, '1644995656226_1493846171347714048.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493846171347714048.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 15:14:16', '2022-02-16 15:14:16');
INSERT INTO `image` VALUES ('1493846568967733248', 1, '1644995751025_1493846568967733248.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493846568967733248.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 15:15:51', '2022-02-16 15:15:51');
INSERT INTO `image` VALUES ('1493847768660312064', 1, '1644996037055_1493847768660312064.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493847768660312064.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 15:20:37', '2022-02-16 15:20:37');
INSERT INTO `image` VALUES ('1493847975577911296', 1, '1644996086388_1493847975577911296.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493847975577911296.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 15:21:26', '2022-02-16 15:21:26');
INSERT INTO `image` VALUES ('1493850702462713856', 1, '1644996736528_1493850702462713856.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493850702462713856.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 15:32:17', '2022-02-16 15:32:17');
INSERT INTO `image` VALUES ('1493850739699744768', 1, '1644996745406_1493850739699744768.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493850739699744768.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 15:32:25', '2022-02-16 15:32:25');
INSERT INTO `image` VALUES ('1493872201827483648', 1, '1645001862375_1493872201827483648.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493872201827483648.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 16:57:42', '2022-02-16 16:57:42');
INSERT INTO `image` VALUES ('1493873081381421056', 1, '1645002072078_1493873081381421056.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493873081381421056.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 17:01:12', '2022-02-16 17:01:12');
INSERT INTO `image` VALUES ('1493874068536033280', 1, '1645002307433_1493874068536033280.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493874068536033280.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 17:05:07', '2022-02-16 17:05:07');
INSERT INTO `image` VALUES ('1493898079911411712', 1, '1645008032165_1493898079911411712.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493898079911411712.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-16 18:40:32', '2022-02-16 18:40:32');
INSERT INTO `image` VALUES ('1493898081282949120', 1, '1645008032519_1493898081282949120.png', 'D:\\stucompla\\images\\2022_02_16\\png\\1493898081282949120.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-16 18:40:33', '2022-02-16 18:40:33');
INSERT INTO `image` VALUES ('1494133672167735296', 1, '1645064201742_1494133672167735296.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494133672167735296.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 10:16:42', '2022-02-17 10:16:42');
INSERT INTO `image` VALUES ('1494138060168888320', 1, '1645065247943_1494138060168888320.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494138060168888320.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 10:34:08', '2022-02-17 10:34:08');
INSERT INTO `image` VALUES ('1494138060416352256', 1, '1645065248003_1494138060416352256.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494138060416352256.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 10:34:08', '2022-02-17 10:34:08');
INSERT INTO `image` VALUES ('1494138560410943488', 1, '1645065367211_1494138560410943488.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494138560410943488.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 10:36:07', '2022-02-17 10:36:07');
INSERT INTO `image` VALUES ('1494138560490635264', 1, '1645065367230_1494138560490635264.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494138560490635264.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 10:36:07', '2022-02-17 10:36:07');
INSERT INTO `image` VALUES ('1494187638775742464', 1, '1645077068391_1494187638775742464.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494187638775742464.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 13:51:09', '2022-02-17 13:51:09');
INSERT INTO `image` VALUES ('1494187642626113536', 1, '1645077069323_1494187642626113536.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494187642626113536.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 13:51:09', '2022-02-17 13:51:09');
INSERT INTO `image` VALUES ('1494187875292545024', 1, '1645077124794_1494187875292545024.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494187875292545024.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 13:52:05', '2022-02-17 13:52:05');
INSERT INTO `image` VALUES ('1494187875678420992', 1, '1645077124887_1494187875678420992.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494187875678420992.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 13:52:05', '2022-02-17 13:52:05');
INSERT INTO `image` VALUES ('1494190174643552256', 1, '1645077673003_1494190174643552256.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190174643552256.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 14:01:13', '2022-02-17 14:01:13');
INSERT INTO `image` VALUES ('1494190176463880192', 1, '1645077673436_1494190176463880192.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190176463880192.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 14:01:13', '2022-02-17 14:01:13');
INSERT INTO `image` VALUES ('1494190684985491456', 1, '1645077794677_1494190684985491456.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190684985491456.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 14:03:15', '2022-02-17 14:03:15');
INSERT INTO `image` VALUES ('1494190685157457920', 1, '1645077794719_1494190685157457920.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190685157457920.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 14:03:15', '2022-02-17 14:03:15');
INSERT INTO `image` VALUES ('1494190803654934528', 1, '1645077822971_1494190803654934528.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190803654934528.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 14:03:43', '2022-02-17 14:03:43');
INSERT INTO `image` VALUES ('1494190803894009856', 1, '1645077823028_1494190803894009856.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494190803894009856.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 14:03:43', '2022-02-17 14:03:43');
INSERT INTO `image` VALUES ('1494196166924042240', 1, '1645079101672_1494196166924042240.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494196166924042240.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 14:25:02', '2022-02-17 14:25:02');
INSERT INTO `image` VALUES ('1494198085478383616', 1, '1645079559089_1494198085478383616.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494198085478383616.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 14:32:39', '2022-02-17 14:32:39');
INSERT INTO `image` VALUES ('1494199226844971008', 1, '1645079831216_1494199226844971008.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494199226844971008.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 14:37:11', '2022-02-17 14:37:11');
INSERT INTO `image` VALUES ('1494199226941440000', 1, '1645079831239_1494199226941440000.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494199226941440000.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 14:37:11', '2022-02-17 14:37:11');
INSERT INTO `image` VALUES ('1494210679152967680', 1, '1645082561658_1494210679152967680.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494210679152967680.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:22:42', '2022-02-17 15:22:42');
INSERT INTO `image` VALUES ('1494210679450763264', 1, '1645082561730_1494210679450763264.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494210679450763264.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:22:42', '2022-02-17 15:22:42');
INSERT INTO `image` VALUES ('1494211379060670464', 1, '1645082728530_1494211379060670464.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211379060670464.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:25:29', '2022-02-17 15:25:29');
INSERT INTO `image` VALUES ('1494211379224248320', 1, '1645082728569_1494211379224248320.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211379224248320.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:25:29', '2022-02-17 15:25:29');
INSERT INTO `image` VALUES ('1494211799489314816', 1, '1645082828768_1494211799489314816.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211799489314816.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:27:09', '2022-02-17 15:27:09');
INSERT INTO `image` VALUES ('1494211799707418624', 1, '1645082828820_1494211799707418624.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211799707418624.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:27:09', '2022-02-17 15:27:09');
INSERT INTO `image` VALUES ('1494211952870817792', 1, '1645082865337_1494211952870817792.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211952870817792.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:27:45', '2022-02-17 15:27:45');
INSERT INTO `image` VALUES ('1494211953114087424', 1, '1645082865395_1494211953114087424.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494211953114087424.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:27:45', '2022-02-17 15:27:45');
INSERT INTO `image` VALUES ('1494212043065131008', 1, '1645082886841_1494212043065131008.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494212043065131008.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:28:07', '2022-02-17 15:28:07');
INSERT INTO `image` VALUES ('1494212043262263296', 1, '1645082886888_1494212043262263296.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494212043262263296.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:28:07', '2022-02-17 15:28:07');
INSERT INTO `image` VALUES ('1494213975666196480', 1, '1645083347609_1494213975666196480.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494213975666196480.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:35:48', '2022-02-17 15:35:48');
INSERT INTO `image` VALUES ('1494213975741693952', 1, '1645083347627_1494213975741693952.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494213975741693952.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:35:48', '2022-02-17 15:35:48');
INSERT INTO `image` VALUES ('1494214040476581888', 1, '1645083363061_1494214040476581888.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494214040476581888.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:36:03', '2022-02-17 15:36:03');
INSERT INTO `image` VALUES ('1494214040594022400', 1, '1645083363089_1494214040594022400.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494214040594022400.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:36:03', '2022-02-17 15:36:03');
INSERT INTO `image` VALUES ('1494214094205616128', 1, '1645083375871_1494214094205616128.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494214094205616128.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:36:16', '2022-02-17 15:36:16');
INSERT INTO `image` VALUES ('1494214182600572928', 1, '1645083396946_1494214182600572928.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494214182600572928.png', 'image/png', '学生成绩管理系统主页面.png', '1', '2022-02-17 15:36:37', '2022-02-17 15:36:37');
INSERT INTO `image` VALUES ('1494214182722207744', 1, '1645083396975_1494214182722207744.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494214182722207744.png', 'image/png', '学生信息管理系统登录界面.png', '1', '2022-02-17 15:36:37', '2022-02-17 15:36:37');
INSERT INTO `image` VALUES ('1494216288459948032', 1, '1645083899022_1494216288459948032.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216288459948032.png', 'image/png', '1494133672167735296.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216288585777152', 1, '1645083899052_1494216288585777152.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216288585777152.png', 'image/png', '1494138060168888320.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216288753549312', 1, '1645083899092_1494216288753549312.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216288753549312.png', 'image/png', '1494138060416352256.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216288938098688', 1, '1645083899136_1494216288938098688.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216288938098688.png', 'image/png', '1494138560410943488.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289038761984', 1, '1645083899160_1494216289038761984.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289038761984.png', 'image/png', '1494138560490635264.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289080705024', 1, '1645083899170_1494216289080705024.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289080705024.png', 'image/png', '1494187638775742464.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289110065152', 1, '1645083899177_1494216289110065152.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289110065152.png', 'image/png', '1494187642626113536.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289152008192', 1, '1645083899187_1494216289152008192.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289152008192.png', 'image/png', '1494187875292545024.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289256865792', 1, '1645083899212_1494216289256865792.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289256865792.png', 'image/png', '1494187875678420992.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289294614528', 1, '1645083899221_1494216289294614528.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289294614528.png', 'image/png', '1494190174643552256.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289336557568', 1, '1645083899231_1494216289336557568.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289336557568.png', 'image/png', '1494190176463880192.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289416249344', 1, '1645083899250_1494216289416249344.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289416249344.png', 'image/png', '1494190684985491456.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289604993024', 1, '1645083899295_1494216289604993024.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289604993024.png', 'image/png', '1494190685157457920.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289646936064', 1, '1645083899305_1494216289646936064.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289646936064.png', 'image/png', '1494190803654934528.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289688879104', 1, '1645083899315_1494216289688879104.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289688879104.png', 'image/png', '1494190803894009856.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289735016448', 1, '1645083899326_1494216289735016448.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289735016448.png', 'image/png', '1494196166924042240.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289776959488', 1, '1645083899336_1494216289776959488.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289776959488.png', 'image/png', '1494198085478383616.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289818902528', 1, '1645083899346_1494216289818902528.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289818902528.png', 'image/png', '1494199226844971008.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289856651264', 1, '1645083899355_1494216289856651264.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289856651264.png', 'image/png', '1494199226941440000.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289894400000', 1, '1645083899364_1494216289894400000.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289894400000.png', 'image/png', '1494210679152967680.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289953120256', 1, '1645083899378_1494216289953120256.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289953120256.png', 'image/png', '1494210679450763264.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216289999257600', 1, '1645083899389_1494216289999257600.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216289999257600.png', 'image/png', '1494211379060670464.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290032812032', 1, '1645083899397_1494216290032812032.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290032812032.png', 'image/png', '1494211379224248320.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290070560768', 1, '1645083899406_1494216290070560768.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290070560768.png', 'image/png', '1494211799489314816.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290104115200', 1, '1645083899414_1494216290104115200.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290104115200.png', 'image/png', '1494211799707418624.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290146058240', 1, '1645083899424_1494216290146058240.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290146058240.png', 'image/png', '1494211952870817792.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290183806976', 1, '1645083899433_1494216290183806976.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290183806976.png', 'image/png', '1494211953114087424.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290234138624', 1, '1645083899445_1494216290234138624.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290234138624.png', 'image/png', '1494212043065131008.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290276081664', 1, '1645083899455_1494216290276081664.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290276081664.png', 'image/png', '1494212043262263296.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290364162048', 1, '1645083899475_1494216290364162048.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290364162048.png', 'image/png', '1494213975666196480.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290431270912', 1, '1645083899492_1494216290431270912.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290431270912.png', 'image/png', '1494213975741693952.png', '1', '2022-02-17 15:44:59', '2022-02-17 15:44:59');
INSERT INTO `image` VALUES ('1494216290473213952', 1, '1645083899502_1494216290473213952.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290473213952.png', 'image/png', '1494214040476581888.png', '1', '2022-02-17 15:45:00', '2022-02-17 15:45:00');
INSERT INTO `image` VALUES ('1494216290510962688', 1, '1645083899511_1494216290510962688.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290510962688.png', 'image/png', '1494214040594022400.png', '1', '2022-02-17 15:45:00', '2022-02-17 15:45:00');
INSERT INTO `image` VALUES ('1494216290561294336', 1, '1645083899523_1494216290561294336.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290561294336.png', 'image/png', '1494214094205616128.png', '1', '2022-02-17 15:45:00', '2022-02-17 15:45:00');
INSERT INTO `image` VALUES ('1494216290615820288', 1, '1645083899536_1494216290615820288.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290615820288.png', 'image/png', '1494214182600572928.png', '1', '2022-02-17 15:45:00', '2022-02-17 15:45:00');
INSERT INTO `image` VALUES ('1494216290657763328', 1, '1645083899546_1494216290657763328.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216290657763328.png', 'image/png', '1494214182722207744.png', '1', '2022-02-17 15:45:00', '2022-02-17 15:45:00');
INSERT INTO `image` VALUES ('1494216660981252096', 1, '1645083987838_1494216660981252096.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216660981252096.png', 'image/png', '1494133672167735296.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661287436288', 1, '1645083987911_1494216661287436288.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661287436288.png', 'image/png', '1494138060168888320.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661346156544', 1, '1645083987925_1494216661346156544.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661346156544.png', 'image/png', '1494138060416352256.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661383905280', 1, '1645083987934_1494216661383905280.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661383905280.png', 'image/png', '1494138560410943488.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661421654016', 1, '1645083987943_1494216661421654016.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661421654016.png', 'image/png', '1494138560490635264.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661463597056', 1, '1645083987952_1494216661463597056.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661463597056.png', 'image/png', '1494187638775742464.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661497151488', 1, '1645083987961_1494216661497151488.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661497151488.png', 'image/png', '1494187642626113536.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661539094528', 1, '1645083987971_1494216661539094528.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661539094528.png', 'image/png', '1494187875292545024.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661572648960', 1, '1645083987979_1494216661572648960.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661572648960.png', 'image/png', '1494187875678420992.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661618786304', 1, '1645083987990_1494216661618786304.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661618786304.png', 'image/png', '1494190174643552256.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661652340736', 1, '1645083987998_1494216661652340736.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661652340736.png', 'image/png', '1494190176463880192.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661740421120', 1, '1645083988019_1494216661740421120.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661740421120.png', 'image/png', '1494190684985491456.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661773975552', 1, '1645083988027_1494216661773975552.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661773975552.png', 'image/png', '1494190685157457920.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661820112896', 1, '1645083988038_1494216661820112896.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661820112896.png', 'image/png', '1494190803654934528.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661857861632', 1, '1645083988047_1494216661857861632.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661857861632.png', 'image/png', '1494190803894009856.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216661920776192', 1, '1645083988062_1494216661920776192.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216661920776192.png', 'image/png', '1494196166924042240.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662021439488', 1, '1645083988086_1494216662021439488.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662021439488.png', 'image/png', '1494198085478383616.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662134685696', 1, '1645083988113_1494216662134685696.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662134685696.png', 'image/png', '1494199226844971008.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662176628736', 1, '1645083988123_1494216662176628736.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662176628736.png', 'image/png', '1494199226941440000.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662226960384', 1, '1645083988135_1494216662226960384.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662226960384.png', 'image/png', '1494210679152967680.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662264709120', 1, '1645083988143_1494216662264709120.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662264709120.png', 'image/png', '1494210679450763264.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662331817984', 1, '1645083988160_1494216662331817984.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662331817984.png', 'image/png', '1494211379060670464.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662398926848', 1, '1645083988176_1494216662398926848.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662398926848.png', 'image/png', '1494211379224248320.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662449258496', 1, '1645083988188_1494216662449258496.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662449258496.png', 'image/png', '1494211799489314816.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662591864832', 1, '1645083988222_1494216662591864832.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662591864832.png', 'image/png', '1494211799707418624.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662629613568', 1, '1645083988231_1494216662629613568.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662629613568.png', 'image/png', '1494211952870817792.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662663168000', 1, '1645083988239_1494216662663168000.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662663168000.png', 'image/png', '1494211953114087424.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662700916736', 1, '1645083988248_1494216662700916736.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662700916736.png', 'image/png', '1494212043065131008.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662734471168', 1, '1645083988256_1494216662734471168.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662734471168.png', 'image/png', '1494212043262263296.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662772219904', 1, '1645083988265_1494216662772219904.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662772219904.png', 'image/png', '1494213975666196480.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662805774336', 1, '1645083988273_1494216662805774336.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662805774336.png', 'image/png', '1494213975741693952.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662843523072', 1, '1645083988282_1494216662843523072.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662843523072.png', 'image/png', '1494214040476581888.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662939992064', 1, '1645083988305_1494216662939992064.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662939992064.png', 'image/png', '1494214040594022400.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216662981935104', 1, '1645083988314_1494216662981935104.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216662981935104.png', 'image/png', '1494214094205616128.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663019683840', 1, '1645083988324_1494216663019683840.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663019683840.png', 'image/png', '1494214182600572928.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663057432576', 1, '1645083988333_1494216663057432576.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663057432576.png', 'image/png', '1494214182722207744.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663099375616', 1, '1645083988343_1494216663099375616.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663099375616.png', 'image/png', '1494216288459948032.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663137124352', 1, '1645083988352_1494216663137124352.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663137124352.png', 'image/png', '1494216288585777152.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663221010432', 1, '1645083988372_1494216663221010432.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663221010432.png', 'image/png', '1494216288753549312.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663258759168', 1, '1645083988381_1494216663258759168.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663258759168.png', 'image/png', '1494216288938098688.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663300702208', 1, '1645083988391_1494216663300702208.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663300702208.png', 'image/png', '1494216289038761984.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663342645248', 1, '1645083988401_1494216663342645248.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663342645248.png', 'image/png', '1494216289080705024.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663388782592', 1, '1645083988412_1494216663388782592.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663388782592.png', 'image/png', '1494216289110065152.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663434919936', 1, '1645083988423_1494216663434919936.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663434919936.png', 'image/png', '1494216289152008192.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663514611712', 1, '1645083988442_1494216663514611712.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663514611712.png', 'image/png', '1494216289256865792.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663560749056', 1, '1645083988453_1494216663560749056.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663560749056.png', 'image/png', '1494216289294614528.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663590109184', 1, '1645083988460_1494216663590109184.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663590109184.png', 'image/png', '1494216289336557568.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663636246528', 1, '1645083988471_1494216663636246528.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663636246528.png', 'image/png', '1494216289416249344.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663699161088', 1, '1645083988486_1494216663699161088.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663699161088.png', 'image/png', '1494216289604993024.png', '1', '2022-02-17 15:46:28', '2022-02-17 15:46:28');
INSERT INTO `image` VALUES ('1494216663787241472', 1, '1645083988507_1494216663787241472.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663787241472.png', 'image/png', '1494216289646936064.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216663833378816', 1, '1645083988518_1494216663833378816.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663833378816.png', 'image/png', '1494216289688879104.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216663875321856', 1, '1645083988528_1494216663875321856.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663875321856.png', 'image/png', '1494216289735016448.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216663921459200', 1, '1645083988539_1494216663921459200.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663921459200.png', 'image/png', '1494216289776959488.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216663959207936', 1, '1645083988548_1494216663959207936.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216663959207936.png', 'image/png', '1494216289818902528.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664026316800', 1, '1645083988564_1494216664026316800.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664026316800.png', 'image/png', '1494216289856651264.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664072454144', 1, '1645083988575_1494216664072454144.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664072454144.png', 'image/png', '1494216289894400000.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664126980096', 1, '1645083988588_1494216664126980096.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664126980096.png', 'image/png', '1494216289953120256.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664168923136', 1, '1645083988598_1494216664168923136.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664168923136.png', 'image/png', '1494216289999257600.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664240226304', 1, '1645083988614_1494216664240226304.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664240226304.png', 'image/png', '1494216290032812032.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664277975040', 1, '1645083988624_1494216664277975040.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664277975040.png', 'image/png', '1494216290070560768.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664345083904', 1, '1645083988640_1494216664345083904.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664345083904.png', 'image/png', '1494216290104115200.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664395415552', 1, '1645083988652_1494216664395415552.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664395415552.png', 'image/png', '1494216290146058240.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664441552896', 1, '1645083988662_1494216664441552896.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664441552896.png', 'image/png', '1494216290183806976.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664479301632', 1, '1645083988672_1494216664479301632.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664479301632.png', 'image/png', '1494216290234138624.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664517050368', 1, '1645083988681_1494216664517050368.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664517050368.png', 'image/png', '1494216290276081664.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664550604800', 1, '1645083988689_1494216664550604800.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664550604800.png', 'image/png', '1494216290364162048.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664584159232', 1, '1645083988697_1494216664584159232.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664584159232.png', 'image/png', '1494216290431270912.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664676433920', 1, '1645083988719_1494216664676433920.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664676433920.png', 'image/png', '1494216290473213952.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664726765568', 1, '1645083988731_1494216664726765568.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664726765568.png', 'image/png', '1494216290510962688.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664777097216', 1, '1645083988743_1494216664777097216.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664777097216.png', 'image/png', '1494216290561294336.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664823234560', 1, '1645083988754_1494216664823234560.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664823234560.png', 'image/png', '1494216290615820288.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494216664886149120', 1, '1645083988768_1494216664886149120.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494216664886149120.png', 'image/png', '1494216290657763328.png', '1', '2022-02-17 15:46:29', '2022-02-17 15:46:29');
INSERT INTO `image` VALUES ('1494225325293436928', 1, '1645086053571_1494225325293436928.jpeg', 'D:\\stucompla\\images\\2022_02_17\\jpeg\\1494225325293436928.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-02-17 16:20:54', '2022-02-17 16:20:54');
INSERT INTO `image` VALUES ('1494240107874615296', 1, '1645089578013_1494240107874615296.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494240107874615296.png', 'image/png', '1493821236113965056.png', '1', '2022-02-17 17:19:38', '2022-02-17 17:19:38');
INSERT INTO `image` VALUES ('1494240108738641920', 1, '1645089578219_1494240108738641920.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494240108738641920.png', 'image/png', '1493823930836844544.png', '1', '2022-02-17 17:19:38', '2022-02-17 17:19:38');
INSERT INTO `image` VALUES ('1494240109095157760', 1, '1645089578304_1494240109095157760.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494240109095157760.png', 'image/png', '1493824703691882496.png', '1', '2022-02-17 17:19:38', '2022-02-17 17:19:38');
INSERT INTO `image` VALUES ('1494240109225181184', 1, '1645089578335_1494240109225181184.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494240109225181184.png', 'image/png', '1493828416322011136.png', '1', '2022-02-17 17:19:38', '2022-02-17 17:19:38');
INSERT INTO `image` VALUES ('1494240109413924864', 1, '1645089578380_1494240109413924864.png', 'D:\\stucompla\\images\\2022_02_17\\png\\1494240109413924864.png', 'image/png', '1493829735900381184.png', '1', '2022-02-17 17:19:38', '2022-02-17 17:19:38');
INSERT INTO `image` VALUES ('1494598808292687872', 1, '1645175098835_1494598808292687872.png', 'D:\\stucompla\\images\\2022_02_18\\png\\1494598808292687872.png', 'image/png', '1493828416322011136.png', '1', '2022-02-18 17:04:59', '2022-02-18 17:04:59');
INSERT INTO `image` VALUES ('1494598809035079680', 1, '1645175099034_1494598809035079680.png', 'D:\\stucompla\\images\\2022_02_18\\png\\1494598809035079680.png', 'image/png', '1493832434393939968.png', '1', '2022-02-18 17:04:59', '2022-02-18 17:04:59');
INSERT INTO `image` VALUES ('1495270094123696128', 1, '1645335145858_1495270094123696128.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270094123696128.png', 'image/png', '1493821236113965056.png', '1', '2022-02-20 13:32:26', '2022-02-20 13:32:26');
INSERT INTO `image` VALUES ('1495270094295662592', 1, '1645335145912_1495270094295662592.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270094295662592.png', 'image/png', '1493823930836844544.png', '1', '2022-02-20 13:32:26', '2022-02-20 13:32:26');
INSERT INTO `image` VALUES ('1495270094467629056', 1, '1645335145952_1495270094467629056.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270094467629056.png', 'image/png', '1493824703691882496.png', '1', '2022-02-20 13:32:26', '2022-02-20 13:32:26');
INSERT INTO `image` VALUES ('1495270505916268544', 1, '1645335244049_1495270505916268544.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270505916268544.png', 'image/png', '1493821236113965056.png', '1', '2022-02-20 13:34:04', '2022-02-20 13:34:04');
INSERT INTO `image` VALUES ('1495270505991766016', 1, '1645335244068_1495270505991766016.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270505991766016.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 13:34:04', '2022-02-20 13:34:04');
INSERT INTO `image` VALUES ('1495270506063069184', 1, '1645335244084_1495270506063069184.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270506063069184.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 13:34:04', '2022-02-20 13:34:04');
INSERT INTO `image` VALUES ('1495270744442142720', 1, '1645335300919_1495270744442142720.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270744442142720.png', 'image/png', '1493828416322011136.png', '1', '2022-02-20 13:35:01', '2022-02-20 13:35:01');
INSERT INTO `image` VALUES ('1495270744559583232', 1, '1645335300947_1495270744559583232.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495270744559583232.png', 'image/png', '1493832434393939968.png', '1', '2022-02-20 13:35:01', '2022-02-20 13:35:01');
INSERT INTO `image` VALUES ('1495271600113713152', 1, '1645335504927_1495271600113713152.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495271600113713152.png', 'image/png', '1493821236113965056.png', '1', '2022-02-20 13:38:25', '2022-02-20 13:38:25');
INSERT INTO `image` VALUES ('1495271600159850496', 1, '1645335504937_1495271600159850496.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495271600159850496.png', 'image/png', '1493823930836844544.png', '1', '2022-02-20 13:38:25', '2022-02-20 13:38:25');
INSERT INTO `image` VALUES ('1495271600294068224', 1, '1645335504970_1495271600294068224.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495271600294068224.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 13:38:25', '2022-02-20 13:38:25');
INSERT INTO `image` VALUES ('1495271646221697024', 1, '1645335515920_1495271646221697024.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495271646221697024.png', 'image/png', '1493872201827483648.png', '1', '2022-02-20 13:38:36', '2022-02-20 13:38:36');
INSERT INTO `image` VALUES ('1495271646381080576', 1, '1645335515958_1495271646381080576.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495271646381080576.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 13:38:36', '2022-02-20 13:38:36');
INSERT INTO `image` VALUES ('1495273521440489472', 1, '1645335963007_1495273521440489472.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273521440489472.png', 'image/png', '1493823930836844544.png', '1', '2022-02-20 13:46:03', '2022-02-20 13:46:03');
INSERT INTO `image` VALUES ('1495273521700536320', 1, '1645335963068_1495273521700536320.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273521700536320.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 13:46:03', '2022-02-20 13:46:03');
INSERT INTO `image` VALUES ('1495273521750867968', 1, '1645335963081_1495273521750867968.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273521750867968.png', 'image/png', '1493850702462713856.png', '1', '2022-02-20 13:46:03', '2022-02-20 13:46:03');
INSERT INTO `image` VALUES ('1495273868359761920', 1, '1645336045719_1495273868359761920.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273868359761920.png', 'image/png', '1493832091752857600.png', '1', '2022-02-20 13:47:26', '2022-02-20 13:47:26');
INSERT INTO `image` VALUES ('1495273868514951168', 1, '1645336045756_1495273868514951168.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273868514951168.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 13:47:26', '2022-02-20 13:47:26');
INSERT INTO `image` VALUES ('1495273868699500544', 1, '1645336045800_1495273868699500544.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495273868699500544.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 13:47:26', '2022-02-20 13:47:26');
INSERT INTO `image` VALUES ('1495274034693275648', 1, '1645336085376_1495274034693275648.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274034693275648.png', 'image/png', '1493873081381421056.png', '1', '2022-02-20 13:48:05', '2022-02-20 13:48:05');
INSERT INTO `image` VALUES ('1495274034751995904', 1, '1645336085390_1495274034751995904.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274034751995904.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 13:48:05', '2022-02-20 13:48:05');
INSERT INTO `image` VALUES ('1495274034856853504', 1, '1645336085415_1495274034856853504.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274034856853504.png', 'image/png', '1493898079911411712.png', '1', '2022-02-20 13:48:05', '2022-02-20 13:48:05');
INSERT INTO `image` VALUES ('1495274078922211328', 1, '1645336095921_1495274078922211328.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274078922211328.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 13:48:16', '2022-02-20 13:48:16');
INSERT INTO `image` VALUES ('1495274078985125888', 1, '1645336095936_1495274078985125888.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274078985125888.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 13:48:16', '2022-02-20 13:48:16');
INSERT INTO `image` VALUES ('1495274079064817664', 1, '1645336095954_1495274079064817664.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274079064817664.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 13:48:16', '2022-02-20 13:48:16');
INSERT INTO `image` VALUES ('1495274079098372096', 1, '1645336095963_1495274079098372096.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274079098372096.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 13:48:16', '2022-02-20 13:48:16');
INSERT INTO `image` VALUES ('1495274079303892992', 1, '1645336096012_1495274079303892992.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495274079303892992.png', 'image/png', '1493898079911411712.png', '1', '2022-02-20 13:48:16', '2022-02-20 13:48:16');
INSERT INTO `image` VALUES ('1495280433011752960', 1, '1645337610854_1495280433011752960.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495280433011752960.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 14:13:31', '2022-02-20 14:13:31');
INSERT INTO `image` VALUES ('1495280433112416256', 1, '1645337610878_1495280433112416256.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495280433112416256.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 14:13:31', '2022-02-20 14:13:31');
INSERT INTO `image` VALUES ('1495280975800827904', 1, '1645337740265_1495280975800827904.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495280975800827904.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 14:15:40', '2022-02-20 14:15:40');
INSERT INTO `image` VALUES ('1495280976006348800', 1, '1645337740314_1495280976006348800.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495280976006348800.png', 'image/png', '1493872201827483648.png', '1', '2022-02-20 14:15:40', '2022-02-20 14:15:40');
INSERT INTO `image` VALUES ('1495280976090234880', 1, '1645337740334_1495280976090234880.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495280976090234880.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 14:15:40', '2022-02-20 14:15:40');
INSERT INTO `image` VALUES ('1495289591924654080', 1, '1645339794509_1495289591924654080.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495289591924654080.png', 'image/png', '1493823930836844544.png', '1', '2022-02-20 14:49:55', '2022-02-20 14:49:55');
INSERT INTO `image` VALUES ('1495289592054677504', 1, '1645339794540_1495289592054677504.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495289592054677504.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 14:49:55', '2022-02-20 14:49:55');
INSERT INTO `image` VALUES ('1495289592260198400', 1, '1645339794588_1495289592260198400.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495289592260198400.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 14:49:55', '2022-02-20 14:49:55');
INSERT INTO `image` VALUES ('1495299817780412416', 1, '1645342232542_1495299817780412416.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495299817780412416.png', 'image/png', 'image.png', '1', '2022-02-20 15:30:33', '2022-02-20 15:30:33');
INSERT INTO `image` VALUES ('1495300238871756800', 1, '1645342332939_1495300238871756800.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495300238871756800.png', 'image/png', 'image.png', '1', '2022-02-20 15:32:13', '2022-02-20 15:32:13');
INSERT INTO `image` VALUES ('1495301118354391040', 1, '1645342542624_1495301118354391040.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495301118354391040.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 15:35:43', '2022-02-20 15:35:43');
INSERT INTO `image` VALUES ('1495301118438277120', 1, '1645342542644_1495301118438277120.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495301118438277120.png', 'image/png', '1493873081381421056.png', '1', '2022-02-20 15:35:43', '2022-02-20 15:35:43');
INSERT INTO `image` VALUES ('1495301118601854976', 1, '1645342542683_1495301118601854976.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495301118601854976.png', 'image/png', '1493898079911411712.png', '1', '2022-02-20 15:35:43', '2022-02-20 15:35:43');
INSERT INTO `image` VALUES ('1495302718057742336', 1, '1645342924023_1495302718057742336.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495302718057742336.png', 'image/png', 'image.png', '1', '2022-02-20 15:42:04', '2022-02-20 15:42:04');
INSERT INTO `image` VALUES ('1495303262931386368', 1, '1645343053931_1495303262931386368.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495303262931386368.png', 'image/png', '1493832091752857600.png', '1', '2022-02-20 15:44:14', '2022-02-20 15:44:14');
INSERT INTO `image` VALUES ('1495303416627462144', 1, '1645343090575_1495303416627462144.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495303416627462144.png', 'image/png', 'image.png', '1', '2022-02-20 15:44:51', '2022-02-20 15:44:51');
INSERT INTO `image` VALUES ('1495304488498626560', 1, '1645343346129_1495304488498626560.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495304488498626560.png', 'image/png', 'image.png', '1', '2022-02-20 15:49:07', '2022-02-20 15:49:07');
INSERT INTO `image` VALUES ('1495308732098281472', 1, '1645344357882_1495308732098281472.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495308732098281472.png', 'image/png', '1493898079911411712.png', '1', '2022-02-20 16:05:58', '2022-02-20 16:05:58');
INSERT INTO `image` VALUES ('1495312481759920128', 1, '1645345251871_1495312481759920128.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495312481759920128.png', 'image/png', 'image.png', '1', '2022-02-20 16:20:52', '2022-02-20 16:20:52');
INSERT INTO `image` VALUES ('1495313013035630592', 1, '1645345378537_1495313013035630592.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495313013035630592.png', 'image/png', 'image.png', '1', '2022-02-20 16:22:59', '2022-02-20 16:22:59');
INSERT INTO `image` VALUES ('1495326043198849024', 1, '1645348485170_1495326043198849024.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326043198849024.png', 'image/png', '1493828416322011136.png', '1', '2022-02-20 17:14:45', '2022-02-20 17:14:45');
INSERT INTO `image` VALUES ('1495326043500838912', 1, '1645348485242_1495326043500838912.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326043500838912.png', 'image/png', '1493829735900381184.png', '1', '2022-02-20 17:14:45', '2022-02-20 17:14:45');
INSERT INTO `image` VALUES ('1495326043693776896', 1, '1645348485288_1495326043693776896.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326043693776896.png', 'image/png', '1493832091752857600.png', '1', '2022-02-20 17:14:45', '2022-02-20 17:14:45');
INSERT INTO `image` VALUES ('1495326043974795264', 1, '1645348485355_1495326043974795264.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326043974795264.png', 'image/png', '1493832434393939968.png', '1', '2022-02-20 17:14:45', '2022-02-20 17:14:45');
INSERT INTO `image` VALUES ('1495326044029321216', 1, '1645348485368_1495326044029321216.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326044029321216.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 17:14:45', '2022-02-20 17:14:45');
INSERT INTO `image` VALUES ('1495326851625779200', 1, '1645348677914_1495326851625779200.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326851625779200.png', 'image/png', '1493821236113965056.png', '1', '2022-02-20 17:17:58', '2022-02-20 17:17:58');
INSERT INTO `image` VALUES ('1495326851776774144', 1, '1645348677950_1495326851776774144.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326851776774144.png', 'image/png', '1493835500941869056.png', '1', '2022-02-20 17:17:58', '2022-02-20 17:17:58');
INSERT INTO `image` VALUES ('1495326852003266560', 1, '1645348678004_1495326852003266560.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326852003266560.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 17:17:58', '2022-02-20 17:17:58');
INSERT INTO `image` VALUES ('1495326852116512768', 1, '1645348678031_1495326852116512768.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326852116512768.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 17:17:58', '2022-02-20 17:17:58');
INSERT INTO `image` VALUES ('1495326852208787456', 1, '1645348678053_1495326852208787456.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495326852208787456.png', 'image/png', '1493843411311132672.png', '1', '2022-02-20 17:17:58', '2022-02-20 17:17:58');
INSERT INTO `image` VALUES ('1495327269714001920', 1, '1645348777594_1495327269714001920.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327269714001920.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 17:19:38', '2022-02-20 17:19:38');
INSERT INTO `image` VALUES ('1495327269932105728', 1, '1645348777646_1495327269932105728.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327269932105728.png', 'image/png', '1493873081381421056.png', '1', '2022-02-20 17:19:38', '2022-02-20 17:19:38');
INSERT INTO `image` VALUES ('1495327270053740544', 1, '1645348777675_1495327270053740544.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327270053740544.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 17:19:38', '2022-02-20 17:19:38');
INSERT INTO `image` VALUES ('1495327589085085696', 1, '1645348853738_1495327589085085696.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327589085085696.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 17:20:54', '2022-02-20 17:20:54');
INSERT INTO `image` VALUES ('1495327589273829376', 1, '1645348853783_1495327589273829376.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327589273829376.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 17:20:54', '2022-02-20 17:20:54');
INSERT INTO `image` VALUES ('1495327589479350272', 1, '1645348853831_1495327589479350272.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495327589479350272.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 17:20:54', '2022-02-20 17:20:54');
INSERT INTO `image` VALUES ('1495330631540932608', 1, '1645349579116_1495330631540932608.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495330631540932608.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 17:32:59', '2022-02-20 17:32:59');
INSERT INTO `image` VALUES ('1495330631809368064', 1, '1645349579179_1495330631809368064.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495330631809368064.png', 'image/png', '1493850702462713856.png', '1', '2022-02-20 17:32:59', '2022-02-20 17:32:59');
INSERT INTO `image` VALUES ('1495330631998111744', 1, '1645349579224_1495330631998111744.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495330631998111744.png', 'image/png', '1493872201827483648.png', '1', '2022-02-20 17:32:59', '2022-02-20 17:32:59');
INSERT INTO `image` VALUES ('1495331473023172608', 1, '1645349779741_1495331473023172608.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331473023172608.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 17:36:20', '2022-02-20 17:36:20');
INSERT INTO `image` VALUES ('1495331473195139072', 1, '1645349779782_1495331473195139072.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331473195139072.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 17:36:20', '2022-02-20 17:36:20');
INSERT INTO `image` VALUES ('1495331473543266304', 1, '1645349779865_1495331473543266304.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331473543266304.png', 'image/png', '1493898079911411712.png', '1', '2022-02-20 17:36:20', '2022-02-20 17:36:20');
INSERT INTO `image` VALUES ('1495331804389965824', 1, '1645349858745_1495331804389965824.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331804389965824.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 17:37:39', '2022-02-20 17:37:39');
INSERT INTO `image` VALUES ('1495331804582903808', 1, '1645349858791_1495331804582903808.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331804582903808.png', 'image/png', '1493850739699744768.png', '1', '2022-02-20 17:37:39', '2022-02-20 17:37:39');
INSERT INTO `image` VALUES ('1495331804801007616', 1, '1645349858843_1495331804801007616.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495331804801007616.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 17:37:39', '2022-02-20 17:37:39');
INSERT INTO `image` VALUES ('1495334273958412288', 1, '1645350447536_1495334273958412288.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495334273958412288.png', 'image/png', '1493843411311132672.png', '1', '2022-02-20 17:47:28', '2022-02-20 17:47:28');
INSERT INTO `image` VALUES ('1495334274000355328', 1, '1645350447546_1495334274000355328.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495334274000355328.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 17:47:28', '2022-02-20 17:47:28');
INSERT INTO `image` VALUES ('1495334274168127488', 1, '1645350447586_1495334274168127488.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495334274168127488.png', 'image/png', '1493872201827483648.png', '1', '2022-02-20 17:47:28', '2022-02-20 17:47:28');
INSERT INTO `image` VALUES ('1495334274348482560', 1, '1645350447629_1495334274348482560.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495334274348482560.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 17:47:28', '2022-02-20 17:47:28');
INSERT INTO `image` VALUES ('1495343319490887680', 1, '1645352604140_1495343319490887680.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343319490887680.png', 'image/png', '1493823930836844544.png', '1', '2022-02-20 18:23:24', '2022-02-20 18:23:24');
INSERT INTO `image` VALUES ('1495343319776100352', 1, '1645352604227_1495343319776100352.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343319776100352.png', 'image/png', '1493837158400786432.png', '1', '2022-02-20 18:23:24', '2022-02-20 18:23:24');
INSERT INTO `image` VALUES ('1495343319813849088', 1, '1645352604236_1495343319813849088.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343319813849088.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 18:23:24', '2022-02-20 18:23:24');
INSERT INTO `image` VALUES ('1495343319931289600', 1, '1645352604264_1495343319931289600.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343319931289600.png', 'image/png', '1493843411311132672.png', '1', '2022-02-20 18:23:24', '2022-02-20 18:23:24');
INSERT INTO `image` VALUES ('1495343319973232640', 1, '1645352604274_1495343319973232640.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343319973232640.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 18:23:24', '2022-02-20 18:23:24');
INSERT INTO `image` VALUES ('1495343744420020224', 1, '1645352705469_1495343744420020224.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343744420020224.png', 'image/png', '1493842509531578368.png', '1', '2022-02-20 18:25:05', '2022-02-20 18:25:05');
INSERT INTO `image` VALUES ('1495343744579403776', 1, '1645352705507_1495343744579403776.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343744579403776.png', 'image/png', '1493843411311132672.png', '1', '2022-02-20 18:25:06', '2022-02-20 18:25:06');
INSERT INTO `image` VALUES ('1495343744667484160', 1, '1645352705529_1495343744667484160.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343744667484160.png', 'image/png', '1493850739699744768.png', '1', '2022-02-20 18:25:06', '2022-02-20 18:25:06');
INSERT INTO `image` VALUES ('1495343744810090496', 1, '1645352705563_1495343744810090496.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343744810090496.png', 'image/png', '1493873081381421056.png', '1', '2022-02-20 18:25:06', '2022-02-20 18:25:06');
INSERT INTO `image` VALUES ('1495343744910753792', 1, '1645352705587_1495343744910753792.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495343744910753792.png', 'image/png', '1493874068536033280.png', '1', '2022-02-20 18:25:06', '2022-02-20 18:25:06');
INSERT INTO `image` VALUES ('1495351542964944896', 1, '1645354564787_1495351542964944896.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351542964944896.png', 'image/png', '1493843411311132672.png', '1', '2022-02-20 18:56:05', '2022-02-20 18:56:05');
INSERT INTO `image` VALUES ('1495351543107551232', 1, '1645354564822_1495351543107551232.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351543107551232.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 18:56:05', '2022-02-20 18:56:05');
INSERT INTO `image` VALUES ('1495351543254351872', 1, '1645354564857_1495351543254351872.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351543254351872.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 18:56:05', '2022-02-20 18:56:05');
INSERT INTO `image` VALUES ('1495351752009056256', 1, '1645354614628_1495351752009056256.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351752009056256.png', 'image/png', '1493846171347714048.png', '1', '2022-02-20 18:56:55', '2022-02-20 18:56:55');
INSERT INTO `image` VALUES ('1495351752130691072', 1, '1645354614657_1495351752130691072.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351752130691072.png', 'image/png', '1493846568967733248.png', '1', '2022-02-20 18:56:55', '2022-02-20 18:56:55');
INSERT INTO `image` VALUES ('1495351752344600576', 1, '1645354614708_1495351752344600576.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495351752344600576.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 18:56:55', '2022-02-20 18:56:55');
INSERT INTO `image` VALUES ('1495352086701932544', 1, '1645354694425_1495352086701932544.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495352086701932544.png', 'image/png', '1493846568967733248.png', '0', '2022-02-20 18:58:14', '2022-02-20 18:58:14');
INSERT INTO `image` VALUES ('1495352086748069888', 1, '1645354694436_1495352086748069888.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495352086748069888.png', 'image/png', '1493847768660312064.png', '1', '2022-02-20 18:58:14', '2022-02-20 18:58:14');
INSERT INTO `image` VALUES ('1495352086869704704', 1, '1645354694465_1495352086869704704.png', 'D:\\stucompla\\images\\2022_02_20\\png\\1495352086869704704.png', 'image/png', '1493873081381421056.png', '1', '2022-02-20 18:58:14', '2022-02-20 18:58:14');
INSERT INTO `image` VALUES ('1495599323499593728', 1, '1645413640256_1495599323499593728.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495599323499593728.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 11:20:40', '2022-02-21 11:20:40');
INSERT INTO `image` VALUES ('1495621500131213312', 1, '1645418927575_1495621500131213312.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495621500131213312.png', 'image/png', '1493872201827483648.png', '1', '2022-02-21 12:48:48', '2022-02-21 12:48:48');
INSERT INTO `image` VALUES ('1495621500554838016', 1, '1645418927693_1495621500554838016.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495621500554838016.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 12:48:48', '2022-02-21 12:48:48');
INSERT INTO `image` VALUES ('1495622173757407232', 1, '1645419088196_1495622173757407232.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495622173757407232.png', 'image/png', '1493842509531578368.png', '1', '2022-02-21 12:51:28', '2022-02-21 12:51:28');
INSERT INTO `image` VALUES ('1495622173874847744', 1, '1645419088225_1495622173874847744.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495622173874847744.png', 'image/png', '1493843411311132672.png', '1', '2022-02-21 12:51:28', '2022-02-21 12:51:28');
INSERT INTO `image` VALUES ('1495622948889952256', 1, '1645419273003_1495622948889952256.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495622948889952256.png', 'image/png', '1493874068536033280.png', '1', '2022-02-21 12:54:33', '2022-02-21 12:54:33');
INSERT INTO `image` VALUES ('1495622949489737728', 1, '1645419273146_1495622949489737728.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495622949489737728.png', 'image/png', '1493898079911411712.png', '1', '2022-02-21 12:54:33', '2022-02-21 12:54:33');
INSERT INTO `image` VALUES ('1495623603155238912', 1, '1645419428992_1495623603155238912.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495623603155238912.png', 'image/png', '1493846568967733248.png', '1', '2022-02-21 12:57:09', '2022-02-21 12:57:09');
INSERT INTO `image` VALUES ('1495627069877518336', 1, '1645420255523_1495627069877518336.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495627069877518336.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 13:10:56', '2022-02-21 13:10:56');
INSERT INTO `image` VALUES ('1495627069919461376', 1, '1645420255533_1495627069919461376.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495627069919461376.png', 'image/png', '1493874068536033280.png', '1', '2022-02-21 13:10:56', '2022-02-21 13:10:56');
INSERT INTO `image` VALUES ('1495627600721215488', 1, '1645420382086_1495627600721215488.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495627600721215488.png', 'image/png', '1493843411311132672.png', '1', '2022-02-21 13:13:02', '2022-02-21 13:13:02');
INSERT INTO `image` VALUES ('1495627600779935744', 1, '1645420382100_1495627600779935744.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495627600779935744.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 13:13:02', '2022-02-21 13:13:02');
INSERT INTO `image` VALUES ('1495629023471075328', 1, '1645420721296_1495629023471075328.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629023471075328.png', 'image/png', '1493823930836844544.png', '1', '2022-02-21 13:18:41', '2022-02-21 13:18:41');
INSERT INTO `image` VALUES ('1495629023504629760', 1, '1645420721304_1495629023504629760.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629023504629760.png', 'image/png', '1493837158400786432.png', '1', '2022-02-21 13:18:41', '2022-02-21 13:18:41');
INSERT INTO `image` VALUES ('1495629322973741056', 1, '1645420792703_1495629322973741056.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629322973741056.png', 'image/png', '1493846171347714048.png', '0', '2022-02-21 13:19:53', '2022-02-21 13:19:53');
INSERT INTO `image` VALUES ('1495629323074404352', 1, '1645420792727_1495629323074404352.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629323074404352.png', 'image/png', '1493846568967733248.png', '1', '2022-02-21 13:19:53', '2022-02-21 13:19:53');
INSERT INTO `image` VALUES ('1495629616054927360', 1, '1645420862579_1495629616054927360.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629616054927360.png', 'image/png', '1493846568967733248.png', '0', '2022-02-21 13:21:03', '2022-02-21 13:21:03');
INSERT INTO `image` VALUES ('1495629616352722944', 1, '1645420862650_1495629616352722944.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495629616352722944.png', 'image/png', '1493874068536033280.png', '1', '2022-02-21 13:21:03', '2022-02-21 13:21:03');
INSERT INTO `image` VALUES ('1495651860768489472', 1, '1645426166121_1495651860768489472.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495651860768489472.png', 'image/png', '1493843411311132672.png', '1', '2022-02-21 14:49:26', '2022-02-21 14:49:26');
INSERT INTO `image` VALUES ('1495651862316187648', 1, '1645426166501_1495651862316187648.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495651862316187648.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 14:49:27', '2022-02-21 14:49:27');
INSERT INTO `image` VALUES ('1495652677248483328', 1, '1645426360796_1495652677248483328.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495652677248483328.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 14:52:41', '2022-02-21 14:52:41');
INSERT INTO `image` VALUES ('1495652677957320704', 1, '1645426360965_1495652677957320704.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495652677957320704.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 14:52:41', '2022-02-21 14:52:41');
INSERT INTO `image` VALUES ('1495655052638027776', 1, '1645426927133_1495655052638027776.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495655052638027776.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 15:02:07', '2022-02-21 15:02:07');
INSERT INTO `image` VALUES ('1495655052877103104', 1, '1645426927190_1495655052877103104.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495655052877103104.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 15:02:07', '2022-02-21 15:02:07');
INSERT INTO `image` VALUES ('1495664765660430336', 1, '1645429242898_1495664765660430336.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495664765660430336.png', 'image/png', '1493846171347714048.png', '1', '2022-02-21 15:40:43', '2022-02-21 15:40:43');
INSERT INTO `image` VALUES ('1495664766457348096', 1, '1645429243088_1495664766457348096.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495664766457348096.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 15:40:43', '2022-02-21 15:40:43');
INSERT INTO `image` VALUES ('1495665968955916288', 1, '1645429529786_1495665968955916288.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495665968955916288.png', 'image/png', '1493873081381421056.png', '1', '2022-02-21 15:45:30', '2022-02-21 15:45:30');
INSERT INTO `image` VALUES ('1495665969018830848', 1, '1645429529801_1495665969018830848.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495665969018830848.png', 'image/png', '1493874068536033280.png', '1', '2022-02-21 15:45:30', '2022-02-21 15:45:30');
INSERT INTO `image` VALUES ('1495694982584074240', 1, '1645436447173_1495694982584074240.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495694982584074240.png', 'image/png', '1493842509531578368.png', '1', '2022-02-21 17:40:47', '2022-02-21 17:40:47');
INSERT INTO `image` VALUES ('1495694982646988800', 1, '1645436447189_1495694982646988800.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495694982646988800.png', 'image/png', '1493843411311132672.png', '1', '2022-02-21 17:40:47', '2022-02-21 17:40:47');
INSERT INTO `image` VALUES ('1495694982873481216', 1, '1645436447243_1495694982873481216.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495694982873481216.png', 'image/png', '1493872201827483648.png', '1', '2022-02-21 17:40:47', '2022-02-21 17:40:47');
INSERT INTO `image` VALUES ('1495695370192289792', 1, '1645436539587_1495695370192289792.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495695370192289792.png', 'image/png', '1493846568967733248.png', '0', '2022-02-21 17:42:20', '2022-02-21 17:42:20');
INSERT INTO `image` VALUES ('1495695370431365120', 1, '1645436539643_1495695370431365120.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495695370431365120.png', 'image/png', '1493874068536033280.png', '1', '2022-02-21 17:42:20', '2022-02-21 17:42:20');
INSERT INTO `image` VALUES ('1495695370485891072', 1, '1645436539657_1495695370485891072.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495695370485891072.png', 'image/png', '1493898079911411712.png', '1', '2022-02-21 17:42:20', '2022-02-21 17:42:20');
INSERT INTO `image` VALUES ('1495695879078805504', 1, '1645436660915_1495695879078805504.png', 'D:\\stucompla\\images\\2022_02_21\\png\\1495695879078805504.png', 'image/png', '1493842509531578368.png', '1', '2022-02-21 17:44:21', '2022-02-21 17:44:21');
INSERT INTO `image` VALUES ('1497828142310621184', 1, '1645945032069_1497828142310621184.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497828142310621184.png', 'image/png', '1493874068536033280.png', '1', '2022-02-27 14:57:12', '2022-02-27 14:57:12');
INSERT INTO `image` VALUES ('1497828770239873024', 1, '1645945181795_1497828770239873024.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497828770239873024.png', 'image/png', '1493846568967733248.png', '1', '2022-02-27 14:59:42', '2022-02-27 14:59:42');
INSERT INTO `image` VALUES ('1497829950324080640', 1, '1645945463149_1497829950324080640.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497829950324080640.png', 'image/png', '1493847768660312064.png', '1', '2022-02-27 15:04:23', '2022-02-27 15:04:23');
INSERT INTO `image` VALUES ('1497831840705282048', 1, '1645945913851_1497831840705282048.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497831840705282048.png', 'image/png', '1493832091752857600.png', '1', '2022-02-27 15:11:54', '2022-02-27 15:11:54');
INSERT INTO `image` VALUES ('1497832033790066688', 1, '1645945959886_1497832033790066688.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497832033790066688.png', 'image/png', '1493847768660312064.png', '1', '2022-02-27 15:12:40', '2022-02-27 15:12:40');
INSERT INTO `image` VALUES ('1497833697926316032', 1, '1645946356647_1497833697926316032.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497833697926316032.png', 'image/png', '1493846568967733248.png', '1', '2022-02-27 15:19:17', '2022-02-27 15:19:17');
INSERT INTO `image` VALUES ('1497833871180431360', 1, '1645946397954_1497833871180431360.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497833871180431360.png', 'image/png', '1493846171347714048.png', '1', '2022-02-27 15:19:58', '2022-02-27 15:19:58');
INSERT INTO `image` VALUES ('1497835498406805504', 1, '1645946785915_1497835498406805504.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497835498406805504.png', 'image/png', '1493846171347714048.png', '1', '2022-02-27 15:26:26', '2022-02-27 15:26:26');
INSERT INTO `image` VALUES ('1497835686634586112', 1, '1645946830792_1497835686634586112.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497835686634586112.png', 'image/png', '1493872201827483648.png', '1', '2022-02-27 15:27:11', '2022-02-27 15:27:11');
INSERT INTO `image` VALUES ('1497866743329193984', 1, '1645954235285_1497866743329193984.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497866743329193984.png', 'image/png', '1493821236113965056.png', '1', '2022-02-27 17:30:35', '2022-02-27 17:30:35');
INSERT INTO `image` VALUES ('1497867178643423232', 1, '1645954339072_1497867178643423232.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497867178643423232.png', 'image/png', '1493847768660312064.png', '1', '2022-02-27 17:32:19', '2022-02-27 17:32:19');
INSERT INTO `image` VALUES ('1497945933038616576', 1, '1645973115550_1497945933038616576.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497945933038616576.png', 'image/png', '1493873081381421056.png', '1', '2022-02-27 22:45:16', '2022-02-27 22:45:16');
INSERT INTO `image` VALUES ('1497945933671956480', 1, '1645973115734_1497945933671956480.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497945933671956480.png', 'image/png', '1493874068536033280.png', '1', '2022-02-27 22:45:16', '2022-02-27 22:45:16');
INSERT INTO `image` VALUES ('1497946144511229952', 1, '1645973165860_1497946144511229952.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497946144511229952.png', 'image/png', '1493846568967733248.png', '1', '2022-02-27 22:46:06', '2022-02-27 22:46:06');
INSERT INTO `image` VALUES ('1497952305188831232', 1, '1645974634822_1497952305188831232.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497952305188831232.png', 'image/png', '1493824703691882496.png', '1', '2022-02-27 23:10:35', '2022-02-27 23:10:35');
INSERT INTO `image` VALUES ('1497952305771839488', 1, '1645974634960_1497952305771839488.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497952305771839488.png', 'image/png', '1493828416322011136.png', '1', '2022-02-27 23:10:35', '2022-02-27 23:10:35');
INSERT INTO `image` VALUES ('1497952880789946368', 1, '1645974772056_1497952880789946368.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497952880789946368.png', 'image/png', '1493828416322011136.png', '1', '2022-02-27 23:12:52', '2022-02-27 23:12:52');
INSERT INTO `image` VALUES ('1497952880789946369', 1, '1645974772056_1497952880789946369.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497952880789946369.png', 'image/png', '1493824703691882496.png', '1', '2022-02-27 23:12:52', '2022-02-27 23:12:52');
INSERT INTO `image` VALUES ('1497953163381178368', 1, '1645974839431_1497953163381178368.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497953163381178368.png', 'image/png', '1493843411311132672.png', '1', '2022-02-27 23:13:59', '2022-02-27 23:13:59');
INSERT INTO `image` VALUES ('1497953541283774464', 1, '1645974929530_1497953541283774464.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497953541283774464.png', 'image/png', '1493846171347714048.png', '1', '2022-02-27 23:15:30', '2022-02-27 23:15:30');
INSERT INTO `image` VALUES ('1497958749107781632', 1, '1645976171172_1497958749107781632.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497958749107781632.png', 'image/png', '1493847768660312064.png', '1', '2022-02-27 23:36:11', '2022-02-27 23:36:11');
INSERT INTO `image` VALUES ('1497958920579317760', 1, '1645976212054_1497958920579317760.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497958920579317760.png', 'image/png', '1493824703691882496.png', '1', '2022-02-27 23:36:52', '2022-02-27 23:36:52');
INSERT INTO `image` VALUES ('1497958920679981056', 1, '1645976212078_1497958920679981056.png', 'D:\\stucompla\\images\\2022_02_27\\png\\1497958920679981056.png', 'image/png', '1493828416322011136.png', '1', '2022-02-27 23:36:52', '2022-02-27 23:36:52');
INSERT INTO `image` VALUES ('1498103364314071040', 1, '1646010650101_1498103364314071040.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498103364314071040.png', 'image/png', '1493842509531578368.png', '1', '2022-02-28 09:10:50', '2022-02-28 09:10:50');
INSERT INTO `image` VALUES ('1498103364326653952', 1, '1646010650101_1498103364326653952.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498103364326653952.png', 'image/png', '1493843411311132672.png', '1', '2022-02-28 09:10:50', '2022-02-28 09:10:50');
INSERT INTO `image` VALUES ('1498103364326653953', 1, '1646010650101_1498103364326653953.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498103364326653953.png', 'image/png', '1493824703691882496.png', '1', '2022-02-28 09:10:50', '2022-02-28 09:10:50');
INSERT INTO `image` VALUES ('1498111606884794368', 1, '1646012615306_1498111606884794368.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498111606884794368.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 09:43:35', '2022-02-28 09:43:35');
INSERT INTO `image` VALUES ('1498111607195172864', 1, '1646012615380_1498111607195172864.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498111607195172864.png', 'image/png', '1493847768660312064.png', '1', '2022-02-28 09:43:35', '2022-02-28 09:43:35');
INSERT INTO `image` VALUES ('1498112067721363456', 1, '1646012725178_1498112067721363456.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498112067721363456.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 09:45:25', '2022-02-28 09:45:25');
INSERT INTO `image` VALUES ('1498112067910107136', 1, '1646012725223_1498112067910107136.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498112067910107136.png', 'image/png', '1493847768660312064.png', '1', '2022-02-28 09:45:25', '2022-02-28 09:45:25');
INSERT INTO `image` VALUES ('1498112067985604608', 1, '1646012725241_1498112067985604608.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498112067985604608.png', 'image/png', '1493832434393939968.png', '1', '2022-02-28 09:45:25', '2022-02-28 09:45:25');
INSERT INTO `image` VALUES ('1498113829903663104', 1, '1646013145315_1498113829903663104.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498113829903663104.png', 'image/png', '1493837158400786432.png', '1', '2022-02-28 09:52:25', '2022-02-28 09:52:25');
INSERT INTO `image` VALUES ('1498113829995937792', 1, '1646013145337_1498113829995937792.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498113829995937792.png', 'image/png', '1493835500941869056.png', '1', '2022-02-28 09:52:25', '2022-02-28 09:52:25');
INSERT INTO `image` VALUES ('1498113954961031168', 1, '1646013175131_1498113954961031168.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498113954961031168.png', 'image/png', '1493837158400786432.png', '1', '2022-02-28 09:52:55', '2022-02-28 09:52:55');
INSERT INTO `image` VALUES ('1498113955044917248', 1, '1646013175151_1498113955044917248.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498113955044917248.png', 'image/png', '1493842509531578368.png', '1', '2022-02-28 09:52:55', '2022-02-28 09:52:55');
INSERT INTO `image` VALUES ('1498114721147125760', 1, '1646013357804_1498114721147125760.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498114721147125760.png', 'image/png', '1493842509531578368.png', '1', '2022-02-28 09:55:58', '2022-02-28 09:55:58');
INSERT INTO `image` VALUES ('1498114721159708672', 1, '1646013357807_1498114721159708672.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498114721159708672.png', 'image/png', '1493837158400786432.png', '1', '2022-02-28 09:55:58', '2022-02-28 09:55:58');
INSERT INTO `image` VALUES ('1498114922171727872', 1, '1646013405731_1498114922171727872.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498114922171727872.png', 'image/png', '1493823930836844544.png', '1', '2022-02-28 09:56:46', '2022-02-28 09:56:46');
INSERT INTO `image` VALUES ('1498114922305945600', 1, '1646013405764_1498114922305945600.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498114922305945600.png', 'image/png', '1493821236113965056.png', '1', '2022-02-28 09:56:46', '2022-02-28 09:56:46');
INSERT INTO `image` VALUES ('1498117392130244608', 1, '1646013994616_1498117392130244608.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498117392130244608.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 10:06:35', '2022-02-28 10:06:35');
INSERT INTO `image` VALUES ('1498117392449011712', 1, '1646013994692_1498117392449011712.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498117392449011712.png', 'image/png', '1493846171347714048.png', '1', '2022-02-28 10:06:35', '2022-02-28 10:06:35');
INSERT INTO `image` VALUES ('1498117925335334912', 1, '1646014121742_1498117925335334912.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498117925335334912.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 10:08:42', '2022-02-28 10:08:42');
INSERT INTO `image` VALUES ('1498117925385666560', 1, '1646014121754_1498117925385666560.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498117925385666560.png', 'image/png', '1493846171347714048.png', '1', '2022-02-28 10:08:42', '2022-02-28 10:08:42');
INSERT INTO `image` VALUES ('1498118003659767808', 1, '1646014140416_1498118003659767808.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498118003659767808.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 10:09:00', '2022-02-28 10:09:00');
INSERT INTO `image` VALUES ('1498118003705905152', 1, '1646014140427_1498118003705905152.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498118003705905152.png', 'image/png', '1493846171347714048.png', '1', '2022-02-28 10:09:00', '2022-02-28 10:09:00');
INSERT INTO `image` VALUES ('1498232846442168320', 1, '1646041521061_1498232846442168320.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498232846442168320.png', 'image/png', '1493843411311132672.png', '1', '2022-02-28 17:45:21', '2022-02-28 17:45:21');
INSERT INTO `image` VALUES ('1498232846450556928', 1, '1646041521062_1498232846450556928.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498232846450556928.png', 'image/png', '1493828416322011136.png', '1', '2022-02-28 17:45:21', '2022-02-28 17:45:21');
INSERT INTO `image` VALUES ('1498232846450556929', 1, '1646041521061_1498232846450556929.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498232846450556929.png', 'image/png', '1493829735900381184.png', '1', '2022-02-28 17:45:21', '2022-02-28 17:45:21');
INSERT INTO `image` VALUES ('1498233715334184960', 1, '1646041728229_1498233715334184960.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498233715334184960.png', 'image/png', '1493843411311132672.png', '1', '2022-02-28 17:48:48', '2022-02-28 17:48:48');
INSERT INTO `image` VALUES ('1498233715816529920', 1, '1646041728344_1498233715816529920.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498233715816529920.png', 'image/png', '1493842509531578368.png', '1', '2022-02-28 17:48:48', '2022-02-28 17:48:48');
INSERT INTO `image` VALUES ('1498234029315588096', 1, '1646041803088_1498234029315588096.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498234029315588096.png', 'image/png', '1493846568967733248.png', '1', '2022-02-28 17:50:03', '2022-02-28 17:50:03');
INSERT INTO `image` VALUES ('1498244633900220416', 1, '1646044331417_1498244633900220416.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498244633900220416.png', 'image/png', '1493846171347714048.png', '1', '2022-02-28 18:32:11', '2022-02-28 18:32:11');
INSERT INTO `image` VALUES ('1498247318577741824', 1, '1646044971494_1498247318577741824.png', 'D:\\stucompla\\images\\2022_02_28\\png\\1498247318577741824.png', 'image/png', '1493835500941869056.png', '1', '2022-02-28 18:42:52', '2022-02-28 18:42:52');
INSERT INTO `image` VALUES ('1511956751115747328', 1, '1649313554787_1511956751115747328.jpeg', 'D:\\stucompla\\images\\2022_04_07\\jpeg\\1511956751115747328.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-07 14:39:15', '2022-04-07 14:39:15');
INSERT INTO `image` VALUES ('1511957180541173760', 1, '1649313657303_1511957180541173760.jpeg', 'D:\\stucompla\\images\\2022_04_07\\jpeg\\1511957180541173760.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-07 14:40:57', '2022-04-07 14:40:57');
INSERT INTO `image` VALUES ('1511963165716512768', 1, '1649315084281_1511963165716512768.jpeg', 'D:\\stucompla\\images\\2022_04_07\\jpeg\\1511963165716512768.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-07 15:04:44', '2022-04-07 15:04:44');
INSERT INTO `image` VALUES ('1511963446529359872', 1, '1649315151232_1511963446529359872.png', 'D:\\stucompla\\images\\2022_04_07\\png\\1511963446529359872.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '1', '2022-04-07 15:05:51', '2022-04-07 15:05:51');
INSERT INTO `image` VALUES ('1512619641065832448', 1, '1649471600199_1512619641065832448.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512619641065832448.png', 'image/png', '16234846156416317.png', '0', '2022-04-09 10:33:20', '2022-04-09 10:33:20');
INSERT INTO `image` VALUES ('1512619748989468672', 1, '1649471625932_1512619748989468672.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512619748989468672.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-09 10:33:46', '2022-04-09 10:33:46');
INSERT INTO `image` VALUES ('1512619829809512448', 1, '1649471645201_1512619829809512448.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512619829809512448.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '0', '2022-04-09 10:34:05', '2022-04-09 10:34:05');
INSERT INTO `image` VALUES ('1512619830094725120', 1, '1649471645269_1512619830094725120.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512619830094725120.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-09 10:34:05', '2022-04-09 10:34:05');
INSERT INTO `image` VALUES ('1512622303387713536', 1, '1649472234933_1512622303387713536.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512622303387713536.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-09 10:43:55', '2022-04-09 10:43:55');
INSERT INTO `image` VALUES ('1512622342273105920', 1, '1649472244219_1512622342273105920.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512622342273105920.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '1', '2022-04-09 10:44:04', '2022-04-09 10:44:04');
INSERT INTO `image` VALUES ('1512623201753104384', 1, '1649472449135_1512623201753104384.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512623201753104384.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-09 10:47:29', '2022-04-09 10:47:29');
INSERT INTO `image` VALUES ('1512623250755158016', 1, '1649472460818_1512623250755158016.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512623250755158016.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '1', '2022-04-09 10:47:41', '2022-04-09 10:47:41');
INSERT INTO `image` VALUES ('1512624120607670272', 1, '1649472668207_1512624120607670272.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512624120607670272.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-09 10:51:08', '2022-04-09 10:51:08');
INSERT INTO `image` VALUES ('1512624160805879808', 1, '1649472677791_1512624160805879808.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512624160805879808.png', 'image/png', 'windows-10-logo-abstract-blue-waves-technology-5336.PNG', '1', '2022-04-09 10:51:18', '2022-04-09 10:51:18');
INSERT INTO `image` VALUES ('1512631150949040128', 1, '1649474344343_1512631150949040128.png', 'D:\\stucompla\\images\\2022_04_09\\png\\1512631150949040128.png', 'image/png', '16234846156416317.png', '1', '2022-04-09 11:19:04', '2022-04-09 11:19:04');
INSERT INTO `image` VALUES ('1512631240698757120', 1, '1649474365769_1512631240698757120.jpeg', 'D:\\stucompla\\images\\2022_04_09\\jpeg\\1512631240698757120.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-09 11:19:26', '2022-04-09 11:19:26');
INSERT INTO `image` VALUES ('1513908841509683200', 1, '1649778969359_1513908841509683200.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513908841509683200.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-12 23:56:10', '2022-04-12 23:56:10');
INSERT INTO `image` VALUES ('1513909388375621632', 1, '1649779099922_1513909388375621632.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909388375621632.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-12 23:58:20', '2022-04-12 23:58:20');
INSERT INTO `image` VALUES ('1513909439340609536', 1, '1649779112073_1513909439340609536.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909439340609536.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-12 23:58:32', '2022-04-12 23:58:32');
INSERT INTO `image` VALUES ('1513909661080879104', 1, '1649779164940_1513909661080879104.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909661080879104.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-12 23:59:25', '2022-04-12 23:59:25');
INSERT INTO `image` VALUES ('1513909687777624064', 1, '1649779171305_1513909687777624064.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909687777624064.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-12 23:59:31', '2022-04-12 23:59:31');
INSERT INTO `image` VALUES ('1513909739392729088', 1, '1649779183611_1513909739392729088.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909739392729088.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-12 23:59:44', '2022-04-12 23:59:44');
INSERT INTO `image` VALUES ('1513909796695310336', 1, '1649779197273_1513909796695310336.jpeg', 'D:\\stucompla\\images\\2022_04_12\\jpeg\\1513909796695310336.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-12 23:59:57', '2022-04-12 23:59:57');
INSERT INTO `image` VALUES ('1514052474904903680', 1, '1649813214408_1514052474904903680.jpeg', 'D:\\stucompla\\images\\2022_04_13\\jpeg\\1514052474904903680.jpeg', 'image/jpeg', '有线耳机.jpg', '0', '2022-04-13 09:26:54', '2022-04-13 09:26:54');
INSERT INTO `image` VALUES ('1514052521595895808', 1, '1649813225541_1514052521595895808.jpeg', 'D:\\stucompla\\images\\2022_04_13\\jpeg\\1514052521595895808.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-13 09:27:06', '2022-04-13 09:27:06');
INSERT INTO `image` VALUES ('1514052553929785344', 1, '1649813233250_1514052553929785344.jpeg', 'D:\\stucompla\\images\\2022_04_13\\jpeg\\1514052553929785344.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-13 09:27:13', '2022-04-13 09:27:13');
INSERT INTO `image` VALUES ('1514430675934117888', 1, '1649903384560_1514430675934117888.png', 'D:\\stucompla\\images\\2022_04_14\\png\\1514430675934117888.png', 'image/png', 'image.png', '0', '2022-04-14 10:29:45', '2022-04-14 10:29:45');
INSERT INTO `image` VALUES ('1514430773200027648', 1, '1649903407750_1514430773200027648.png', 'D:\\stucompla\\images\\2022_04_14\\png\\1514430773200027648.png', 'image/png', 'image.png', '0', '2022-04-14 10:30:08', '2022-04-14 10:30:08');
INSERT INTO `image` VALUES ('1514430811246559232', 1, '1649903416822_1514430811246559232.png', 'D:\\stucompla\\images\\2022_04_14\\png\\1514430811246559232.png', 'image/png', 'image.png', '0', '2022-04-14 10:30:17', '2022-04-14 10:30:17');
INSERT INTO `image` VALUES ('1514430849108541440', 1, '1649903425849_1514430849108541440.png', 'D:\\stucompla\\images\\2022_04_14\\png\\1514430849108541440.png', 'image/png', 'image.png', '0', '2022-04-14 10:30:26', '2022-04-14 10:30:26');
INSERT INTO `image` VALUES ('1514430895245885440', 1, '1649903436849_1514430895245885440.png', 'D:\\stucompla\\images\\2022_04_14\\png\\1514430895245885440.png', 'image/png', 'image.png', '0', '2022-04-14 10:30:37', '2022-04-14 10:30:37');
INSERT INTO `image` VALUES ('1515266075120500736', 1, '1650102559228_1515266075120500736.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515266075120500736.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 17:49:20', '2022-04-16 17:49:20');
INSERT INTO `image` VALUES ('1515267704674713600', 1, '1650102947705_1515267704674713600.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515267704674713600.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 17:55:48', '2022-04-16 17:55:48');
INSERT INTO `image` VALUES ('1515267852138053632', 1, '1650102982922_1515267852138053632.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515267852138053632.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 17:56:23', '2022-04-16 17:56:23');
INSERT INTO `image` VALUES ('1515267963870117888', 1, '1650103009561_1515267963870117888.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515267963870117888.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 17:56:50', '2022-04-16 17:56:50');
INSERT INTO `image` VALUES ('1515271338804248576', 1, '1650103814207_1515271338804248576.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515271338804248576.png', 'image/png', '1512631150949040128.png', '0', '2022-04-16 18:10:14', '2022-04-16 18:10:14');
INSERT INTO `image` VALUES ('1515271355489189888', 1, '1650103818186_1515271355489189888.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515271355489189888.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 18:10:18', '2022-04-16 18:10:18');
INSERT INTO `image` VALUES ('1515271473558847488', 1, '1650103846336_1515271473558847488.png', 'D:\\stucompla\\images\\2022_04_16\\png\\1515271473558847488.png', 'image/png', '1512631150949040128.png', '1', '2022-04-16 18:10:46', '2022-04-16 18:10:46');
INSERT INTO `image` VALUES ('1515273218141847552', 1, '1650104262277_1515273218141847552.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515273218141847552.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 18:17:42', '2022-04-16 18:17:42');
INSERT INTO `image` VALUES ('1515273598519083008', 1, '1650104352966_1515273598519083008.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515273598519083008.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 18:19:13', '2022-04-16 18:19:13');
INSERT INTO `image` VALUES ('1515309804065783808', 1, '1650112985041_1515309804065783808.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515309804065783808.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 20:43:05', '2022-04-16 20:43:05');
INSERT INTO `image` VALUES ('1515312690761957376', 1, '1650113673270_1515312690761957376.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515312690761957376.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 20:54:33', '2022-04-16 20:54:33');
INSERT INTO `image` VALUES ('1515318726461882368', 1, '1650115112305_1515318726461882368.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515318726461882368.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 21:18:32', '2022-04-16 21:18:32');
INSERT INTO `image` VALUES ('1515335846453182464', 1, '1650119194030_1515335846453182464.jpeg', 'D:\\stucompla\\images\\2022_04_16\\jpeg\\1515335846453182464.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-16 22:26:34', '2022-04-16 22:26:34');
INSERT INTO `image` VALUES ('1515527621486706688', 1, '1650164916761_1515527621486706688.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515527621486706688.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 11:08:37', '2022-04-17 11:08:37');
INSERT INTO `image` VALUES ('1515630656682590208', 1, '1650189482266_1515630656682590208.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515630656682590208.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 17:58:02', '2022-04-17 17:58:02');
INSERT INTO `image` VALUES ('1515630669416497152', 1, '1650189485301_1515630669416497152.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515630669416497152.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 17:58:05', '2022-04-17 17:58:05');
INSERT INTO `image` VALUES ('1515630682615971840', 1, '1650189488449_1515630682615971840.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515630682615971840.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 17:58:08', '2022-04-17 17:58:08');
INSERT INTO `image` VALUES ('1515632868632690688', 1, '1650190009635_1515632868632690688.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515632868632690688.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 18:06:50', '2022-04-17 18:06:50');
INSERT INTO `image` VALUES ('1515632884822704128', 1, '1650190013496_1515632884822704128.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515632884822704128.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 18:06:54', '2022-04-17 18:06:54');
INSERT INTO `image` VALUES ('1515632897468530688', 1, '1650190016511_1515632897468530688.jpeg', 'D:\\stucompla\\images\\2022_04_17\\jpeg\\1515632897468530688.jpeg', 'image/jpeg', '有线耳机.jpg', '1', '2022-04-17 18:06:57', '2022-04-17 18:06:57');

-- ----------------------------
-- Table structure for market_order
-- ----------------------------
DROP TABLE IF EXISTS `market_order`;
CREATE TABLE `market_order`  (
  `order_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `seller_id` int(0) NULL DEFAULT NULL COMMENT '卖家id',
  `buyer_id` int(0) NULL DEFAULT NULL COMMENT '买家id',
  `goods_id` int(0) NULL DEFAULT NULL COMMENT '商品id',
  `buy_count` int(0) NULL DEFAULT NULL COMMENT '购买数量',
  `total_price` double(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '订单生成时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `order_status` tinyint(0) NULL DEFAULT NULL COMMENT '订单状态：0-未付 1-已付 2-已发货 3-已签收 4-已退货 5-订单完成',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of market_order
-- ----------------------------
INSERT INTO `market_order` VALUES (21, 1, 1, 13, 1, 13.00, '2022-04-20 17:59:00', '2022-04-20 17:59:06', 1);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `permission_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `permission_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限',
  `permission_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名',
  `father_id` int(0) NOT NULL COMMENT '父权限',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '路径',
  `is_menu` int(0) NOT NULL,
  PRIMARY KEY (`permission_id`) USING BTREE,
  UNIQUE INDEX `permission_code`(`permission_code`) USING BTREE,
  UNIQUE INDEX `permission_name`(`permission_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'wall', '表白墙相关', 0, '/wall', 1);
INSERT INTO `permission` VALUES (2, 'wall:ask', '申请上墙', 1, '/wall/ask', 1);
INSERT INTO `permission` VALUES (3, 'wall:look', '查看墙列表', 1, '/wall/look', 0);
INSERT INTO `permission` VALUES (4, 'wall:comment', '墙评论', 1, '/wall/comment', 1);
INSERT INTO `permission` VALUES (5, 'course:history', '历史课程', 1, '/course/history', 1);
INSERT INTO `permission` VALUES (6, 'grade', '成绩相关', 0, '/grade', 1);
INSERT INTO `permission` VALUES (7, 'grade:this', '本学期成绩', 6, '/grade/this', 1);
INSERT INTO `permission` VALUES (8, 'grade:history', '历史成绩', 6, '/grade/history', 1);
INSERT INTO `permission` VALUES (9, 'grade_manage', '成绩管理', 0, '/grade_manage', 0);
INSERT INTO `permission` VALUES (10, 'grade_manage:in', '录入成绩', 9, '/grade_manage/in', 0);
INSERT INTO `permission` VALUES (11, 'course_start', '查看开课', 0, '/course_start', 1);
INSERT INTO `permission` VALUES (12, 'course_start:history', '历史开课', 11, '/course_start/history', 1);
INSERT INTO `permission` VALUES (13, 'course_start:this', '本学期开课', 11, '/course_start/this', 1);
INSERT INTO `permission` VALUES (14, 'showCourseStudent', '查看课程学生名单', 11, '/showCourseStudent', 0);
INSERT INTO `permission` VALUES (15, 'course_manage', '课程管理', 0, '/course_manage', 1);
INSERT INTO `permission` VALUES (16, 'course_manage:add', '增加课程', 15, '/course_manage/add', 1);
INSERT INTO `permission` VALUES (17, 'course_manage:look', '查看课程', 15, '/course_manage/look', 1);
INSERT INTO `permission` VALUES (18, 'course_manage:delete', '删除课程', 15, '/course_manage/delete', 0);
INSERT INTO `permission` VALUES (19, 'course_manage:update', '修改课程', 15, '/course_manage/update', 0);
INSERT INTO `permission` VALUES (20, 'term', '学期管理', 0, '/term', 1);
INSERT INTO `permission` VALUES (21, 'term:set', '设置当前学期', 20, '/term/set', 1);
INSERT INTO `permission` VALUES (22, 'choose_manage', '选课管理', 0, '/choose_manage', 1);
INSERT INTO `permission` VALUES (23, 'choose_manage:open', '开放选课', 22, '/choose_manage/open', 1);
INSERT INTO `permission` VALUES (24, 'choose_manage:close', '关闭选课', 22, '/choose_manage/close', 0);

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `comment_num` int(0) NULL DEFAULT NULL COMMENT '评论数',
  `view_num` int(0) NULL DEFAULT NULL COMMENT '点击数',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '发布人ID',
  `category_id` int(0) NULL DEFAULT NULL COMMENT '种类ID',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `best_post` tinyint(0) NULL DEFAULT NULL COMMENT '精帖状态',
  `collect_num` int(0) NULL DEFAULT NULL COMMENT '收藏数',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, '交流一下技术呀兄弟们', '<p>哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈</p><style>/* table 样式 */\n							table {\n							  border-top: 1px solid #ccc;\n							  border-left: 1px solid #ccc;\n							}\n							table td,\n							table th {\n							  border-bottom: 1px solid #ccc;\n							  border-right: 1px solid #ccc;\n							  padding: 3px 5px;\n							}\n							table th {\n							  border-bottom: 2px solid #ccc;\n							  text-align: center;\n							}\n\n							/* blockquote 样式 */\n							blockquote {\n							  display: block;\n							  border-left: 8px solid #d0e5f2;\n							  padding: 5px 10px;\n							  margin: 10px 0;\n							  line-height: 1.4;\n							  font-size: 100%;\n							  background-color: #f1f1f1;\n							}\n\n							/* code 样式 */\n							code {\n							  display: inline-block;\n							  *display: inline;\n							  *zoom: 1;\n							  background-color: #f1f1f1;\n							  border-radius: 3px;\n							  padding: 3px 5px;\n							  margin: 0 3px;\n							}\n							pre code {\n							  display: block;\n							}\n\n							/* ul ol 样式 */\n							ul, ol {\n							  margin: 10px 0 10px 20px;\n							}\n						</style>', NULL, 0, 52, '2022-02-21 19:43:27', 1, 1, '2022-04-15 21:21:05', 0, 0);
INSERT INTO `post` VALUES (2, '交流一下技术呀兄弟们', '<p>哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈</p><style>/* table 样式 */\n							table {\n							  border-top: 1px solid #ccc;\n							  border-left: 1px solid #ccc;\n							}\n							table td,\n							table th {\n							  border-bottom: 1px solid #ccc;\n							  border-right: 1px solid #ccc;\n							  padding: 3px 5px;\n							}\n							table th {\n							  border-bottom: 2px solid #ccc;\n							  text-align: center;\n							}\n\n							/* blockquote 样式 */\n							blockquote {\n							  display: block;\n							  border-left: 8px solid #d0e5f2;\n							  padding: 5px 10px;\n							  margin: 10px 0;\n							  line-height: 1.4;\n							  font-size: 100%;\n							  background-color: #f1f1f1;\n							}\n\n							/* code 样式 */\n							code {\n							  display: inline-block;\n							  *display: inline;\n							  *zoom: 1;\n							  background-color: #f1f1f1;\n							  border-radius: 3px;\n							  padding: 3px 5px;\n							  margin: 0 3px;\n							}\n							pre code {\n							  display: block;\n							}\n\n							/* ul ol 样式 */\n							ul, ol {\n							  margin: 10px 0 10px 20px;\n							}\n						</style>', NULL, 0, 51, '2022-02-21 19:44:51', 1, 1, '2022-04-17 21:45:23', 0, 0);
INSERT INTO `post` VALUES (3, '交流生活一下吧', '<p>sd1f21as3f3s1</p><table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"><tbody><tr><th></th><th></th><th></th><th></th><th></th></tr><tr><td></td><td></td><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td><td></td><td></td></tr></tbody></table><blockquote><p>0.0.</p><p>123</p><p><br/></p></blockquote><pre><code class=\"Bash\"><xmp>132s1d21fsf</xmp></code></pre><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 9, 34, '2022-02-23 11:36:57', 1, 2, '2022-04-12 20:30:08', 0, 0);
INSERT INTO `post` VALUES (4, '我是一个标题', '测试测试测试', NULL, 0, 1, '2022-04-07 11:08:56', 2, 1, '2022-04-17 11:05:28', 0, 0);
INSERT INTO `post` VALUES (5, '测试一下标题', '<p><img src=\"http://localhost:8086/image/1649313657303_1511957180541173760.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/>00000000000测试0000</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-07 14:41:07', 1, 2, '2022-04-07 14:41:07', 0, 0);
INSERT INTO `post` VALUES (6, '测试一下标题', '<p><img src=\"http://localhost:8086/image/1649313657303_1511957180541173760.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/>00000000000测试0000</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-07 14:41:16', 1, 2, '2022-04-07 14:41:16', 0, 0);
INSERT INTO `post` VALUES (7, '测试一下  ', '<p><img src=\"http://localhost:8086/image/1649315151232_1511963446529359872.png\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\"/>0000000测试</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 1, '2022-04-07 15:06:02', 1, 1, '2022-04-12 13:53:30', 0, 1);
INSERT INTO `post` VALUES (8, 'test123132', 'test bestPost', NULL, 0, 2, '2022-04-09 00:03:54', 2, 2, '2022-04-12 20:40:52', 0, 0);
INSERT INTO `post` VALUES (9, '测试保存images', '<p>哈哈哈</p><p><img src=\"http://localhost:8086/image/1649471600199_1512619641065832448.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/>这是我的头像，好看吗？</p><p>嘻嘻</p><p><img src=\"http://localhost:8086/image/1649471625932_1512619748989468672.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>这个是有线耳机</p><p><img src=\"http://localhost:8086/image/1649471645201_1512619829809512448.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/></p><p>这是桌面壁纸！！！</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:34:35', 1, 2, '2022-04-09 10:34:35', 0, 0);
INSERT INTO `post` VALUES (10, '测试保存images 222', '<p>哈哈哈222</p><p><img src=\"http://localhost:8086/image/1649471600199_1512619641065832448.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/>这是我的头像，好看吗？</p><p>嘻嘻</p><p><img src=\"http://localhost:8086/image/1649471625932_1512619748989468672.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>这个是有线耳机</p><p><img src=\"http://localhost:8086/image/1649471645201_1512619829809512448.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/></p><p>这是桌面壁纸！！！</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:38:34', 1, 2, '2022-04-09 10:38:34', 0, 0);
INSERT INTO `post` VALUES (11, '测试保存images 222', '<p>哈哈哈222</p><p><img src=\"http://localhost:8086/image/1649471600199_1512619641065832448.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/>这是我的头像，好看吗？</p><p>嘻嘻</p><p><img src=\"http://localhost:8086/image/1649471625932_1512619748989468672.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>这个是有线耳机</p><p><img src=\"http://localhost:8086/image/1649471645201_1512619829809512448.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/></p><p>这是桌面壁纸！！！</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:40:39', 1, 2, '2022-04-09 10:40:39', 0, 0);
INSERT INTO `post` VALUES (12, '测试保存images 222', '<p>哈哈哈222</p><p><img src=\"http://localhost:8086/image/1649471600199_1512619641065832448.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/>这是我的头像，好看吗？</p><p>嘻嘻</p><p><img src=\"http://localhost:8086/image/1649471625932_1512619748989468672.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>这个是有线耳机</p><p><img src=\"http://localhost:8086/image/1649471645201_1512619829809512448.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/></p><p>这是桌面壁纸！！！</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 20, '2022-04-09 10:42:10', 1, 2, '2022-04-12 16:13:18', 0, 0);
INSERT INTO `post` VALUES (13, '测试images33', '<p>465465646</p><p><br/><img src=\"http://localhost:8086/image/1649472234933_1512622303387713536.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>0.31323132<br/><br/>1213123<img src=\"http://localhost:8086/image/1649472244219_1512622342273105920.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>132132132</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:44:47', 1, 1, '2022-04-09 10:44:47', 0, 0);
INSERT INTO `post` VALUES (14, '测试images33', '<p>465465646</p><p><br/><img src=\"http://localhost:8086/image/1649472234933_1512622303387713536.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>0.31323132<br/><br/>1213123<img src=\"http://localhost:8086/image/1649472244219_1512622342273105920.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>132132132</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:47:01', 1, 1, '2022-04-09 10:47:01', 0, 0);
INSERT INTO `post` VALUES (15, '测试images33', '<p>11111</p><p><img src=\"http://localhost:8086/image/1649472449135_1512623201753104384.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>2222</p><p><img src=\"http://localhost:8086/image/1649472460818_1512623250755158016.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>333</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:47:48', 1, 1, '2022-04-09 10:47:48', 0, 0);
INSERT INTO `post` VALUES (16, '测试images33', '<p>11111</p><p><img src=\"http://localhost:8086/image/1649472449135_1512623201753104384.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>2222</p><p><img src=\"http://localhost:8086/image/1649472460818_1512623250755158016.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/><br/>333</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:50:47', 1, 1, '2022-04-09 10:50:47', 0, 0);
INSERT INTO `post` VALUES (17, '516', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/><br/>13212312212332</p><p><img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/><br/>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 2, '2022-04-09 10:51:55', 1, 1, '2022-04-12 13:53:21', 0, 1);
INSERT INTO `post` VALUES (18, '516', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/><br/>13212312212332</p><p><img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/><br/>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 0, '2022-04-09 10:53:16', 1, 1, '2022-04-09 10:53:16', 0, 0);
INSERT INTO `post` VALUES (19, 'cdcds', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\"/><br/>13212312212332</p><p><img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\"/><br/>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', NULL, 0, 1, '2022-04-09 10:53:54', 1, 1, '2022-04-13 10:47:19', 0, 0);
INSERT INTO `post` VALUES (20, 'zdfdsf', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/></p><p>12123<br/>1321231221233</p><p>2<img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/></p><p>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649472668207_1512624120607670272.jpeg,1649472677791_1512624160805879808.png', 7, 588, '2022-04-09 11:01:49', 1, 1, '2022-04-12 23:39:34', 1, 1);
INSERT INTO `post` VALUES (21, 'zdfdsf', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/></p><p>12123<br/>1321231221233</p><p>2<img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/></p><p>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649472668207_1512624120607670272.jpeg,1649472677791_1512624160805879808.png', 0, 123, '2022-04-09 11:03:17', 1, 1, '2022-04-12 21:44:46', 1, 0);
INSERT INTO `post` VALUES (22, 'zdfdsf', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/></p><p>12123<br/>1321231221233</p><p>2<img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/></p><p>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649472668207_1512624120607670272.jpeg,1649472677791_1512624160805879808.png', 0, 24, '2022-04-09 11:03:18', 1, 1, '2022-04-14 13:49:51', 1, 1);
INSERT INTO `post` VALUES (23, 'zdfdsf', '<p><br/><img src=\"http://localhost:8086/image/1649472668207_1512624120607670272.jpeg\" width=\"50%\"/></p><p>12123<br/>1321231221233</p><p>2<img src=\"http://localhost:8086/image/1649472677791_1512624160805879808.png\" width=\"30%\"/></p><p>2131564655</p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649472668207_1512624120607670272.jpeg,1649472677791_1512624160805879808.png', 0, 27, '2022-04-09 11:03:18', 1, 1, '2022-04-11 21:30:07', 1, 0);
INSERT INTO `post` VALUES (24, 's1dfa2sd1f', '<p>asdfdsf</p><p><img src=\"http://localhost:8086/image/1649474344343_1512631150949040128.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/><br/></p><p>3213311564</p><p><img src=\"http://localhost:8086/image/1649474365769_1512631240698757120.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649474344343_1512631150949040128.png,1649474365769_1512631240698757120.jpeg', 0, 1, '2022-04-09 11:19:28', 1, 2, '2022-04-14 14:13:23', 1, 0);
INSERT INTO `post` VALUES (25, 's1dfa2sd1f', '<p>asdfdsf</p><p><img src=\"http://localhost:8086/image/1649474344343_1512631150949040128.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/><br/></p><p>3213311564</p><p><img src=\"http://localhost:8086/image/1649474365769_1512631240698757120.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649474344343_1512631150949040128.png,1649474365769_1512631240698757120.jpeg', 0, 2, '2022-04-09 11:19:30', 1, 2, '2022-04-12 13:45:43', 0, 0);
INSERT INTO `post` VALUES (26, 's1dfa2sd1f', '<p>asdfdsf</p><p><img src=\"http://localhost:8086/image/1649474344343_1512631150949040128.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/><br/></p><p>3213311564</p><p><img src=\"http://localhost:8086/image/1649474365769_1512631240698757120.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649474344343_1512631150949040128.png,1649474365769_1512631240698757120.jpeg', 1, 63, '2022-04-09 11:19:30', 1, 2, '2022-04-20 09:42:40', 1, 0);
INSERT INTO `post` VALUES (27, 's1dfa2sd1f', '<p>asdfdsf</p><p><img src=\"http://localhost:8086/image/1649474344343_1512631150949040128.png\" style=\"max-width:100%;\" contenteditable=\"false\"/><br/><br/></p><p>3213311564</p><p><img src=\"http://localhost:8086/image/1649474365769_1512631240698757120.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\"/></p><style>/* table 样式 */\n	table {\n	  border-top: 1px solid #ccc;\n	  border-left: 1px solid #ccc;\n	}\n	table td,\n	table th {\n	  border-bottom: 1px solid #ccc;\n	  border-right: 1px solid #ccc;\n	  padding: 3px 5px;\n	}\n	table th {\n	  border-bottom: 2px solid #ccc;\n	  text-align: center;\n	}\n\n	/* blockquote 样式 */\n	blockquote {\n	  display: block;\n	  border-left: 8px solid #d0e5f2;\n	  padding: 5px 10px;\n	  margin: 10px 0;\n	  line-height: 1.4;\n	  font-size: 100%;\n	  background-color: #f1f1f1;\n	}\n\n	/* code 样式 */\n	code {\n	  display: inline-block;\n	  *display: inline;\n	  *zoom: 1;\n	  background-color: #f1f1f1;\n	  border-radius: 3px;\n	  padding: 3px 5px;\n	  margin: 0 3px;\n	}\n	pre code {\n	  display: block;\n	}\n\n	/* ul ol 样式 */\n	ul, ol {\n	  margin: 10px 0 10px 20px;\n	}\n</style>', '1649474344343_1512631150949040128.png,1649474365769_1512631240698757120.jpeg', 1, 11, '2022-04-09 11:19:30', 1, 2, '2022-04-20 16:21:44', 1, 1);
INSERT INTO `post` VALUES (28, '测试一下新发布界面', '<p>哈哈哈1313</p><p>21313</p><p>12313</p><p>12313</p><p>12313</p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '', 0, 1, '2022-04-12 23:45:39', 1, 1, '2022-04-12 23:46:52', 0, 0);
INSERT INTO `post` VALUES (29, '测试一下图片', '<p><img src=\"http://localhost:8086/image/1649779099922_1513909388375621632.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/>13213</p><p>1321</p><p>123322</p><p>1231313</p><p>12313</p><p><img src=\"http://localhost:8086/image/1649779112073_1513909439340609536.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"50%\"/>哈哈哈哈</p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '1649779099922_1513909388375621632.jpeg,1649779112073_1513909439340609536.jpeg', 0, 2, '2022-04-12 23:58:45', 1, 2, '2022-04-15 21:23:49', 0, 0);
INSERT INTO `post` VALUES (30, '测试图片3', '<p><img src=\"http://localhost:8086/image/1649779171305_1513909687777624064.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>21321<img src=\"http://localhost:8086/image/1649779197273_1513909796695310336.jpeg\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\" width=\"30%\"/></p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '1649779171305_1513909687777624064.jpeg,1649779197273_1513909796695310336.jpeg', 0, 1, '2022-04-13 00:00:10', 1, 1, '2022-04-13 00:00:24', 0, 0);
INSERT INTO `post` VALUES (31, '测试一下发帖哈哈哈1654546', '<p><br/>321213</p><p><img src=\"http://localhost:8086/image/1649813225541_1514052521595895808.jpeg\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"30%\"/><br/>131313<img src=\"http://localhost:8086/image/1649813233250_1514052553929785344.jpeg\" contenteditable=\"false\" style=\"font-size: 14px; max-width: 100%;\" width=\"50%\"/></p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '1649813225541_1514052521595895808.jpeg,1649813233250_1514052553929785344.jpeg', 0, 5, '2022-04-13 09:27:25', 1, 1, '2022-04-14 18:10:27', 0, 0);
INSERT INTO `post` VALUES (32, '【技术交流】Android医院信息管理-护士站系统源码', '<p>Android医院信息管理-护士站系统源码，目录结构如下所示：<br/><br/><img src=\"http://img.lieyou888.com/000/2022/03/24/8bf36e2a-8583-46cb-9c40-ad5e306dc3f9.jpg\"/><br/>登录：实现记住密码和自动登录。<br/><br/>当记住密码和自动登录被勾选后，第二次打开软件时可以实现自动登录。<br/><img src=\"http://img.lieyou888.com/000/2022/03/24/f80c7a93-819d-439c-bb0b-d39abe5390ec.jpg\"/><br/><br/>住院登记模块<br/><br/><img src=\"http://img.lieyou888.com/000/2022/03/24/df31ad06-b10d-4c21-85cc-3070b1e6bfbf.jpg\"/><br/>住院中心模块：列出所有住院的病人。<br/><br/>长按病人可以进行出院结算、转科转床、预交金额、项目记账、药品记账、病人管理、药品记账模块的操作<br/><img src=\"http://img.lieyou888.com/000/2022/03/24/b1263c3e-b3db-421b-a01f-4ffa64e7dd13.jpg\"/><br/><img src=\"http://img.lieyou888.com/000/2022/03/24/0bce9440-91f6-4c9e-b845-7ed0cd78a24a.jpg\"/><br/><br/>链接：<a href=\"https://wwn.lanzouw.com/iJ2JE0206zaj\" target=\"_blank\">https://wwn.lanzouw.com/iJ2JE0206zaj</a><br/></p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '', 2, 38, '2022-04-14 10:30:51', 1, 1, '2022-04-20 15:47:37', 0, 1);
INSERT INTO `post` VALUES (33, '【技术交流】怎样实现外部浏览器跳转到APP的指定页面？', '<p>当用户从外部浏览器（如：UC、Safari）点击有关app的按钮时，实现一下功能</p><p><img src=\"http://img.lieyou888.com/000/2022/03/15/b5d3e4b7-ad19-45bc-8cfe-854ebc5455b3.jpg\" width=\"50%\"/></p><p><br/>1、用户未安装app，点击按钮跳转到app的下载页面<br/><br/>2、用户已安装app，点击按钮打开app并显示指定页面（如注册，登录等）<br/><br/>首先我们给app添加一个URL Types，用于给web打开的接口</p><p><img src=\"http://img.lieyou888.com/000/2022/03/15/aae0cdb2-d2f4-49f0-8e9e-305b78038aca.jpg\" width=\"50%\"/></p><p><br/>1、如果用户未安装app，点击按钮跳转到app的下载页面<br/><br/>2、用户已安装app，点击按钮只能打开app<br/><br/>二、实现跳转到app指定页面<br/><br/>在web页面里设置参数，<br/>如果要实现跳转到指定页面，就需要传 参数 表示跳转到哪个页面，只需要在上面的网址里：即 ifr.src = \'com.zttd.webApp//参数\'<br/>例如跳到登录页面：ifr.src = \'com.zttd.webApp//Login\'<br/><br/>在APP里接收该参数，并解析进行跳转，需要在AppDelegate文件里实现以下两种方法，最好两种都写，否则可能接收不到数据，接收到该参数后，进行解析通过通知并跳转到指定页面<br/></p><style>/* table 样式 */\ntable {border-top: 1px solid #ccc;\nborder-left: 1px solid #ccc;\n}\ntable td,\ntable th {\nborder-bottom: 1px solid #ccc;\nborder-right: 1px solid #ccc;\npadding: 3px 5px;\n}\ntable th {border-bottom: 2px solid #ccc;text-align: center;}\n/* blockquote 样式 */\nblockquote {\ndisplay: block;border-left: 8px solid #d0e5f2;padding: 5px 10px;\nmargin: 10px 0;line-height: 1.4;font-size: 100%;background-color: #f1f1f1;}\n/* code 样式 */\ncode {\n  display: inline-block;\n  *display: inline;\n  *zoom: 1;\n  background-color: #f1f1f1;\n  border-radius: 3px;\n  padding: 3px 5px;\n  margin: 0 3px;\n}\npre code {\n  display: block;\n}\n\n/* ul ol 样式 */\nul, ol {\n  margin: 10px 0 10px 20px;\n}\n</style>', '', 2, 33, '2022-04-14 10:46:29', 1, 1, '2022-04-19 16:36:06', 0, 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `role_name`(`role_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (2, 'admin');
INSERT INTO `role` VALUES (3, 'super');
INSERT INTO `role` VALUES (1, 'user');
INSERT INTO `role` VALUES (5, '教师');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `role_id` int(0) NOT NULL COMMENT '角色ID',
  `permission_id` int(0) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `fk_permission`(`permission_id`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (2, 1);
INSERT INTO `role_permission` VALUES (2, 2);
INSERT INTO `role_permission` VALUES (2, 3);
INSERT INTO `role_permission` VALUES (2, 4);
INSERT INTO `role_permission` VALUES (2, 5);
INSERT INTO `role_permission` VALUES (2, 6);
INSERT INTO `role_permission` VALUES (2, 7);
INSERT INTO `role_permission` VALUES (2, 8);
INSERT INTO `role_permission` VALUES (5, 9);
INSERT INTO `role_permission` VALUES (5, 10);
INSERT INTO `role_permission` VALUES (5, 11);
INSERT INTO `role_permission` VALUES (5, 12);
INSERT INTO `role_permission` VALUES (5, 13);
INSERT INTO `role_permission` VALUES (3, 14);
INSERT INTO `role_permission` VALUES (5, 14);
INSERT INTO `role_permission` VALUES (3, 15);
INSERT INTO `role_permission` VALUES (3, 16);
INSERT INTO `role_permission` VALUES (3, 17);
INSERT INTO `role_permission` VALUES (3, 18);
INSERT INTO `role_permission` VALUES (3, 19);
INSERT INTO `role_permission` VALUES (1, 20);
INSERT INTO `role_permission` VALUES (1, 21);
INSERT INTO `role_permission` VALUES (1, 22);
INSERT INTO `role_permission` VALUES (1, 23);
INSERT INTO `role_permission` VALUES (1, 24);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色ID',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `locked` tinyint(1) NOT NULL COMMENT '是否锁定：1（锁定） 0（未锁定）',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'test1', 'ca53a11e83c039ff7acfcb1ab705c7dbbc3bbdd9', '123456@qq.com', NULL, NULL, 1, '男', 0);
INSERT INTO `user` VALUES (2, 'test2', '2467b841d4e5bf8ac015605f074778adbaceb16d', '123456@qq.com', NULL, NULL, 1, '男', 0);
INSERT INTO `user` VALUES (3, 'test3', '29c419f2a3722637f25ba4a74fe4f9eaee1e4b79', '123456@qq.com', '2021-12-01 21:32:03', '2021-12-01 21:32:03', 1, '女', 0);
INSERT INTO `user` VALUES (5, 'test4', 'aa0c34c16914a8a7395e207ee6f9d0cb27315fcf', '123456@qq.com', '2021-12-06 15:53:42', '2021-12-06 15:53:42', 1, '女', 0);
INSERT INTO `user` VALUES (6, 'test5', 'b69ee864bf8c4b7c6868f3aed46bceb7079d0794', '123456@qq.com', '2021-12-07 10:17:02', '2021-12-07 10:17:02', 1, '男', 0);

-- ----------------------------
-- Table structure for wall
-- ----------------------------
DROP TABLE IF EXISTS `wall`;
CREATE TABLE `wall`  (
  `wall_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '墙ID',
  `admin_id` int(0) NULL DEFAULT NULL COMMENT '审核人ID',
  `wall_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '墙内容',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `comment_num` int(0) NULL DEFAULT NULL COMMENT '评论数量',
  `like_num` int(0) NULL DEFAULT NULL COMMENT '点赞数量',
  `audit_state` tinyint(0) NULL DEFAULT NULL COMMENT '审核状态：0-待审 1-审核通过 2-未通过',
  `audit_failed_cause` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核不过原因',
  `audit_time` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '申请人ID',
  `wall_images` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '墙图片',
  PRIMARY KEY (`wall_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wall
-- ----------------------------
INSERT INTO `wall` VALUES (1, 5, 'sd1f2ds12', '2021-12-15 22:06:25', 0, 0, 2, '内容无意义', '2022-04-21 15:55:18', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (2, 5, '想陪你走过春夏秋冬，想陪你走过风霜雨雪，想陪你走过未来的每一天。因为少一天，都不叫余生。', '2021-12-15 22:10:28', 0, 0, 1, NULL, '2022-04-21 15:51:53', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (4, 2, '蓝牙耳机在篮球场弄丢了呜呜呜呜', '2021-12-15 23:17:30', 0, 0, 1, '违规了0', '2021-12-15 23:21:13', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (5, 2, '找一下饭卡', '2021-12-16 14:56:19', 0, 0, 1, NULL, '2021-12-16 14:59:45', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (6, 2, '找u盘', '2021-12-16 14:57:55', 0, 0, 1, NULL, '2021-12-16 14:59:53', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (7, 2, '哪有什么春夏秋冬，遇见你就是四季如春。', '2021-12-16 14:58:09', 0, 0, 1, NULL, '2021-12-16 14:59:58', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (8, 2, '这位男生好帅啊！', '2021-12-16 14:58:15', 0, 0, 1, NULL, '2021-12-16 15:00:02', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (9, 2, '今天下午在图书馆一楼擦肩而过的女生，想知道她的联系方式！', '2021-12-16 14:58:21', 0, 0, 1, NULL, '2021-12-16 15:00:06', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (10, 2, '你的过去我没参与，你的未来我不会错过。春夏秋冬经过四季，情深而已，甘愿为你一人沉溺。\r\n\r\n我想，陪你走过春夏秋冬；也愿，和你共度艰难伤痛；更盼，伴你前行相濡与共；但求，初心不改我心你懂。\r\n\r\n有你的存在，我才能在柴米油盐的安然里，过好每一个春夏秋冬。', '2021-12-16 14:58:28', 0, 0, 2, '描述不清晰', '2021-12-16 15:22:58', 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (11, 5, '测试测试测试测试测试测试！！！！！', '2022-04-17 17:58:56', 0, 0, 1, NULL, '2022-04-21 16:19:46', 1, '1650189482266_1515630656682590208.jpeg,1650189485301_1515630669416497152.jpeg,1650189488449_1515630682615971840.jpeg');
INSERT INTO `wall` VALUES (12, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:34', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (13, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:42', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (14, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:43', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (15, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:43', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (16, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:43', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (17, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:43', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (18, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:45', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (19, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:45', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (20, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:49', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (21, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:49', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');
INSERT INTO `wall` VALUES (22, NULL, '哪有什么春夏秋冬，遇见你就是四季如春！！！！！！', '2022-04-17 18:07:49', 0, 0, 0, NULL, NULL, 1, '1650190009635_1515632868632690688.jpeg,1650190013496_1515632884822704128.jpeg,1650190016511_1515632897468530688.jpeg');

SET FOREIGN_KEY_CHECKS = 1;
