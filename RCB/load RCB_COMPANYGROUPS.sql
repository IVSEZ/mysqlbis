
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\AllAreaSettlementDistrictStreet-31082018.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\RCBill\\DB_EXTRACT\\CompanyGroups.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_companygroups` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID,
@Name,
@ID_OLD,
@UPDDATE,
@USERID,
@RestrictionsLevel
) 
set 

ID=@ID ,
Name=trim(upper(@Name)) ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID , 
RestrictionsLevel=@RestrictionsLevel 

;

