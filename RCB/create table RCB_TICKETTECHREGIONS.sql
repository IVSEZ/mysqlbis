use rcbill;

drop table if exists rcb_tickettechregions;

CREATE TABLE `rcb_tickettechregions` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`TECHDEPTID` int(11) DEFAULT NULL ,
`EMAIL` varchar(255) DEFAULT NULL ,
`OWNERID` int(11) DEFAULT NULL ,
`REGIONGROUPID` int(11) DEFAULT NULL ,
`CITY` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`WORKTIMEID` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

create index IDXttr1 on rcbill.rcb_tickettechregions (ID);