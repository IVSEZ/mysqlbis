use rcbill;

drop table if exists rcb_tickettechusers;



CREATE TABLE `rcb_tickettechusers` (
  `ID` int(11) DEFAULT NULL,
  `KOD` text,
  `NAME` text,
  `EMAIL` text,
  `PHONE` text,
  `RCBUSERID` text,
  `TECHGROUPID` text,
  `TECHREGIONID` int(11) DEFAULT NULL,
  `NOTIFY` text,
  `USERID` int(11) DEFAULT NULL,
  `ID_OLD` int(11) DEFAULT NULL,
  `UPDDATE` datetime DEFAULT NULL,
  `SUPERUSER` int(11) DEFAULT NULL,
  `INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

