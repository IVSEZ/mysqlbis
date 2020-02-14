LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\DB_EXTRACT\\Regions.csv'
REPLACE INTO TABLE `rcbill`.`rcb_regions` CHARACTER SET UTF8 FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
@﻿REGIONID,
@KOD,
@REGIONNAME,
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
﻿﻿REGIONID=@REGIONID,KOD=@KOD,REGIONNAME=trim(upper(@REGIONNAME)),CITY=@City,OWNERID=@OwnerID,CLIENTCODEPREFIX=@ClientCodePrefix,CONTRACTCODEPREFIX=@ContractCodePrefix,OFFICE=@Office,OFFICEADDRESS=@OfficeAddress,OFFICEWORKTIME=@OfficeWorkTime,REGIONGROUPID=@RegionGroupID,REGIONSLEVEL1ID=@RegionsLevel1ID,ID_OLD=@ID_OLD,UPDDATE=@UpdDate,USERID=@USERID;


select * from rcbill.rcb_regions;