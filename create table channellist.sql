use rcbill_my;

drop table if exists channellist;

CREATE TABLE `channellist` (
  `channelid` int(8) NOT NULL AUTO_INCREMENT,
  `isp` varchar(45) DEFAULT NULL, 
  `channelno` int(4) DEFAULT NULL,
  `origname` varchar(100) DEFAULT NULL,
  `channelname` varchar(100) DEFAULT NULL,
  `channelsource` varchar(50) DEFAULT NULL,
  `def` varchar(10) DEFAULT NULL,
  `timeshift` varchar(10) DEFAULT NULL,
  `channelcategory` varchar(100) DEFAULT NULL,
  `channelcountry` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`channelid`)
  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;