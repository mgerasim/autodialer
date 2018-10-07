# Настройка хранения данных о вызовах
## 1. Настроить хранение данных о вызовах
```
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `asteriskcdrdb`
--
CREATE DATABASE IF NOT EXISTS `asteriskcdrdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `asteriskcdrdb`;

-- --------------------------------------------------------

--
-- Структура таблицы `cdr`
--

DROP TABLE IF EXISTS `cdr`;
CREATE TABLE IF NOT EXISTS `cdr` (
`id` int(10) NOT NULL,
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `clid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `realsrc` varchar(80) NOT NULL,
  `dst` varchar(80) NOT NULL DEFAULT '',
  `realdst` varchar(80) NOT NULL DEFAULT '',
  `dcontext` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `lastapp` varchar(80) NOT NULL DEFAULT '',
  `lastdata` varchar(80) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT '0',
  `billsec` int(11) NOT NULL DEFAULT '0',
  `disposition` varchar(45) NOT NULL DEFAULT '',
  `amaflags` int(11) NOT NULL DEFAULT '0',
  `remoteip` varchar(60) NOT NULL DEFAULT '',
  `accountcode` varchar(20) NOT NULL DEFAULT '',
  `hangupcause` varchar(50) NOT NULL,
  `peerip` varchar(50) NOT NULL,
  `recvip` varchar(50) NOT NULL,
  `useragent` varchar(50) NOT NULL,
  `uri` varchar(50) NOT NULL,
  `fromuri` varchar(50) NOT NULL,
  `peeraccount` varchar(20) NOT NULL DEFAULT '',
  `uniqueid` varchar(32) NOT NULL DEFAULT '',
  `userfield` varchar(255) NOT NULL DEFAULT '',
  `did` varchar(50) NOT NULL DEFAULT '',
  `linkedid` varchar(32) NOT NULL DEFAULT '',
  `sequence` int(11) NOT NULL DEFAULT '0',
  `filename` varchar(255) DEFAULT 'none',
  `recordingfile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21758 DEFAULT CHARSET=utf8;

--
-- Триггеры `cdr`
--
DROP TRIGGER IF EXISTS `t_cdr`;
DELIMITER //
CREATE TRIGGER `t_cdr` BEFORE INSERT ON `cdr`
 FOR EACH ROW BEGIN
 IF ((NEW.dst = 's' OR NEW.dst = '~~s~~') AND NEW.realdst != '') THEN 
  SET NEW.dst = NEW.realdst;
 END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `cel`
--

DROP TABLE IF EXISTS `cel`;
CREATE TABLE IF NOT EXISTS `cel` (
`id` int(11) NOT NULL,
  `eventtype` varchar(30) NOT NULL,
  `eventtime` datetime NOT NULL,
  `cid_name` varchar(80) NOT NULL,
  `cid_num` varchar(80) NOT NULL,
  `cid_ani` varchar(80) NOT NULL,
  `cid_rdnis` varchar(80) NOT NULL,
  `cid_dnid` varchar(80) NOT NULL,
  `exten` varchar(80) NOT NULL,
  `context` varchar(80) NOT NULL,
  `channame` varchar(80) NOT NULL,
  `src` varchar(80) NOT NULL,
  `dst` varchar(80) NOT NULL,
  `channel` varchar(80) NOT NULL,
  `dstchannel` varchar(80) NOT NULL,
  `appname` varchar(80) NOT NULL,
  `appdata` varchar(80) NOT NULL,
  `amaflags` int(11) NOT NULL,
  `accountcode` varchar(20) NOT NULL,
  `uniqueid` varchar(32) NOT NULL,
  `linkedid` varchar(32) NOT NULL,
  `peer` varchar(80) NOT NULL,
  `userdeftype` varchar(255) NOT NULL,
  `eventextra` varchar(255) NOT NULL,
  `userfield` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=207114 DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cdr`
--
ALTER TABLE `cdr`
 ADD PRIMARY KEY (`id`), ADD KEY `calldate` (`calldate`), ADD KEY `src` (`src`), ADD KEY `dst` (`dst`), ADD KEY `accountcode` (`accountcode`), ADD KEY `uniqueid` (`uniqueid`), ADD KEY `dcontext` (`dcontext`), ADD KEY `clid` (`clid`), ADD KEY `did` (`did`), ADD KEY `id` (`id`);

--
-- Индексы таблицы `cel`
--
ALTER TABLE `cel`
 ADD PRIMARY KEY (`id`), ADD KEY `uniqueid_index` (`uniqueid`), ADD KEY `linkedid_index` (`linkedid`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cdr`
--
ALTER TABLE `cdr`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21758;
--
-- AUTO_INCREMENT для таблицы `cel`
--
ALTER TABLE `cel`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=207114;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
```

## 2. Подправить файл /etc/asterisk/cdr_mysql.conf
```
[global]
usegmtime=no
cdrzone=Europe/Moscow

[columns]
alias start => calldate
alias realdst => realdst
alias remoteip => remoteip
alias start => calldate
alias hangupcause => hangupcause
alias peerip => peerip
alias recvip => recvip
alias fromuri => fromuri
alias useragent => useragent
alias filename => filename
alias realsrc => realsrc
```
