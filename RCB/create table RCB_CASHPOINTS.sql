use rcbill;

drop table rcb_cashpoints;


CREATE TABLE `rcb_cashpoints` (
`ID` int(11) DEFAULT NULL ,
`KOD` int(11) DEFAULT NULL ,
`Name` varchar(255) DEFAULT NULL ,
`IPAddress` varchar(255) DEFAULT NULL ,
`MachineName` varchar(255) DEFAULT NULL ,
`RequireSSL` int(11) DEFAULT NULL ,
`StartInvoiceNo` bigint(11) DEFAULT NULL ,
`EndInvoiceNo` bigint(11) DEFAULT NULL ,
`OwnerID` int(11) DEFAULT NULL ,
`CashPrinterID` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`RegionID` int(11) DEFAULT NULL ,
`SetupUserID` int(11) DEFAULT NULL ,
`SetupDate` datetime DEFAULT NULL ,
`SetupAllow` int(11) DEFAULT NULL ,
`AllowPayObjects` varchar(255) DEFAULT NULL ,
`InvoiceRangeID` int(11) DEFAULT NULL ,
`DistributorID` int(11) DEFAULT NULL ,
`StornoPermissionPaymentCount` int(11) DEFAULT NULL ,
`StornoPermissionMonthCount` int(11) DEFAULT NULL 
 
) ENGINE=InnoDB CHARSET UTF8;


