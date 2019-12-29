


-- SET SESSION sql_mode = '';
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllUserActions2019-20122019.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_useractions` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_useractions` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@UserID ,
@StartTime ,
@Number ,
@EndTime ,
@Comment ,
@Label ,
@URL ,
@CLID ,
@CID ,
@PaymentID ,
@Amount 
) 
set 
ID=@ID ,
USERID=@UserID ,
STARTTIME=@StartTime ,
NUMBER=@Number ,
ENDTIME=@EndTime ,
COMMENT=@Comment ,
LABEL=@Label ,
URL=@URL ,
CLID=@CLID ,
CID=@CID ,
PAYMENTID=@PaymentID ,
AMOUNT=@Amount ,
INSERTEDON=now()

;

CREATE INDEX IDXUA1
ON rcb_useractions (ID);

CREATE INDEX IDXUA2
ON rcb_useractions (USERID);

CREATE INDEX IDXUA3
ON rcb_useractions (CLID);

CREATE INDEX IDXUA4
ON rcb_useractions (CID);

CREATE INDEX IDXUA5
ON rcb_useractions (PAYMENTID);

-- select * from rcbill.rcb_useractions where clid=717788;
select count(*) from rcbill.rcb_useractions;
