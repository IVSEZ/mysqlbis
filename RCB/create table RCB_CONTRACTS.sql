use rcbill;

drop table if exists rcb_contracts;



CREATE TABLE `rcb_contracts` (

`ID` int(11) DEFAULT NULL ,
`KOD` varchar(255) DEFAULT NULL ,
`DATA` datetime DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`DirstributorID` int(11) DEFAULT NULL ,
`StartDate` datetime DEFAULT NULL ,
`EndDate` datetime DEFAULT NULL ,
`ValidityPeriod` int(11) DEFAULT NULL ,
`Discount` decimal(12,5) DEFAULT NULL ,
`RatingPlanID` int(11) DEFAULT NULL ,
`InvoicingDate` int(11) DEFAULT NULL ,
`CreditPolicyID` int(11) DEFAULT NULL ,
`Credit` decimal(12,5) DEFAULT NULL ,
`Active` int(11) DEFAULT NULL ,
`Activated` int(11) DEFAULT NULL ,
`ActivatedDate` datetime DEFAULT NULL ,
`Invoicing` int(11) DEFAULT NULL ,
`CommChanelID` int(11) DEFAULT NULL ,
`LastActionID` int(11) DEFAULT NULL ,
`PPCard` int(11) DEFAULT NULL ,
`Template` int(11) DEFAULT NULL ,
`ParentID` int(11) DEFAULT NULL ,
`ParentPercent` decimal(12,5) DEFAULT NULL ,
`ParentAmount` decimal(12,5) DEFAULT NULL ,
`LanguageID` int(11) DEFAULT NULL ,
`Comment` varchar(255) DEFAULT NULL ,
`TechUserID` int(11) DEFAULT NULL ,
`Currency` varchar(255) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UpdDate` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`TempActivateStartDate` datetime DEFAULT NULL ,
`TempActivateEndDate` datetime DEFAULT NULL ,
`ContractType` varchar(255) DEFAULT NULL ,
`RegionID` int(11) DEFAULT NULL ,
`Address` varchar(255) DEFAULT NULL ,
`TechRegionID` int(11) DEFAULT NULL ,
`KeyAccountManagerID` int(11) DEFAULT NULL ,
`ParentExcludeServiceClasses` varchar(255) DEFAULT NULL ,
`Locked` int(11) DEFAULT NULL ,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;

-- drop index IDXContracts on rcb_contracts;
-- drop index IDXContractsClient on rcb_contracts;



-- select * from rcb_contracts where clid in (723013);
-- select * from rcb_contracts where id in (2056902);