use rcbill;

drop table if exists rcb_tickettypes;

CREATE TABLE `rcb_tickettypes` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ACTIVE` int(11) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL
-- 	,
-- `REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
