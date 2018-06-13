use rcbill;

drop table if exists rcb_tickettechlevels;



CREATE TABLE `rcb_tickettechlevels` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`AUTH_GROUP_ID` int(11) DEFAULT NULL ,

  `INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

