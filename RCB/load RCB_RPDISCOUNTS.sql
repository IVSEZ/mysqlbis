-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllContractDiscountsOld-03102017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllRPDiscounts-03102017.csv'

REPLACE INTO TABLE `rcbill`.`rcb_rpdiscounts` CHARACTER SET latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ID ,
@RatingPlanID ,
@ServiceID ,
@DiscountType ,
@Type ,
@DiscountOrder ,
@DiscountName ,
@Discount ,
@Price ,
@Validity ,
@rpExportCode ,
@ID_OLD ,
@UpdDate ,
@USERID ,
@AbsoluteValue 
) 
set 
ID=@ID ,
RATINGPLANID=@RatingPlanID ,
SERVICEID=@ServiceID ,
DISCOUNTTYPE=@DiscountType ,
TYPE=@Type ,
DISCOUNTORDER=@DiscountOrder ,
DISCOUNTNAME=@DiscountName ,
DISCOUNT=@Discount ,
PRICE=@Price ,
VALIDITY=@Validity ,
RPEXPORTCODE=@rpExportCode ,
ID_OLD=@ID_OLD ,
UPDDATE=@UpdDate ,
USERID=@USERID ,
ABSOLUTEVALUE=@AbsoluteValue ,

INSERTEDON=now(),
REPORTDATE=@REPORTDATE 

;


-- CREATE INDEX IDXcd1
-- ON rcb_rpdiscounts (CID);

select * from rcbill.rcb_rpdiscounts;

select distinct discounttype, type, discountname from rcbill.rcb_rpdiscounts order by discounttype;

