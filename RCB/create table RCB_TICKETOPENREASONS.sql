use rcbill;

drop table if exists rcb_ticketopenreasons;

CREATE TABLE `rcb_ticketopenreasons` (
`TORID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`OPENREASONNAME` varchar(255) DEFAULT NULL ,
`STANDARDWORK` varchar(255) DEFAULT NULL ,
`MAXDURATION` varchar(255) DEFAULT NULL ,
`TECHSERVICEID` int(11) DEFAULT NULL ,
`TICKETTYPEID` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`REQUIRETESTING` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;


create index IDXtor1 on rcbill.rcb_ticketopenreasons (TORID);