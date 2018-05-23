use rcbill;

drop table rcb_services;



CREATE TABLE `rcb_services` (
`ID` int(11) DEFAULT NULL ,
`Name` varchar(255) DEFAULT NULL ,
`SysName` varchar(255) DEFAULT NULL ,
`KOD` varchar(255) DEFAULT NULL ,
`AcctCode` varchar(255) DEFAULT NULL ,
`System` int(11) DEFAULT NULL ,
`ServiceTypeID` int(11) DEFAULT NULL ,
`ParentID` int(11) DEFAULT NULL ,
`SessionName` varchar(255) DEFAULT NULL ,
`BillingName` varchar(255) DEFAULT NULL ,
`AllowDevices` int(11) DEFAULT NULL ,
`InStatistics` int(11) DEFAULT NULL ,
`ID_OLD` int(11) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`FiscalPrintName` varchar(255) DEFAULT NULL ,
`VATPercentT` decimal(12,5) DEFAULT NULL ,
`ServiceClassID` int(11) DEFAULT NULL ,
`AutoNumber` int(11) DEFAULT NULL ,
`DisablePeriodConsolidation` varchar(255) DEFAULT NULL 
) ENGINE=InnoDB CHARSET UTF8;

CREATE INDEX IDXServices
ON rcb_services (ID);