use rcbill;

drop table rcb_payobjects;


CREATE TABLE `rcb_payobjects` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`NAME` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`RequireFiscPrint` int(11) DEFAULT NULL ,
`RequireReference` int(11) DEFAULT NULL ,
`MaxDaysBefore` int(11) DEFAULT NULL ,
`SimpleMode` int(11) DEFAULT NULL 
 
) ENGINE=InnoDB CHARSET UTF8;


CREATE INDEX IDXpo1
ON rcb_payobjects (ID);