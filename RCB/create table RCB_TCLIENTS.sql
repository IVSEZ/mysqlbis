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


-- select * from rcb_tclients where id in (723013);