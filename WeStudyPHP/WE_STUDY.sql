-- phpMyAdmin SQL Dump
-- version 4.5.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2016-02-27 07:37:48
-- 服务器版本： 5.7.10
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qdm157490578_db`
--

-- --------------------------------------------------------

--
-- 表的结构 `WE_STUDY`
--

CREATE TABLE `WE_STUDY` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userpwd` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `studydata` text COLLATE utf8_unicode_ci,
  `studystatus` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `WE_STUDY`
--

INSERT INTO `WE_STUDY` (`id`, `username`, `userpwd`, `subject`, `tel`, `email`, `pid`, `studydata`, `studystatus`) VALUES
(0, 'admin', '123', 'computer science', '18370606387', 'arlenliugj@sina.cn', '0000', 'iOS 学习', 1),
(1, 'arlen', '12345', 'cs', '18766209458', 'arlenliugj@gmail.com', '1111', 'Android study', 0),
(2, '林俊杰', '111222', 'music', '123456789', '123456789@gmail.com', '2222', 'JJ 林俊杰', 1),
(3, '周杰伦', '123456', '音乐', '987654321', '987654321@qq.com', '3333', '我的地盘听我的', 1),
(4, '张靓颖', '54321', '歌手', '01234', '01234@163.com', '4444', '我们说好的', 0),
(5, 'WestLife', '55555', 'music', '55555', '55555@iCloud.com', '5555', 'love story', 1),
(6, '习大大', '666', '主席', '66666', '666666@china.com', '6666', '我想干掉美国', 1),
(7, '叶良辰', '1234', '网络', '4321', '4321@126.com', '7777', '良辰必有重谢', 0),
(8, '王力宏', '333', '歌手', '88888', 'lihong@sina.com', '8888', '龙的传人', 0),
(9, '小猫', 'xiaomao', '猫', '0000', '0000@da.com', '9999', '瞄', 0),
(10, '花花草草', '4455', '植物', '4545', '4545@xx.cn', '1010', '呼呼呼', 0),
(11, '还有什么', '999', '啊啊', '3452', '231@bfda.com', '1111', '实在想不出来了', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `WE_STUDY`
--
ALTER TABLE `WE_STUDY`
  ADD PRIMARY KEY (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
