use rcbill;

drop table if exists rcb_devicetypes;



CREATE TABLE `rcb_devicetypes` (
`id` int(11) DEFAULT NULL ,
`name` varchar(255) DEFAULT NULL ,
`ServiceTypeID` int(11) DEFAULT NULL ,
`SubDevice` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;


