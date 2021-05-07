use rcbill_my;

drop table if exists mac_vendors;


/*
CREATE TABLE `rcb_devicetypes` (
`id` int(11) DEFAULT NULL ,
`name` varchar(255) DEFAULT NULL ,
`ServiceTypeID` int(11) DEFAULT NULL ,
`SubDevice` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL,
`REPORTDATE` date DEFAULT NULL

) ENGINE=InnoDB CHARSET UTF8;
*/

CREATE TABLE `mac_vendors`(
`MACPREFIX` varchar(255) DEFAULT NULL ,
`VENDORNAME` varchar(255) DEFAULT NULL ,
`PRIVATE` varchar(255) DEFAULT NULL ,
`BLOCKTYPE` varchar(255) DEFAULT NULL ,
`LASTUPDATE` varchar(255) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL 

) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*
CREATE TABLE `rcbill_my`.`mac_vendors` 
(
`Mac Prefix` text, 
`Vendor Name` text, 
`Private` text, 
`Block Type` text, 
`Last Update` text
);

PREPARE stmt FROM 
'INSERT INTO `rcbill_my`.`mac_vendors` 
(`Vendor Name`,`Last Update`,`Block Type`,`Mac Prefix`,`Private`) 
VALUES
(?,?,?,?,?)'


*/