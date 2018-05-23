use rcbill;

drop table if exists rcb_comments;


CREATE TABLE `rcb_comments` (
`ID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,

`CID` int(11) DEFAULT NULL ,
`CONTRACTCODE` varchar(255) DEFAULT NULL ,

`COMMENTDATE` datetime DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,



`INSERTEDON` datetime DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_ticketcomments;

use rcbill;

drop table if exists rcb_contractdiscounts;



CREATE TABLE `rcb_contractdiscounts` (

`ID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`DISCTYPE` int(11) DEFAULT NULL ,
`TYPEID` int(11) DEFAULT NULL ,
`TYPEID1` int(11) DEFAULT NULL ,
`TYPEID2` int(11) DEFAULT NULL ,
`TYPEID3` int(11) DEFAULT NULL ,
`PERCENT` decimal(12,5) DEFAULT NULL ,
`AMOUNT` decimal(12,5) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`APPROVED` int(11) DEFAULT NULL ,
`APPROVEDBY` int(11) DEFAULT NULL ,
`APPROVEDTS` datetime DEFAULT NULL ,
`APPROVALREASON` varchar(255) DEFAULT NULL ,

`CONTRACTCODE` varchar(255) DEFAULT NULL ,
`CLIENTCODE` varchar(255) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;

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
-- select * from rcb_contracts where id in (2056902);use rcbill;

drop table if exists rcb_devices;

/*
ID,ContractID,SERVICEID,CSID,DevTypeID,
PhoneNo,UserName,Password,Address,
IP,NATIP,DeviceName,MAC,SerNo,GKID,
ProtNo,CreditLimit,ID_OLD,UpdDate,USERID,ActivatedDate,
NoTrigger,AddressID,CustomConfig,OutVLAN
*/
CREATE TABLE `rcb_devices` (
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



use rcbill;

drop table if exists rcb_tclients;



CREATE TABLE `rcb_tclients` (

`ID` int(11) DEFAULT NULL	,
`FIRM` varchar(255) DEFAULT NULL	,
`KOD` varchar(255) DEFAULT NULL	,
`BULSTAT` varchar(255) DEFAULT NULL	,
`PASSNo` varchar(255) DEFAULT NULL	,
`PASSIssueDate` datetime DEFAULT NULL	,
`PASSIssueFrom` varchar(255) DEFAULT NULL	,
`DANNO` varchar(255) DEFAULT NULL	,
`BANK` varchar(255) DEFAULT NULL	,
`BANKNO` int(11) DEFAULT NULL	,
`ACCOUNT` varchar(255) DEFAULT NULL	,
`DDSACCOUNT` varchar(255) DEFAULT NULL	,
`DDS` int(11) DEFAULT NULL	,
`ADDRESS` varchar(255) DEFAULT NULL	,
`CITY` varchar(255) DEFAULT NULL	,
`Country` varchar(255) DEFAULT NULL	,
`POSTALCODE` varchar(255) DEFAULT NULL	,
`FAX` varchar(255) DEFAULT NULL	,
`BOSS` varchar(255) DEFAULT NULL	,
`BPHONE` varchar(255) DEFAULT NULL	,
`BEMAIL` varchar(255) DEFAULT NULL	,
`MOL` varchar(255) DEFAULT NULL	,
`MOLADDRESS` varchar(255) DEFAULT NULL	,
`MEGN` varchar(255) DEFAULT NULL	,
`MPHONE` varchar(255) DEFAULT NULL	,
`MEMAIL` varchar(255) DEFAULT NULL	,
`RECIPIENT` varchar(255) DEFAULT NULL	,
`NOTE` varchar(255) DEFAULT NULL	,
`DISCOUNT` decimal(12,5) DEFAULT NULL	,
`FIZLICE` int(11) DEFAULT NULL	,
`BEGDATE` datetime DEFAULT NULL	,
`ENDDATE` datetime DEFAULT NULL	,
`CLTYPE` int(11) DEFAULT NULL	,
`CLClass` int(11) DEFAULT NULL	,
`ParentID` int(11) DEFAULT NULL	,
`DeliveryCLID` int(11) DEFAULT NULL	,
`DeliveryDepoID` int(11) DEFAULT NULL	,
`RegionID` int(11) DEFAULT NULL	,
`Active` int(11) DEFAULT NULL	,
`ActiveTill` datetime DEFAULT NULL	,
`CompanyGroupID` int(11) DEFAULT NULL	,
`IssuesProformaInv` int(11) DEFAULT NULL	,
`IssuesVATInv` int(11) DEFAULT NULL	,
`ID_OLD` varchar(255) DEFAULT NULL	,
`UPDDATE` datetime DEFAULT NULL	,
`USERID` int(11) DEFAULT NULL	,
`MOLRegistrationAddress` varchar(255) DEFAULT NULL	,
`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



-- drop index IDXTClients on rcb_tclients;


-- select * from rcb_tclients where id in (723013);use rcbill;

drop table if exists rcb_ticketcomments;


CREATE TABLE `rcb_ticketcomments` (
`ID` int(11) DEFAULT NULL ,
`TICKETID` int(11) DEFAULT NULL ,
`COMMENT` varchar(255) DEFAULT NULL ,
`TECHUSERID` int(11) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,

`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,


`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;




-- drop index IDXinvoiceheader on rcb_ticketcomments;

use rcbill;

drop table if exists rcb_tickets;


CREATE TABLE `rcb_tickets` (
`ID` int(11) DEFAULT NULL ,
`OPENDATE` datetime DEFAULT NULL ,
`OPENUSERID` int(11) DEFAULT NULL ,
`OPENREASONID` int(11) DEFAULT NULL ,
`TECHDEPTID` int(11) DEFAULT NULL ,
`TECHREGIONID` int(11) DEFAULT NULL ,
`TECHGROUPID` int(11) DEFAULT NULL ,
`VISITDATE` datetime DEFAULT NULL ,
`STAGETECHREGIONID` int(11) DEFAULT NULL ,
`EXECUTEDDATE` datetime DEFAULT NULL ,
`CLOSEDATE` datetime DEFAULT NULL ,
`CLOSEUSERID` int(11) DEFAULT NULL ,
`CLOSEREASONID` int(11) DEFAULT NULL ,
`CLOSETECHDEPTID` int(11) DEFAULT NULL ,
`CLOSETECHREGIONID` int(11) DEFAULT NULL ,
`CLOSETECHGROUPID` int(11) DEFAULT NULL ,
`CLID` int(11) DEFAULT NULL ,
`CID` int(11) DEFAULT NULL ,
`DEVID` int(11) DEFAULT NULL ,
`SEVERITYID` int(11) DEFAULT NULL ,
`SERVICEID` int(11) DEFAULT NULL ,
`TYPEID` int(11) DEFAULT NULL ,
`TYPE` varchar(255) DEFAULT NULL ,
`STATE` varchar(255) DEFAULT NULL ,
`VISITCOUNT` int(11) DEFAULT NULL ,
`WORKTIME` decimal(12,5) DEFAULT NULL ,
`SUBJECT` varchar(255) DEFAULT NULL ,
`DEVICESTATE` varchar(255) DEFAULT NULL ,
`ID_OLD` varchar(255) DEFAULT NULL ,
`UPDDATE` datetime DEFAULT NULL ,
`USERID` int(11) DEFAULT NULL ,
`NAS` varchar(255) DEFAULT NULL ,
`PARENTID` int(11) DEFAULT NULL ,
`INTERFACE` varchar(255) DEFAULT NULL ,
`TESTDATE` datetime DEFAULT NULL ,
`TESTSTATE` varchar(255) DEFAULT NULL ,
`ACTIVITYID` int(11) DEFAULT NULL ,
`GLOBALTICKET` int(11) DEFAULT NULL ,

`INSERTEDON` datetime DEFAULT NULL	,
`REPORTDATE` date DEFAULT NULL	
) ENGINE=InnoDB CHARSET UTF8;



-- drop index IDXinvoiceheader on rcb_tickets;

