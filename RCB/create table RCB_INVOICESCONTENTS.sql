use rcbill;

drop table if exists rcb_invoicescontents;


CREATE TABLE `rcb_invoicescontents` (
`ID` int(11) DEFAULT NULL ,
`INVOICENO` bigint(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`CSID` int(11) DEFAULT NULL ,
`RID` int(11) DEFAULT NULL ,
`RSID` int(11) DEFAULT NULL ,
`ServiceID` int(11) DEFAULT NULL ,
`DID` int(11) DEFAULT NULL ,
`RPDiscountID` int(11) DEFAULT NULL ,
`Discount` decimal(50,5) DEFAULT NULL ,
`NUMBER` int(11) DEFAULT NULL ,
`SCOST` decimal(50,5) DEFAULT NULL ,
`COST` decimal(50,5) DEFAULT NULL ,
`sumCost` decimal(50,5) DEFAULT NULL ,
`FROMDATE` datetime DEFAULT NULL ,
`TODATE` datetime DEFAULT NULL ,
`ValidTill` datetime DEFAULT NULL ,
`ROW` int(11) DEFAULT NULL ,
`TEXT` varchar(255) DEFAULT NULL ,
`ParentID` int(11) DEFAULT NULL ,
`InvNo` bigint(11) DEFAULT NULL ,
`CDRCOUNT` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`InvoiceID` int(11) DEFAULT NULL ,
`VAT` decimal(50,5) DEFAULT NULL ,
`CostVAT` decimal(50,5) DEFAULT NULL ,
`CostTotal` decimal(50,5) DEFAULT NULL ,
`DiscardPeriod` int(11) DEFAULT NULL ,
`ChildCID` int(11) DEFAULT NULL ,
`DiscountCost` decimal(50,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;

