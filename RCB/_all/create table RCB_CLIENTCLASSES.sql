use rcbill;

drop table rcb_clientclasses;


CREATE TABLE `rcb_clientclasses` (
`ID` int(11) DEFAULT NULL ,
`Name` varchar(255) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL,
`ACTIVE` int(4) DEFAULT NULL  
) ENGINE=InnoDB CHARSET UTF8;


CREATE INDEX IDXClientClasses
ON rcb_clientclasses (ID);