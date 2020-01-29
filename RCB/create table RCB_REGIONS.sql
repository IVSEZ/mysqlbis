use rcbill;

drop table if exists rcb_regions;

CREATE TABLE `rcb_regions` (
  `ID` int(11) DEFAULT NULL,
`KOD` int(11) DEFAULT NULL,
`Name` text,
`City` text,
`OwnerID` int(11) DEFAULT NULL,
`ClientCodePrefix` text,
`ContractCodePrefix` text,
`Office` text,
`OfficeAddress` text,
`OfficeWorkTime` text,
`RegionGroupID` text,
`RegionsLevel1ID` int(11) DEFAULT NULL,
`ID_OLD` int(11) DEFAULT NULL,
`UpdDate` datetime DEFAULT NULL,
`USERID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
