use rcbill;

drop table if exists rcb_tickettechdepts;



CREATE TABLE `rcb_tickettechdepts` (
  `ID` int(11) DEFAULT NULL,
  `KOD` int(11) DEFAULT NULL,
  `NAME` varchar(255) default null,
  `TECHLEVELID` varchar(255) default null,
  `OWNERID` varchar(255) default null,
  `ID_OLD` int(11) DEFAULT NULL,
  `UPDDATE` datetime DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  `INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

create index IDXttd1 on rcbill.rcb_tickettechdepts (ID);