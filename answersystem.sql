/*
Navicat MySQL Data Transfer

Source Server         : zhong
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : answersystem

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-08-01 15:50:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admininfo
-- ----------------------------
DROP TABLE IF EXISTS `admininfo`;
CREATE TABLE `admininfo` (
  `adminid` int(11) NOT NULL auto_increment,
  `adminname` varchar(255) NOT NULL,
  `adminpassword` varchar(255) NOT NULL,
  PRIMARY KEY  (`adminid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admininfo
-- ----------------------------
INSERT INTO `admininfo` VALUES ('1', 'qkhh', 'qkhh');

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `answerid` int(11) NOT NULL auto_increment,
  `answertitle` varchar(255) NOT NULL,
  `answerdetail` longtext NOT NULL,
  `answerstate` varchar(20) NOT NULL default 'no',
  PRIMARY KEY  (`answerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of answer
-- ----------------------------
INSERT INTO `answer` VALUES ('3', '天猫规则与客服规则', '这里是描述说明，写什么都可以，，，', 'on');
INSERT INTO `answer` VALUES ('4', 'aaddd', 'dfgdg', 'on');

-- ----------------------------
-- Table structure for probleminfo
-- ----------------------------
DROP TABLE IF EXISTS `probleminfo`;
CREATE TABLE `probleminfo` (
  `problemid` int(11) NOT NULL auto_increment,
  `ptitle` longtext NOT NULL,
  `pa` longtext NOT NULL,
  `pb` longtext NOT NULL,
  `pc` longtext NOT NULL,
  `pd` longtext NOT NULL,
  `pkey` varchar(20) NOT NULL,
  `pscore` int(11) NOT NULL,
  `ptype` varchar(20) NOT NULL,
  `pcreatetime` varchar(20) NOT NULL,
  `answerid` int(11) NOT NULL,
  PRIMARY KEY  (`problemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of probleminfo
-- ----------------------------
INSERT INTO `probleminfo` VALUES ('5', '天猫规则有哪些', '支持七天无理由退换货', '配送安装显示7楼以下免费搬楼含7楼', '持定制的产品无理由退换货', '7楼以下免费搬楼，可以走楼梯通道，可以吊楼', 'B', '5', 'single', '2019-07-15 18:52:24', '3');
INSERT INTO `probleminfo` VALUES ('6', '店铺规则有哪些', '支持15天无理由退换货', '支持定制产品无理由退换货', '支持7天无理由退换货', '定制产品质量问题支持退换货', 'D', '5', 'single', '2019-07-15 18:53:32', '3');
INSERT INTO `probleminfo` VALUES ('7', '客服规则定义关注退款售后管理相关责任主要关于', '客户体验快速退款服务体验', '给店铺5分指数退款时长速度快，效率高', '自动退款/退全款', '为了给客服营造多点工作做', 'BCD', '8', 'multiple', '2019-07-15 18:54:35', '3');
INSERT INTO `probleminfo` VALUES ('8', '客服规则定义关注评价管理出发点在于', '有差评了找客户对骂差评，客户不合理，乱来', '差评了及时联系客户查找原因，与客户协商删除差评图片或追加回好评', '看到后不用管，差评就是差评了', '查客户差评原因后，自己解决不了，必要时转接给售后或部门负责人', 'BD', '8', 'multiple', '2019-07-15 18:55:45', '3');
INSERT INTO `probleminfo` VALUES ('9', '回复客户时间不得超过3分钟定义是（   ）', '支持七天无理由退换货', '变态规定，不合常理', '支持定制的产品无理由退换货', '7楼以下免费搬楼，可以走楼梯通道，可以吊楼', 'A', '32', 'single', '2019-07-16 15:54:35', '4');
INSERT INTO `probleminfo` VALUES ('10', '天猫规则有哪些（   ）', '支持七天无理由退换货', '配送安装显示7楼以下免费搬楼含7楼', '支持定制的产品无理由退换货', '人有三急最少要10分钟以上空间', 'AC', '23', 'multiple', '2019-07-16 15:55:27', '4');
INSERT INTO `probleminfo` VALUES ('11', '下列哪项违反公司纪律', '玩手机', '聊QQ', '浏览与工作无关的网页和视频', '接待不过来时将旺旺挂起', 'A', '324', 'single', '2019-07-16 19:13:17', '4');

-- ----------------------------
-- Table structure for problempanduan
-- ----------------------------
DROP TABLE IF EXISTS `problempanduan`;
CREATE TABLE `problempanduan` (
  `problempanduanid` int(11) NOT NULL auto_increment,
  `ppcontent` longtext NOT NULL,
  `ppkey` varchar(255) NOT NULL,
  `ppscore` int(11) NOT NULL,
  `pcreatetime` varchar(255) NOT NULL,
  `answerid` varchar(255) NOT NULL,
  PRIMARY KEY  (`problempanduanid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problempanduan
-- ----------------------------
INSERT INTO `problempanduan` VALUES ('2', '天猫支持15天无理由退换货。', 'yes', '5', '2019-07-15 19:00:54', '3');
INSERT INTO `problempanduan` VALUES ('3', '天猫支持信用卡分期付款。', 'no', '5', '2019-07-15 19:01:09', '3');
INSERT INTO `problempanduan` VALUES ('5', 'ewq', 'no', '21', '2019-07-16 15:44:34', '4');

-- ----------------------------
-- Table structure for problemquestinfo
-- ----------------------------
DROP TABLE IF EXISTS `problemquestinfo`;
CREATE TABLE `problemquestinfo` (
  `problemquestid` int(11) NOT NULL auto_increment,
  `pqcontent` longtext NOT NULL,
  `pqkey` longtext NOT NULL,
  `pqscore` int(11) NOT NULL,
  `pqtype` varchar(255) NOT NULL,
  `pcreatetime` varchar(20) NOT NULL,
  `answerid` varchar(20) NOT NULL,
  PRIMARY KEY  (`problemquestid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of problemquestinfo
-- ----------------------------
INSERT INTO `problemquestinfo` VALUES ('7', '1、_______功能沙发定制费用分别是：摇动功能_______；转动功能_______ ；摇转功能          ；有线电动功能_______；无线/USB电动功能_______; ', '7486、755、45、5757、575', '4', 'tiankong', '2019-07-15 18:57:44', '3');
INSERT INTO `problemquestinfo` VALUES ('8', '定制类产品，旺旺聊天必须告知客户：____________________                                         ', '肵得景部 闰表一的', '4', 'tiankong', '2019-07-15 18:58:33', '3');
INSERT INTO `problemquestinfo` VALUES ('9', '定制沙发，有哪些注意事项', '定制定制沙发，有哪些注意事项沙发，有哪些注意事项', '10', 'jianda', '2019-07-15 18:59:06', '3');
INSERT INTO `problemquestinfo` VALUES ('10', '客服每日数据汇总表，登记为询单的标准是怎样的，登记的作用是什么？', '每日数据汇总每日数据汇总表，登记为询单的标准是怎表，登记为询单的标准是怎', '10', 'jianda', '2019-07-15 18:59:21', '3');
INSERT INTO `problemquestinfo` VALUES ('11', '解答客户为什么要问尺寸问题？我们要如何回复', '客户为什客户为什么要问尺寸问题么要问尺寸问题', '10', 'wenda', '2019-07-15 18:59:49', '3');
INSERT INTO `problemquestinfo` VALUES ('12', '如果是你购物，你会讨价吗，不会讨价还价，你需要是什么样的一种服务？', '是你购物，你会讨是你购物，你会讨价吗，不会讨价还价，你需要是价吗，不会讨价还价，你需要是', '10', 'wenda', '2019-07-15 19:00:09', '3');
INSERT INTO `problemquestinfo` VALUES ('13', '请列举，截止到现在，你所认识的公司同事的名字以及职位，对我们工作上的交接作用是对应哪方面？', '现在，你所认现在，你所认识的公司同事的名字以识的公司同事的名字以', '5', 'fujia', '2019-07-15 19:00:27', '3');
INSERT INTO `problemquestinfo` VALUES ('29', '不用白不用hg', '脸上的', '23', 'wenda', '2019-07-15 20:59:27', '4');
INSERT INTO `problemquestinfo` VALUES ('35', 'w', 'fw', '23', 'wenda', '2019-07-16 15:38:14', '4');
INSERT INTO `problemquestinfo` VALUES ('36', 'wd', 'few', '23', 'jianda', '2019-07-16 15:39:37', '4');
INSERT INTO `problemquestinfo` VALUES ('37', 'wf', 'wf', '2', 'tiankong', '2019-07-16 15:40:53', '4');
INSERT INTO `problemquestinfo` VALUES ('38', 'rhrtrjty', 'tjyn', '34', 'tiankong', '2019-07-16 19:13:23', '4');
INSERT INTO `problemquestinfo` VALUES ('39', 'erhrt', 'htrhjr', '34', 'fujia', '2019-07-16 19:13:33', '4');

-- ----------------------------
-- Table structure for smprobleminfo
-- ----------------------------
DROP TABLE IF EXISTS `smprobleminfo`;
CREATE TABLE `smprobleminfo` (
  `smproblemid` int(11) NOT NULL auto_increment,
  `problemid` varchar(20) NOT NULL,
  `answerid` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `smkey` varchar(20) NOT NULL,
  `smscore` varchar(20) NOT NULL,
  PRIMARY KEY  (`smproblemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smprobleminfo
-- ----------------------------
INSERT INTO `smprobleminfo` VALUES ('5', '5', '3', '111', 'B', '5');
INSERT INTO `smprobleminfo` VALUES ('6', '6', '3', '111', 'C', '0');
INSERT INTO `smprobleminfo` VALUES ('7', '7', '3', '111', 'ABC', '0');
INSERT INTO `smprobleminfo` VALUES ('8', '8', '3', '111', 'BD', '8');
INSERT INTO `smprobleminfo` VALUES ('9', '9', '4', '111', 'B', '0');
INSERT INTO `smprobleminfo` VALUES ('10', '11', '4', '111', 'B', '0');
INSERT INTO `smprobleminfo` VALUES ('11', '10', '4', '111', 'B', '0');
INSERT INTO `smprobleminfo` VALUES ('12', '5', '3', '222', 'D', '0');
INSERT INTO `smprobleminfo` VALUES ('13', '6', '3', '222', 'C', '0');
INSERT INTO `smprobleminfo` VALUES ('14', '7', '3', '222', 'ABC', '0');
INSERT INTO `smprobleminfo` VALUES ('15', '8', '3', '222', 'BC', '0');

-- ----------------------------
-- Table structure for smproblempanduan
-- ----------------------------
DROP TABLE IF EXISTS `smproblempanduan`;
CREATE TABLE `smproblempanduan` (
  `smproblempanduanid` int(11) NOT NULL auto_increment,
  `problempanduanid` varchar(20) NOT NULL,
  `answerid` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `smkey` varchar(20) NOT NULL,
  `smscore` varchar(20) NOT NULL,
  PRIMARY KEY  (`smproblempanduanid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smproblempanduan
-- ----------------------------
INSERT INTO `smproblempanduan` VALUES ('2', '2', '3', '111', 'yes', '5');
INSERT INTO `smproblempanduan` VALUES ('3', '3', '3', '111', 'yes', '0');
INSERT INTO `smproblempanduan` VALUES ('4', '5', '4', '111', 'yes', '0');
INSERT INTO `smproblempanduan` VALUES ('5', '2', '3', '222', 'yes', '5');
INSERT INTO `smproblempanduan` VALUES ('6', '3', '3', '222', 'no', '5');

-- ----------------------------
-- Table structure for smproblemquestinfo
-- ----------------------------
DROP TABLE IF EXISTS `smproblemquestinfo`;
CREATE TABLE `smproblemquestinfo` (
  `smproblemquestinfo` int(11) NOT NULL auto_increment,
  `problemquestid` varchar(20) NOT NULL,
  `answerid` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `smkey` longtext NOT NULL,
  `smscore` varchar(20) NOT NULL default '0',
  `smevaluate` varchar(20) NOT NULL default '0',
  PRIMARY KEY  (`smproblemquestinfo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smproblemquestinfo
-- ----------------------------
INSERT INTO `smproblemquestinfo` VALUES ('6', '7', '3', '111', '85、5755、57、27、828', '11', 'aa');
INSERT INTO `smproblemquestinfo` VALUES ('7', '8', '3', '111', '抈看得刘雯村自提入', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('8', '9', '3', '111', '是什么坏蛋夏雨来的主很高的', '7', '0');
INSERT INTO `smproblemquestinfo` VALUES ('9', '10', '3', '111', '在短时间内底面积想的', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('10', '11', '3', '111', '肨折上盯于', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('11', '12', '3', '111', '和部尽管村且', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('12', '13', '3', '111', '旷和得和主是', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('13', '37', '4', '111', 'hrhrh', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('14', '38', '4', '111', 'e5yrhh', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('15', '36', '4', '111', 'rhrth', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('16', '29', '4', '111', 'rht', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('17', '35', '4', '111', 'ehrh', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('18', '39', '4', '111', 'rehh', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('19', '7', '3', '222', '临 遥珀处遥一g', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('20', '8', '3', '222', ' 且的睡睡', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('21', '9', '3', '222', '?肝', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('22', '10', '3', '222', '仍地扌处', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('23', '11', '3', '222', '舒服手上', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('24', '12', '3', '222', '我睡上 临', '0', '0');
INSERT INTO `smproblemquestinfo` VALUES ('25', '13', '3', '222', 'd霜我的目的和', '0', '0');

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `usernum` int(11) NOT NULL auto_increment,
  `username` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `userpassword` varchar(20) NOT NULL,
  PRIMARY KEY  (`usernum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('1', '李白', '162012223', 'qkhh');
INSERT INTO `userinfo` VALUES ('2', '哪吒', '111', '111');
INSERT INTO `userinfo` VALUES ('5', '太右', '222', '222');
