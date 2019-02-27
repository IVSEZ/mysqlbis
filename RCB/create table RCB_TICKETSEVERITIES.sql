use rcbill;

drop table if exists rcb_ticketseverities;

CREATE TABLE `rcb_ticketseverities` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
