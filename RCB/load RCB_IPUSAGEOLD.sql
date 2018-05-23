-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllIPUSAGE-01102016-31122016.csv' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllIPUSAGE-01012017-31122017.csv' 
-- REPLACE INTO TABLE `rcbill`.`rcb_comments` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
REPLACE INTO TABLE `rcbill`.`rcb_ipusageold` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
-- IGNORE 1 LINES 
IGNORE 2 LINES 
(
@USAGEID ,
@DEVICEID ,
@USAGEDATE ,
@TRAFFICTYPE ,
@CLIENTIP ,
@USAGEDIRECTION ,
@ZONEID ,
@TIMEZONEID ,
@INVNO ,
@OCTETS ,
@COST ,
@CURRENCY ,
@CID ,
@CSID ,
@SERVICEID ,
@COSTOLD 


) 
SET

USAGEID=@USAGEID ,
DEVICEID=@DEVICEID ,
USAGEDATE=@USAGEDATE ,
TRAFFICTYPE=@TRAFFICTYPE ,
CLIENTIP=@CLIENTIP ,
USAGEDIRECTION=@USAGEDIRECTION ,
ZONEID=@ZONEID ,
TIMEZONEID=@TIMEZONEID ,
INVNO=@INVNO ,
OCTETS=@OCTETS ,
COST=@COST ,
CURRENCY=@CURRENCY ,
CID=@CID ,
CSID=@CSID ,
SERVICEID=@SERVICEID ,
COSTOLD=@COSTOLD ,

INSERTEDON=now()

;



-- CREATE INDEX IDXipu1
-- ON rcb_ipusageold (cid);

-- drop index IDXipu1 on rcb_ipusageold;

/*
CREATE INDEX IDXtick5
ON rcb_ticketcomments (CID);

drop index IDXipu2 on rcb_ipusageold;

*/

CREATE INDEX IDXipu1
ON rcb_ipusageold (cid);


CREATE INDEX IDXipu2
ON rcb_ipusageold (csid);


CREATE INDEX IDXipu3
ON rcb_ipusageold (usagedate);

show index from rcb_ipusageold;

select count(*) from rcb_ipusageold;

-- select * from rcbill.rcb_ipusageold where date(usagedate)='2017-12-31';
-- where `comment` like '%intelba93%' ;
