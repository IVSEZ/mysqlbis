use rcbill_my;

drop table if exists packagelist;

CREATE TABLE `packagelist` (
  `packageid` int(8) NOT NULL AUTO_INCREMENT,
  `isp` varchar(45) DEFAULT NULL, 
  `packagesource` varchar(50) DEFAULT NULL ,
  `packagetype` varchar(50) DEFAULT NULL ,
  `packagename` varchar(100) DEFAULT NULL,
  `packagepricescr` decimal(12,5) DEFAULT NULL,
  `packagepriceusd` decimal(12,5) DEFAULT NULL,
  `enabled` smallint(1) DEFAULT NULL,
  PRIMARY KEY (`packageid`)
  ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;