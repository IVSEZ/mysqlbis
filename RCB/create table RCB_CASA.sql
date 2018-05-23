use rcbill;

drop table if exists rcb_casa;



CREATE TABLE `rcb_casa` (
`ID` int(11) DEFAULT NULL ,
`PAYOBJECTID` int(11) DEFAULT NULL ,
`PAYTYPE` int(11) DEFAULT NULL ,
`CashPointID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`toCLID` int(11) DEFAULT NULL ,
`PAYDATE` datetime DEFAULT NULL ,
`MONEY` decimal(12,5) DEFAULT NULL ,
`BankReference` varchar(255) DEFAULT NULL ,
`ZAB` varchar(500) DEFAULT NULL ,
`INVID` int(11) DEFAULT NULL ,
`ENTERDATE` datetime DEFAULT NULL ,
`CONFIRMED` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`PRN_COUNT` int(11) DEFAULT NULL ,
`ExternalReference` text DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`BegDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`hard` int(11) DEFAULT NULL ,
`InternalReference` text DEFAULT NULL ,
`RSID` int(11) DEFAULT NULL ,
`DiscountMoney` decimal(12,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	

) ENGINE=InnoDB CHARSET UTF8;

#NOTE: PAYTYPE in CASA is the same as negative of ID in rcb_services 

