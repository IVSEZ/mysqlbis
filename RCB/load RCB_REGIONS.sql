
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-31082018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\DB_EXTRACT\\Regions.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_regions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿I_D,
@KOD,
@Name,
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
﻿﻿ID=@I_D ,
KOD=@KOD,
Name=trim(upper(@Name)),
CITY=@City,
OWNERID=@OwnerID,
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



drop table if exists rcbill.rcb_regions;

create table rcbill.rcb_regions as
(
	
)
;


select * from rcbill.rcb_tickettechusers;
