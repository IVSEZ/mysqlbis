use rcbill;

drop table if exists rcb_tickettechusers;



CREATE TABLE `rcb_tickettechusers` (
  `ID` int(11) DEFAULT NULL,
  `KOD` varchar(255) DEFAULT NULL ,
  `NAME` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `PHONE` varchar(255) DEFAULT NULL,
  `RCBUSERID` varchar(255) DEFAULT NULL,
  `TECHGROUPID` varchar(255) DEFAULT NULL,
  `TECHREGIONID` int(11) DEFAULT NULL,
  `NOTIFY` varchar(255) DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  `ID_OLD` int(11) DEFAULT NULL,
  `UPDDATE` datetime DEFAULT NULL,
  `SUPERUSER` int(11) DEFAULT NULL,
  `INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


show index from rcbill.rcb_tickettechusers;

create index IDXttu1 on rcbill.rcb_tickettechusers (RCBUSERID);
