use rcbill;

drop table if exists rcb_contractservices;



CREATE TABLE `rcb_contractservices` (
`ID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`ServiceID` int(11) DEFAULT NULL ,
`ServiceRateID` int(11) DEFAULT NULL ,
`StartDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`Number` int(11) DEFAULT NULL ,
`csCredit` decimal(12,5) DEFAULT NULL ,
`manualPrice` decimal(12,5) DEFAULT NULL ,
`Active` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`NoTrigger` int(4) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;


-- select count(cid) from rcb_contractservices;