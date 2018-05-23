-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContractServices-08122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-13122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-23122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-21022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-28022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractServices-26122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_contractservices` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_contractservices` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@CID ,
@ServiceID ,
@ServiceRateID ,
@StartDate ,
@EndDate ,
@Number ,
@csCredit ,
@manualPrice ,
@Active ,
@ActivatedDate ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@NoTrigger 
) 
set 
ID=@ID ,
CID=@CID ,
ServiceID=@ServiceID ,
ServiceRateID=@ServiceRateID ,
StartDate=@StartDate ,
EndDate=@EndDate ,
Number=@Number ,
csCredit=@csCredit ,
manualPrice=@manualPrice ,
Active=@Active ,
ActivatedDate=@ActivatedDate ,
ID_OLD=@ID_OLD ,
UpdDate=@UpdDate ,
USERID=@USERID ,
NoTrigger=@NoTrigger ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE

;


CREATE INDEX IDXContractServices
ON rcb_contractservices (CID);

CREATE INDEX IDXContractServices2
ON rcb_contractservices (ServiceRateID);

CREATE INDEX IDXContractServices3
ON rcb_contractservices (ServiceID);


-- select * from rcb_contractservices;