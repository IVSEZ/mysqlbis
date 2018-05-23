-- SET SESSION sql_mode = '';

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllComments-26122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@ID ,
@CLID ,
@CID ,
@CommentDate ,
@Comment ,
@ID_OLD ,
@UpdDate ,
@USERID 


) 
SET
ID=@ID ,
CLID=@CLID ,
CLIENTCODE = GetClientCode(@CLID),
CID=@CID ,
CONTRACTCODE = GetContractCode(@CID),


COMMENTDATE=@CommentDate ,
COMMENT=@Comment ,
UPDDATE=@UpdDate ,
USERID=@USERID ,

INSERTEDON=now()

;



CREATE INDEX IDXccc1
ON rcb_comments (ClientCode, ContractCode);


/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);

drop index IDXtc4 on rcb_comments;

*/
show index from rcb_comments;

select count(*) from rcb_comments;

select * from rcbill.rcb_comments;
-- where `comment` like '%intelba93%' ;
