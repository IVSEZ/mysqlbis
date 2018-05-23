use rcbill;

drop table if exists rcb_invoicesheader;


CREATE TABLE `rcb_invoicesheader` (
`ID` int(11) DEFAULT NULL ,
`TYPE` smallint(4) DEFAULT NULL ,
`HARD` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`INVOICENO` bigint(50) DEFAULT NULL ,

`ProformaNO` bigint(50) DEFAULT NULL ,
`SRCNO` bigint(50) DEFAULT NULL ,
`DKINO` bigint(50) DEFAULT NULL ,
`DATA` datetime DEFAULT NULL ,
`TFIRM` varchar(255) DEFAULT NULL ,
`TADDRESS` varchar(255) DEFAULT NULL ,
`TMOL` varchar(255) DEFAULT NULL ,
`TMOLADDRESS` varchar(255) DEFAULT NULL ,

`TDANNO` varchar(255) DEFAULT NULL ,
`TBULSTAT` varchar(255) DEFAULT NULL ,
`TCITY` varchar(255) DEFAULT NULL ,
`TZIP` varchar(255) DEFAULT NULL ,
`TRECIPIENT` varchar(255) DEFAULT NULL ,
`FCLID` int(11) DEFAULT NULL ,
`FFIRM` varchar(255) DEFAULT NULL ,
`FADDRESS` varchar(255) DEFAULT NULL ,
`FMOL` varchar(255) DEFAULT NULL ,
`FDANNO` varchar(255) DEFAULT NULL ,
`FBULSTAT` varchar(255) DEFAULT NULL ,
`FCITY` varchar(255) DEFAULT NULL ,
`FBANK` varchar(255) DEFAULT NULL ,
`FBANKNO` int(11) DEFAULT NULL ,
`FACCOUNT` varchar(255) DEFAULT NULL ,
`FDDSACCOUNT` varchar(255) DEFAULT NULL ,
`PLACE` varchar(255) DEFAULT NULL ,
`REASON` varchar(255) DEFAULT NULL ,
`SUMA` decimal(50,5) DEFAULT NULL ,
`DDS` decimal(50,5) DEFAULT NULL ,
`TOTAL` decimal(50,5) DEFAULT NULL ,
`DEBT` decimal(50,5) DEFAULT NULL ,
`Avance` decimal(50,5) DEFAULT NULL ,
`AvanceUse` decimal(50,5) DEFAULT NULL ,
`VATPercent` decimal(50,5) DEFAULT NULL ,
`CREATOR` varchar(255) DEFAULT NULL ,
`PRNCOUNT` smallint(4) DEFAULT NULL ,
`BEGDATE` datetime DEFAULT NULL ,
`ENDDATE` datetime DEFAULT NULL ,
`SAPExported` int(11) DEFAULT NULL ,
`PaymentID` int(11) DEFAULT NULL ,
`Currency` varchar(255) DEFAULT NULL ,
`OriginalCurrency` varchar(255) DEFAULT NULL ,
`Rate` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`DueDate` datetime DEFAULT NULL ,
`InvNo` decimal(50,5) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



-- drop index IDXinvoiceheader on rcb_invoicesheader;


