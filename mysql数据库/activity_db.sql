/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : activity_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-02-04 00:40:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_activityinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_activityinfo`;
CREATE TABLE `t_activityinfo` (
  `activityId` int(11) NOT NULL auto_increment COMMENT '活动id',
  `activityTitle` varchar(100) NOT NULL COMMENT '活动标题',
  `activityContent` varchar(2000) NOT NULL COMMENT '活动内容',
  `activityPhoto` varchar(60) NOT NULL COMMENT '活动图片',
  `pubTime` varchar(20) default NULL COMMENT '发布时间',
  `endTime` varchar(20) default NULL COMMENT '活动截止时间',
  PRIMARY KEY  (`activityId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_activityinfo
-- ----------------------------
INSERT INTO `t_activityinfo` VALUES ('1', '公司组织一个小型会议', '公司的员工到附件一个写字楼办公室开会', 'upload/5776ad78-ead9-46f5-a811-4052352b0088.jpg', '2017-11-05 23:07:20', '2017-11-30 15:00:00');
INSERT INTO `t_activityinfo` VALUES ('2', '圣诞节公司运动节', '纪念公司成立8周年，开展一系列运动项目，锻炼大家的身体素质！', 'upload/3131669d-4b68-4638-aba7-2470e86f510c.jpg', '2017-11-08 17:47:44', '2017-12-28 17:47:47');
INSERT INTO `t_activityinfo` VALUES ('4', '双十二公司大庆祝活动', '公司双十二和5周年庆祝活动', 'upload/4d97b4d1-9fcf-45b8-b64c-d7db804d7f6e.jpg', '2017-11-16 15:58:34', '2017-12-13 14:58:35');

-- ----------------------------
-- Table structure for `t_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_task`;
CREATE TABLE `t_task` (
  `taskId` int(11) NOT NULL auto_increment COMMENT '任务id',
  `workObj` int(11) NOT NULL COMMENT '所属工作',
  `title` varchar(20) NOT NULL COMMENT '任务标题',
  `taskContent` varchar(2000) NOT NULL COMMENT '任务内容',
  `pubTime` varchar(20) default NULL COMMENT '发布时间',
  `taskState` varchar(20) NOT NULL COMMENT '任务状态',
  `endTime` varchar(20) default NULL COMMENT '任务截止时间',
  `takeUser` varchar(20) NOT NULL COMMENT '接手用户',
  `workRecord` varchar(2000) default NULL COMMENT '工作日志记录',
  PRIMARY KEY  (`taskId`),
  KEY `workObj` (`workObj`),
  CONSTRAINT `t_task_ibfk_1` FOREIGN KEY (`workObj`) REFERENCES `t_activityinfo` (`activityId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_task
-- ----------------------------
INSERT INTO `t_task` VALUES ('1', '1', '预定一个会议室', '公司人员太多需要找一个安静的会议室', '2017-11-06 23:32:01', '进行中', '2017-11-08 23:32:14', 'user1', '正在联系！！！');
INSERT INTO `t_task` VALUES ('2', '1', '找一个大宾馆5个房间以上', '公司开会的人比较多，需要尽快预定好宾馆住宿！', '2017-11-06 05:13:25', '进行中', '2017-11-17 09:09:33', 'user1', '--');
INSERT INTO `t_task` VALUES ('3', '1', '买摄像机录像器材', '会议过程需要专业的摄像师用专业的设备录制，以后好总结！', '2017-11-08 09:09:08', '进行中', '2017-11-23 09:13:08', 'user2', '--');
INSERT INTO `t_task` VALUES ('6', '4', '找一个大型活动现场', '公司人数很多，谁去找一个活动现场地点', '2017-11-16 15:59:20', '已完成', '2017-11-22 12:33:21', 'user3', '我刚才找到了一个大型活动现场，可以在红星路13号举办！');
INSERT INTO `t_task` VALUES ('7', '4', '预约当日时间段任务', '地点找到了，谁去找对方负责人预约下12日当天的时间段', '2017-11-16 16:02:09', '进行中', '2017-11-24 09:22:20', 'user1', '正在和对方负责人洽谈');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(20) NOT NULL COMMENT 'user_name',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(20) NOT NULL COMMENT '性别',
  `birthday` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) default NULL COMMENT '联系电话',
  `userMemo` varchar(500) default NULL COMMENT '个人说明',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '双鱼林', '男', '2017-11-01', 'upload/50bb4b13-ac7c-4117-bfe8-8563f3bd7857.jpg', '13539432593', '我是大神');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '毛小英', '女', '2017-11-09', 'upload/a3fb3511-c49b-4e35-aa60-ef57e45c8b74.jpg', '13539839343', '我是小员工');
INSERT INTO `t_userinfo` VALUES ('user3', '123', '李霞', '女', '2017-11-10', 'upload/67891c63-a3a7-450e-b2a1-4c737f90e2f5.jpg', '15129893233', '我是用户3aaaaa啊发发');
