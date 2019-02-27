use rcbill;

drop table if exists rcb_devicesold;



CREATE TABLE `rcb_devicesold` (
`ID` int(11) DEFAULT NULL ,
`ContractID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`DevTypeID` int(11) DEFAULT NULL ,
`PhoneNo` varchar(255) DEFAULT NULL ,
`UserName` varchar(255) DEFAULT NULL ,
`Password` varchar(255) DEFAULT NULL ,
`Address` varchar(255) DEFAULT NULL ,
`IP` varchar(255) DEFAULT NULL ,
`NATIP` varchar(255) DEFAULT NULL ,
`DeviceName` varchar(255) DEFAULT NULL ,
`MAC` varchar(255) DEFAULT NULL ,
`SerNo` varchar(255) DEFAULT NULL ,
`GKID` int(11) DEFAULT NULL ,
`ProtNo` varchar(255) DEFAULT NULL ,
`CreditLimit` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`NoTrigger` smallint(1) DEFAULT NULL ,
`AddressID` int(11) DEFAULT NULL ,
`CustomConfig` varchar(700) DEFAULT NULL ,
`OutVLAN` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;



