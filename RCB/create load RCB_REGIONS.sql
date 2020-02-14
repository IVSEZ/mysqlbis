use rcbill;

drop table if exists rcb_regions;


CREATE TABLE `rcb_regions` (
`ID` int(11) DEFAULT NULL,
`KOD` int(11) DEFAULT NULL,
`NAME` varchar(255) DEFAULT NULL,
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

) ENGINE=InnoDB CHARSET UTF8;


LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\DB_EXTRACT\\Regions.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_contractservices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_regions` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
-- IGNORE 2 LINES 
(
@ID,
@KOD,
@NAME,
@City,
@OwnerID,
@ClientCodePrefix,
@ContractCodePrefix,
@Office,
@OfficeAddress,
@OfficeWorkTime,
@RegionGroupID,
@RegionsLevel1ID,
@ID_OLD,
@UpdDate,
@USERID 
) 
set 
ID=@ID,
KOD=@KOD,
NAME=trim(upper(@NAME)),
CITY=@City,OWNERID=@OwnerID,
CLIENTCODEPREFIX=@ClientCodePrefix,
CONTRACTCODEPREFIX=@ContractCodePrefix,
OFFICE=@Office,
OFFICEADDRESS=@OfficeAddress,
OFFICEWORKTIME=@OfficeWorkTime,
REGIONGROUPID=@RegionGroupID,
REGIONSLEVEL1ID=@RegionsLevel1ID,
ID_OLD=@ID_OLD,
UPDDATE=@UpdDate,
USERID=@USERID
;

select * from rcbill.rcb_regions;