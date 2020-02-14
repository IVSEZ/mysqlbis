use rcbill;

drop table if exists rcb_regions;

CREATE TABLE `rcb_regions` (
`REGIONID` int(11) DEFAULT NULL,
`KOD` int(11) DEFAULT NULL,
`REGIONNAME` varchar(255) DEFAULT NULL,
`City` varchar(255) DEFAULT NULL,
`OwnerID` int(11) DEFAULT NULL,
`ClientCodePrefix` varchar(255) DEFAULT NULL,
`ContractCodePrefix` varchar(255) DEFAULT NULL,
`Office` varchar(255) DEFAULT NULL,
`OfficeAddress` varchar(255) DEFAULT NULL,
`OfficeWorkTime` varchar(255) DEFAULT NULL,
`RegionGroupID` varchar(255) DEFAULT NULL,
`RegionsLevel1ID` int(11) DEFAULT NULL,
`ID_OLD` int(11) DEFAULT NULL,
`UpdDate` datetime DEFAULT NULL,
`USERID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;





DESCRIBE rcbill.rcb_regions;
