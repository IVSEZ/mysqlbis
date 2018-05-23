/*
Error Code: 1292. Incorrect datetime value: '1' for column 'EndDate' at row 711856
On line 711857, change "pamela" <pamela@intelvision.sc> to "pamela <pamela@intelvision.sc>"
*/


-- SET SESSION sql_mode = '';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllContracts-04122016.txt'
-- REPLACE INTO TABLE `rcbill`.`rcb_contracts` CHARACTER SET LATIN1 FIELDS TERMINATED BY '\t' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\AllCasa-08122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-23122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-04012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-10012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-19012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-22012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-29012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-05022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCasa-21022017.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllCASA-27122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_casa` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_casa` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@PAYOBJECTID ,
@PAYTYPE ,
@CashPointID ,
@CLID ,
@toCLID ,
@PAYDATE ,
@MONEY ,
@BankReference ,
@ZAB ,
@INVID ,
@ENTERDATE ,
@CONFIRMED ,
@ID_OLD ,
@UPDDATE ,
@USERID ,
@PRN_COUNT ,
@ExternalReference ,
@CID ,
@BegDate ,
@EndDate ,
@hard ,
@InternalReference ,
@RSID ,
@DiscountMoney
) 
set 
ID=@ID ,
PAYOBJECTID=@PAYOBJECTID ,
PAYTYPE=@PAYTYPE ,
CashPointID=@CashPointID ,
CLID=@CLID ,
toCLID=@toCLID ,
PAYDATE=@PAYDATE ,
MONEY=@MONEY ,
BankReference=@BankReference ,
ZAB=upper(trim(@ZAB)) ,
INVID=@INVID ,
ENTERDATE=@ENTERDATE ,
CONFIRMED=@CONFIRMED ,
ID_OLD=@ID_OLD ,
UPDDATE=@UPDDATE ,
USERID=@USERID ,
PRN_COUNT=@PRN_COUNT ,
-- ExternalReference=upper(trim(@ExternalReference)) ,
ExternalReference=null ,
CID=@CID ,
BegDate=@BegDate ,
EndDate=@EndDate ,
hard=@hard ,
InternalReference=@InternalReference ,
RSID=@RSID ,
DiscountMoney=@DiscountMoney ,
INSERTEDON=now(),
REPORTDATE=@REPORTDATE 


;

CREATE INDEX IDXCASA1
ON rcb_casa (ID);

CREATE INDEX IDXCASA2
ON rcb_casa (CLID);

CREATE INDEX IDXCASA3
ON rcb_casa (CID);

CREATE INDEX IDXCASA4
ON rcb_casa (INVID);

-- select * from rcb_casa where clid=717788;
select count(*) from rcbill.rcb_casa;

/*
select * from rcbill.rcb_casa limit 1000;
		select clid, cid, COALESCE(sum(money),0) as TotalPaymentAmount , 
		max(money) as LastPaidAmount, 
		COALESCE(count(*),0) as TotalPayments, min(ENTERDATE) as FirstPaymentDate, max(ENTERDATE) as LastPaymentDate
		from rcbill.rcb_casa
		where
		(hard not in (100, 101, 102) or hard is null)
		group by clid, cid;
        
        */