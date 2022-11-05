/*
 Navicat Premium Data Transfer

 Source Server         : servermysql
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : 47.98.177.86:3306
 Source Schema         : sg_blog

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 31/10/2022 13:01:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sg_article
-- ----------------------------
DROP TABLE IF EXISTS `sg_article`;
CREATE TABLE `sg_article`  (
  `id` bigint(200) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文章内容',
  `summary` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章摘要',
  `category_id` bigint(20) NULL DEFAULT NULL COMMENT '所属分类id',
  `thumbnail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `is_top` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否置顶（0否，1是）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '状态（0已发布，1草稿）',
  `view_count` bigint(200) NULL DEFAULT 0 COMMENT '访问量',
  `is_comment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否允许评论 1是，0否',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `likes_count` int(11) NULL DEFAULT NULL COMMENT '点赞数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_article
-- ----------------------------
INSERT INTO `sg_article` VALUES (1, 'SpringSecurity从入门到精通', '## 课程介绍\n![image20211219121555979.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/e7131718e9e64faeaf3fe16404186eb4.png)\n\n## 0. 简介1\n\n​	**Spring Security** 是 Spring 家族中的一个安全管理框架。相比与另外一个安全框架**Shiro**，它提供了更丰富的功能，社区资源也比Shiro丰富。\n\n​	一般来说中大型的项目都是使用**SpringSecurity** 来做安全框架。小项目有Shiro的比较多，因为相比与SpringSecurity，Shiro的上手更加的简单。\n\n​	 一般Web应用的需要进行**认证**和**授权**。\n\n​		**认证：验证当前访问系统的是不是本系统的用户，并且要确认具体是哪个用户**\n\n​		**授权：经过认证后判断当前用户是否有权限进行某个操作**\n\n​	而认证和授权也是SpringSecurity作为安全框架的核心功能。\n\n\n\n## 1. 快速入门\n\n### 1.1 准备工作\n\n​	我们先要搭建一个简单的SpringBoot工程\n\n① 设置父工程 添加依赖\n\n~~~~\n    <parent>\n        <groupId>org.springframework.boot</groupId>\n        <artifactId>spring-boot-starter-parent</artifactId>\n        <version>2.5.0</version>\n    </parent>\n    <dependencies>\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-web</artifactId>\n        </dependency>\n        <dependency>\n            <groupId>org.projectlombok</groupId>\n            <artifactId>lombok</artifactId>\n            <optional>true</optional>\n        </dependency>\n    </dependencies>\n~~~~\n\n② 创建启动类\n\n~~~~\n@SpringBootApplication\npublic class SecurityApplication {\n\n    public static void main(String[] args) {\n        SpringApplication.run(SecurityApplication.class,args);\n    }\n}\n\n~~~~\n\n③ 创建Controller\n\n~~~~java\n\nimport org.springframework.web.bind.annotation.RequestMapping;\nimport org.springframework.web.bind.annotation.RestController;\n\n@RestController\npublic class HelloController {\n\n    @RequestMapping(\"/hello\")\n    public String hello(){\n        return \"hello\";\n    }\n}\n\n~~~~\n\n\n\n### 1.2 引入SpringSecurity\n\n​	在SpringBoot项目中使用SpringSecurity我们只需要引入依赖即可实现入门案例。\n\n~~~~xml\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-security</artifactId>\n        </dependency>\n~~~~\n\n​	引入依赖后我们在尝试去访问之前的接口就会自动跳转到一个SpringSecurity的默认登陆页面，默认用户名是user,密码会输出在控制台。\n\n​	必须登陆之后才能对接口进行访问。\n\n\n\n## 2. 认证\n\n### 2.1 登陆校验流程\n![image20211215094003288.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/414a87eeed344828b5b00ffa80178958.png)', 'SpringSecurity框架教程-Spring Security+JWT实现项目级前端分离认证授权', 1, 'https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/31/948597e164614902ab1662ba8452e106.png', '1', '0', 19, '0', 1, '2022-01-23 23:20:11', NULL, NULL, 0, 0);
INSERT INTO `sg_article` VALUES (5, '测试1', '![Snipaste_20220115_165812.png](https://sg-blog-oss.oss-cn-beijing.aliyuncs.com/2022/01/15/1d9d283f5d874b468078b183e4b98b71.png)\n\n## sda \n\n222\n### sdasd newnewnew\n\n```java\n    @PostMapping(\"insertArticle\")\n    public R insertArticle(@RequestBody ArticleDetailDto articleDetailDto){\n        return articleService.insertArticle(articleDetailDto);\n    }\n\n```\n\n![离散作业.png](http://rix8td9b0.bkt.clouddn.com/2022/10/08/5541877c1b574953a9eab2bb72009273.png)\n\n', '测试文章摘要', 1, 'http://rix8td9b0.bkt.clouddn.com/2022/10/08/8f7e1230c1e74c80b7c0ec6378380ae6.jpg', '1', '1', 1, '1', 1, '2022-01-17 14:58:37', NULL, NULL, 0, 0);
INSERT INTO `sg_article` VALUES (8, '测试2', '# 测试添加操作\n\n![head.jpeg](http://rix8td9b0.bkt.clouddn.com/2022/10/08/2c0e9b4ffd3c45f182a8278c2d8186cb.jpeg)', '测试添加操作', 2, 'http://rix8td9b0.bkt.clouddn.com/2022/10/08/3a994e8a6180495685d46f165ed7fb56.jpg', '0', '1', 0, '1', 1, '2022-01-17 14:58:37', NULL, NULL, 0, 0);
INSERT INTO `sg_article` VALUES (9, '测试3', '\n\n```\ndeclare module \'*.vue\' {\n    import type { DefineComponent } from \'vue\'\n    // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/ban-types\n    const component: DefineComponent<{}, {}, any>\n    export default component\n  }', '摘要怎么', 1, 'http://rix8td9b0.bkt.clouddn.com/2022/10/08/e0621ea371ff4fae88a9c12e0a3f0297.jpg', '0', '0', 0, '1', 1, '2022-10-23 17:33:16', NULL, NULL, 0, 0);
INSERT INTO `sg_article` VALUES (10, '123123', '31231231', '31231231', 1, 'http://rix8td9b0.bkt.clouddn.com/2022/10/09/1b1d07a31c9e4897b3510811fc888fe1.jpeg', '0', '0', 0, '1', 1, '2022-10-09 16:23:00', 1, '2022-10-09 16:23:00', 0, 0);
INSERT INTO `sg_article` VALUES (11, '普通用户', '啊实打实', 'yfdl', 1, 'http://rix8td9b0.bkt.clouddn.com/2022/10/09/cd577e760be84f02a8a0eb9795a50b94.jpeg', '0', '0', 0, '1', 3, '2022-10-09 17:18:43', 3, '2022-10-09 17:18:43', 0, 0);
INSERT INTO `sg_article` VALUES (12, '听雨轩', '# 听雨轩创建', '听雨轩创建', 1, 'http://rix8td9b0.bkt.clouddn.com/2022/10/09/4de70f606c484cf7b0300b0c191b2fab.jpeg', '0', '0', 0, '1', 4, '2022-10-09 17:22:14', NULL, '2022-10-09 17:24:47', 0, 0);
INSERT INTO `sg_article` VALUES (13, '测试图片', '测试图片', '123123432', 1, 'http://img.yfdl.site/2022/10/23/2b2a9a602ad5407d806215c96be67685.png', '0', '1', 0, '1', 1, '2022-10-23 17:33:16', 1, '2022-10-23 17:33:16', 0, 0);

-- ----------------------------
-- Table structure for sg_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `sg_article_tag`;
CREATE TABLE `sg_article_tag`  (
  `article_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `tag_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '标签id',
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章标签关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_article_tag
-- ----------------------------
INSERT INTO `sg_article_tag` VALUES (1, 4);
INSERT INTO `sg_article_tag` VALUES (5, 1);
INSERT INTO `sg_article_tag` VALUES (5, 4);
INSERT INTO `sg_article_tag` VALUES (5, 5);
INSERT INTO `sg_article_tag` VALUES (9, 1);
INSERT INTO `sg_article_tag` VALUES (9, 4);
INSERT INTO `sg_article_tag` VALUES (12, 1);
INSERT INTO `sg_article_tag` VALUES (12, 4);
INSERT INTO `sg_article_tag` VALUES (12, 5);
INSERT INTO `sg_article_tag` VALUES (16, 4);
INSERT INTO `sg_article_tag` VALUES (17, 1);
INSERT INTO `sg_article_tag` VALUES (18, 1);
INSERT INTO `sg_article_tag` VALUES (19, 4);
INSERT INTO `sg_article_tag` VALUES (20, 1);

-- ----------------------------
-- Table structure for sg_category
-- ----------------------------
DROP TABLE IF EXISTS `sg_category`;
CREATE TABLE `sg_category`  (
  `id` bigint(200) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `pid` bigint(200) NULL DEFAULT -1 COMMENT '父分类id，如果没有父分类为-1',
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态0:正常,1禁用',
  `create_by` bigint(200) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(200) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_category
-- ----------------------------
INSERT INTO `sg_category` VALUES (1, 'java', -1, 'wsd', '0', NULL, NULL, NULL, '2022-10-23 23:36:50', 0);
INSERT INTO `sg_category` VALUES (2, 'PHP', -1, 'wsd', '0', NULL, NULL, NULL, NULL, 0);
INSERT INTO `sg_category` VALUES (3, 'javaScript', -1, 'wsd', '0', NULL, NULL, NULL, '2022-10-23 23:36:10', 0);
INSERT INTO `sg_category` VALUES (17, '测绘师1', -1, '好的', '0', 1, '2022-10-23 23:30:18', NULL, '2022-10-23 23:30:26', 1);

-- ----------------------------
-- Table structure for sg_comment
-- ----------------------------
DROP TABLE IF EXISTS `sg_comment`;
CREATE TABLE `sg_comment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '评论类型（0代表文章评论，1代表友链评论）',
  `article_id` bigint(20) NULL DEFAULT NULL COMMENT '文章id',
  `root_id` bigint(20) NULL DEFAULT -1 COMMENT '根评论id',
  `content` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `to_comment_user_id` bigint(20) NULL DEFAULT -1 COMMENT '所回复的目标评论的userid',
  `to_comment_id` bigint(20) NULL DEFAULT -1 COMMENT '回复目标评论id',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `likes_count` int(11) NULL DEFAULT NULL COMMENT '点赞数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_comment
-- ----------------------------

-- ----------------------------
-- Table structure for sg_link
-- ----------------------------
DROP TABLE IF EXISTS `sg_link`;
CREATE TABLE `sg_link`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `logo` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '2' COMMENT '审核状态 (0代表审核通过，1代表审核未通过，2代表未审核)',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友链' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_link
-- ----------------------------
INSERT INTO `sg_link` VALUES (1, 'sda', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F05%2F10%2F146286696706220328.PNG&refer=http%3A%2F%2Fn1.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646205529&t=f942665181eb9b0685db7a6f59d59975', 'sda', 'https://www.baidu.com', '0', NULL, '2022-01-13 08:25:47', NULL, '2022-01-13 08:36:14', 0);
INSERT INTO `sg_link` VALUES (2, 'sda', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F05%2F10%2F146286696706220328.PNG&refer=http%3A%2F%2Fn1.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646205529&t=f942665181eb9b0685db7a6f59d59975', 'dada', 'https://www.qq.com', '1', NULL, '2022-01-13 09:06:10', NULL, '2022-01-13 09:07:09', 0);
INSERT INTO `sg_link` VALUES (3, 'sa', 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F05%2F10%2F146286696706220328.PNG&refer=http%3A%2F%2Fn1.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646205529&t=f942665181eb9b0685db7a6f59d59975', 'da', 'https://www.taobao.com', '1', NULL, '2022-01-13 09:23:01', NULL, '2022-01-13 09:23:01', 0);

-- ----------------------------
-- Table structure for sg_tag
-- ----------------------------
DROP TABLE IF EXISTS `sg_tag`;
CREATE TABLE `sg_tag`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `create_by` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` bigint(20) NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '标签' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sg_tag
-- ----------------------------
INSERT INTO `sg_tag` VALUES (1, 'Mybatis', NULL, NULL, NULL, '2022-10-24 15:25:59', 0, 'weqwe');
INSERT INTO `sg_tag` VALUES (2, 'asdas', NULL, '2022-01-11 09:20:55', NULL, '2022-01-11 09:20:55', 1, 'weqw');
INSERT INTO `sg_tag` VALUES (3, 'weqw', NULL, '2022-01-11 09:21:07', NULL, '2022-01-11 09:21:07', 1, 'qweqwe');
INSERT INTO `sg_tag` VALUES (4, 'Java', NULL, '2022-01-13 15:22:43', NULL, '2022-10-24 15:25:59', 0, 'sdad');
INSERT INTO `sg_tag` VALUES (5, 'WAD', NULL, '2022-01-13 15:22:47', NULL, '2022-10-24 15:25:59', 0, 'ASDAD');
INSERT INTO `sg_tag` VALUES (6, '前端', 1, '2022-10-24 15:26:46', NULL, '2022-10-24 15:27:30', 0, '测试');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `name` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由name',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2043 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, 1, 'M', '0', '0', '', 'system', 0, '2021-11-12 10:46:19', NULL, '2022-10-12 21:28:42', '系统管理目录', '0', NULL);
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'main/system/user.vue', 1, 'C', '0', '0', 'system:user:list', 'user', 0, '2021-11-12 10:46:19', NULL, '2022-10-13 22:54:09', '用户管理菜单', '0', 'user');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'main/system/role.vue', 1, 'C', '0', '0', 'system:role:list', 'peoples', 0, '2021-11-12 10:46:19', NULL, '2022-10-13 19:45:28', '角色管理菜单', '0', 'role');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'main/system/menu.vue', 1, 'C', '0', '0', 'system:menu:list', 'tree-table', 0, '2021-11-12 10:46:19', NULL, '2022-10-13 00:10:47', '菜单管理菜单', '0', 'menu');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 'F', '0', '0', 'system:user:query', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 'F', '0', '0', 'system:user:add', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 'F', '0', '0', 'system:user:edit', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 'F', '0', '0', 'system:user:remove', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 'F', '0', '0', 'system:user:export', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 'F', '0', '0', 'system:user:import', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 'F', '0', '0', 'system:user:resetPwd', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 'F', '0', '0', 'system:role:query', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 'F', '0', '0', 'system:role:add', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 'F', '0', '0', 'system:role:edit', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 'F', '0', '0', 'system:role:remove', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 'F', '0', '0', 'system:role:export', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 'F', '0', '0', 'system:menu:query', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 'F', '0', '0', 'system:menu:add', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 'F', '0', '0', 'system:menu:edit', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 'F', '0', '0', 'system:menu:remove', '#', 0, '2021-11-12 10:46:19', 0, NULL, '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2017, '内容管理', 0, 4, 'content', NULL, 1, 'M', '0', '1', NULL, 'table', NULL, '2022-01-08 02:44:38', NULL, '2022-10-19 14:20:41', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2018, '分类管理', 2017, 1, 'category', 'content/category/index', 1, 'C', '0', '1', 'content:category:list', 'example', NULL, '2022-01-08 02:51:45', NULL, '2022-10-15 21:58:21', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2019, '文章管理', 2017, 0, 'article', 'content/article/index', 1, 'C', '0', '0', 'content:article:list', 'build', NULL, '2022-01-08 02:53:10', NULL, '2022-10-15 22:09:43', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2021, '标签管理', 2017, 6, 'tag', 'content/tag/index', 1, 'C', '0', '1', 'content:tag:index', 'button', NULL, '2022-01-08 02:55:37', NULL, '2022-10-15 21:58:27', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2022, '友链管理', 2017, 4, 'link', 'content/link/index', 1, 'C', '0', '1', 'content:link:list', '404', NULL, '2022-01-08 02:56:50', NULL, '2022-10-15 21:58:16', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2023, '写博文', 0, 1, '', 'content/article/write/index', 1, 'C', '0', '0', 'content:article:writer', 'build', NULL, '2022-01-08 03:39:58', NULL, '2022-10-12 21:39:01', '', '1', NULL);
INSERT INTO `sys_menu` VALUES (2024, '友链新增', 2022, 0, '', NULL, 1, 'F', '0', '0', 'content:link:add', '#', NULL, '2022-01-16 07:59:17', NULL, '2022-01-16 07:59:17', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2025, '友链修改', 2022, 1, '', NULL, 1, 'F', '0', '0', 'content:link:edit', '#', NULL, '2022-01-16 07:59:44', NULL, '2022-01-16 07:59:44', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2026, '友链删除', 2022, 1, '', NULL, 1, 'F', '0', '0', 'content:link:remove', '#', NULL, '2022-01-16 08:00:05', NULL, '2022-01-16 08:00:05', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2027, '友链查询', 2022, 2, '', NULL, 1, 'F', '0', '0', 'content:link:query', '#', NULL, '2022-01-16 08:04:09', NULL, '2022-01-16 08:04:09', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2028, '导出分类', 2018, 1, '', NULL, 1, 'F', '0', '0', 'content:category:export', '#', NULL, '2022-01-21 07:06:59', NULL, '2022-01-21 07:06:59', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2034, '仪表盘', 0, 0, 'panel', 'main/panel/index.vue', 1, 'C', '0', '0', 'panel:list', 'example', 1, '2022-10-12 13:50:47', NULL, '2022-10-12 20:25:17', '', '0', 'panel');
INSERT INTO `sys_menu` VALUES (2035, '内容管理', 0, 1, 'article', NULL, 1, 'M', '0', '0', NULL, 'edit', 1, '2022-10-12 21:09:55', NULL, '2022-10-13 17:33:55', '', '0', NULL);
INSERT INTO `sys_menu` VALUES (2036, '所有文章', 2035, 1, 'allArticle', 'main/articleManage/allArticleView.vue', 1, 'C', '0', '0', 'article:allArticle:list', 'excel', 1, '2022-10-12 21:14:00', NULL, '2022-10-13 00:09:47', '', '0', 'allArticle');
INSERT INTO `sys_menu` VALUES (2037, '写文章', 2035, 2, 'write', 'main/articleManage/writeView.vue', 1, 'C', '0', '0', 'article:write:list', 'form', 1, '2022-10-12 21:19:42', NULL, '2022-10-13 00:09:55', '', '0', 'write');
INSERT INTO `sys_menu` VALUES (2038, '分类', 2035, 3, 'category', 'main/articleManage/category.vue', 1, 'C', '0', '0', 'article:category:list', 'cascader', 1, '2022-10-12 21:21:28', NULL, '2022-10-13 00:10:04', '', '1', 'category');
INSERT INTO `sys_menu` VALUES (2039, '标签', 2035, 4, 'span', 'main/articleManage/span.vue', 1, 'C', '0', '0', 'article:span:list', '24gf-tags3', 1, '2022-10-12 21:25:39', NULL, '2022-10-13 00:22:59', '', '0', 'span');
INSERT INTO `sys_menu` VALUES (2040, '个人资料', 0, 9, '/userinfo', 'main/userManage/userInfo.vue', 1, 'C', '0', '0', 'userinfo:list', 'logininfor', 1, '2022-10-12 21:34:57', NULL, '2022-10-15 22:20:03', '', '0', 'userinfo');
INSERT INTO `sys_menu` VALUES (2041, '文章管理', 1, 5, 'articleManage', 'main/system/articleManage.vue', 1, 'C', '0', '0', 'system:articleMange:list', 'edit', 1, '2022-10-23 16:43:28', NULL, '2022-10-23 16:44:41', '', '0', 'articleManage');
INSERT INTO `sys_menu` VALUES (2042, '分类管理', 1, 6, 'category', 'main/system/category.vue', 1, 'C', '0', '0', 'system:category:list', 'cascader', 1, '2022-10-23 17:37:14', 1, '2022-10-23 17:37:14', '', '0', 'category');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'superAdmin', 1, '0', '0', 0, '2021-11-12 10:46:19', NULL, '2022-10-23 20:48:46', '超级管理员');
INSERT INTO `sys_role` VALUES (2, '管理员', 'admin', 2, '0', '0', 0, '2021-11-12 10:46:19', NULL, '2022-10-23 20:47:57', '管理员');
INSERT INTO `sys_role` VALUES (3, '普通会员', 'common', 5, '0', '0', 0, '2022-01-06 14:07:40', NULL, '2022-10-19 14:13:08', '普通用户');
INSERT INTO `sys_role` VALUES (12, '友链审核员', 'link', 6, '0', '1', NULL, '2022-01-16 06:49:30', NULL, '2022-10-19 11:19:34', NULL);
INSERT INTO `sys_role` VALUES (13, '角色测试', 'test', 7, '0', '1', 1, '2022-10-19 11:10:08', 1, '2022-10-19 11:10:08', 'test');
INSERT INTO `sys_role` VALUES (16, 'test', 'test:list', 8, '0', '0', 1, '2022-10-19 13:12:36', NULL, '2022-10-19 15:29:13', '测试');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);
INSERT INTO `sys_role_menu` VALUES (1, 100);
INSERT INTO `sys_role_menu` VALUES (1, 101);
INSERT INTO `sys_role_menu` VALUES (1, 102);
INSERT INTO `sys_role_menu` VALUES (1, 2017);
INSERT INTO `sys_role_menu` VALUES (1, 2018);
INSERT INTO `sys_role_menu` VALUES (1, 2019);
INSERT INTO `sys_role_menu` VALUES (1, 2021);
INSERT INTO `sys_role_menu` VALUES (1, 2022);
INSERT INTO `sys_role_menu` VALUES (1, 2034);
INSERT INTO `sys_role_menu` VALUES (1, 2035);
INSERT INTO `sys_role_menu` VALUES (1, 2036);
INSERT INTO `sys_role_menu` VALUES (1, 2037);
INSERT INTO `sys_role_menu` VALUES (1, 2039);
INSERT INTO `sys_role_menu` VALUES (1, 2040);
INSERT INTO `sys_role_menu` VALUES (1, 2041);
INSERT INTO `sys_role_menu` VALUES (1, 2042);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 2034);
INSERT INTO `sys_role_menu` VALUES (2, 2035);
INSERT INTO `sys_role_menu` VALUES (2, 2036);
INSERT INTO `sys_role_menu` VALUES (2, 2037);
INSERT INTO `sys_role_menu` VALUES (2, 2039);
INSERT INTO `sys_role_menu` VALUES (2, 2040);
INSERT INTO `sys_role_menu` VALUES (2, 2041);
INSERT INTO `sys_role_menu` VALUES (2, 2042);
INSERT INTO `sys_role_menu` VALUES (3, 2034);
INSERT INTO `sys_role_menu` VALUES (3, 2035);
INSERT INTO `sys_role_menu` VALUES (3, 2036);
INSERT INTO `sys_role_menu` VALUES (3, 2037);
INSERT INTO `sys_role_menu` VALUES (3, 2039);
INSERT INTO `sys_role_menu` VALUES (3, 2040);
INSERT INTO `sys_role_menu` VALUES (16, 2034);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '用户名',
  `nick_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '昵称',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NULL' COMMENT '密码',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户类型：0代表普通用户，1代表管理员',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phonenumber` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户性别（0男，1女，2未知）',
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `create_by` bigint(20) NULL DEFAULT NULL COMMENT '创建人的用户id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(20) NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(11) NULL DEFAULT 0 COMMENT '删除标志（0代表未删除，1代表已删除）',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人标签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '远方的鹿', '$2a$10$5ySUlYWz24i6/t5Wa1VHveuZPLHEGrgU.Nefr4j2MYioH2Cuj8yoG', '1', '0', '1940203983@qq.com', '18888888888', '0', 'http://rix8td9b0.bkt.clouddn.com/2022/09/30/fda85e9252454066a1a7832d374579dc.png', NULL, '2022-01-05 09:01:56', 1, '2022-01-30 15:37:03', 0, '有人活着，是为了完成前世未了的故事。有人活着，是为了过尽细水长流的日子。有人活在过去，有人活在将来，被忽略的，总是今天。');
INSERT INTO `sys_user` VALUES (2, 'user', 'user', '$2a$10$ydv3rLkteFnRx9xelQ7elOiVhFvXOooA98xCqk/omh7G94R.K/E3O', '1', '0', '2142342345235', '43241234', '0', NULL, NULL, '2022-01-05 13:28:43', NULL, '2022-10-23 17:42:57', 0, NULL);
INSERT INTO `sys_user` VALUES (3, 'yfdl', 'yfdl', '$2a$10$Jnq31rRkNV3RNzXe0REsEOSKaYK8UgVZZqlNlNXqn.JeVcj2NdeZy', '0', '0', '1940203983@qq.com', '17777777777', '1', NULL, NULL, '2022-01-16 06:54:26', NULL, '2022-10-22 17:08:40', 0, 'dsada');
INSERT INTO `sys_user` VALUES (4, 'tyx', 'tyx', '$2a$10$5ySUlYWz24i6/t5Wa1VHveuZPLHEGrgU.Nefr4j2MYioH2Cuj8yoG', '0', '0', '123456789', '1232423423', '0', NULL, NULL, NULL, NULL, '2022-10-23 16:35:56', 0, NULL);
INSERT INTO `sys_user` VALUES (5, 'test1', 'test', '$2a$10$KrBB17aRF.LYwOqbSpyH/e1Ou/uRDDe25KUp.8pnfSpoFK3fh0Gfy', '0', '0', '123543', '1234345', '0', NULL, 1, '2022-10-23 21:37:51', 1, '2022-10-23 21:37:51', 0, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (4, 3);
INSERT INTO `sys_user_role` VALUES (14787164048672, 16);
INSERT INTO `sys_user_role` VALUES (14787164048673, 1);
INSERT INTO `sys_user_role` VALUES (14787164048674, 1);
INSERT INTO `sys_user_role` VALUES (14787164048675, 16);
INSERT INTO `sys_user_role` VALUES (14787164048676, 16);
INSERT INTO `sys_user_role` VALUES (14787164048677, 2);
INSERT INTO `sys_user_role` VALUES (14787164048678, 2);
INSERT INTO `sys_user_role` VALUES (14787164048679, 16);
INSERT INTO `sys_user_role` VALUES (14787164048680, 2);
INSERT INTO `sys_user_role` VALUES (14787164048681, 3);
INSERT INTO `sys_user_role` VALUES (14787164048682, 16);

SET FOREIGN_KEY_CHECKS = 1;
