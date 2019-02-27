-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechRegions-21112017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechRegions-11092018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTicketTechRegions-19022019.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tickettechregions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@KOD ,
@Name ,
@TechDeptID ,
@Email ,
@OwnerID ,
@RegionGroupID ,
@City ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@WorkTimeID
) 
set
ID=@ID ,
KOD=@KOD ,
NAME=@Name ,
TECHDEPTID=@TechDeptID ,
EMAIL=@Email ,
OWNERID=@OwnerID ,
REGIONGROUPID=@RegionGroupID ,
CITY=@City ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
WORKTIMEID=@WorkTimeID ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;



select * from rcbill.rcb_tickettechregions;

