use rcbill_my;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-01012017-14092017-P1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-15092017-17092017-P1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-23092017-24092017-P1.csv' 

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-01012017-30092017-P1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-24122017-25122017-P1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-26122017-P1.csv' 

REPLACE INTO TABLE `rcbill_my`.`dailysinglesales` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ssalesid ,
@ClientId ,
@ID ,
@ExternalReference ,
@EntryDate ,
@User ,
@CASHPOINT ,
@ClientCode ,
@ClientName ,
@SerialNo ,
@UserName ,
@Amount ,
@Place ,
@SalesType ,
@Debtperiod ,
@SalesComment
) 
set 
SSALESID=@ssalesid ,
CLIENTID=@ClientId ,
EXTERNALREFERENCE=@ExternalReference ,
ENTRYDATE=str_to_date(@EntryDate,'%m/%d/%Y %H:%i') ,
USER=@User ,
CASHPOINT=@CASHPOINT ,
CLIENTCODE=@ClientCode ,
CLIENTNAME=@ClientName ,
SERIALNO=@SerialNo ,
USERNAME=@UserName ,
AMOUNT=@Amount ,
PLACE=@Place ,
SALESTYPE=@SalesType ,
DEBTPERIOD=@Debtperiod,
SALESCOMMENT=@SalesComment ,
INSERTEDON=now()

;



select * from rcbill_my.dailysinglesales order by entrydate desc;

select * from rcbill_my.dailysinglesales where salescomment like '%free%' order by entrydate desc;

-- select * from rcbill_my.dailysinglesales where salescomment like '%free%' and user like '%dom%' order by entrydate desc;


select distinct date(entrydate) as entrydate, clientname, count(*) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
where clientname = 'HIKVISION'
group by 1,2
-- order by 1 desc
with rollup
;


select distinct date(entrydate) as entrydate, rcbill_my.GetWeekdayName(weekday(entrydate)) as weekday, clientname, place, count(*) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
group by 1,2,3,4
order by 1 desc;
/*
select distinct date(orderdate) as orderdate, state, count(*) from rcbill_my.dailysales
group by date(orderdate), state
order by date(orderdate) desc
;

select distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, ordertype, state 
order by 1 desc, region, SALESCENTER, ordertype, state;

select distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(CREATEDBY) as createdby,
 rcbill_my.GetCleanString(ordertype) as ordertype, 
 count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, CREATEDBY, ordertype 
order by 1 desc, region, SALESCENTER, CREATEDBY, ordertype;



select distinct date(orderdate) as orderdate, rcbill_my.GetCleanString(CREATEDBY) as createdby, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, CREATEDBY, ordertype, state 
order by 1 desc, CREATEDBY, ordertype, state;

select distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
servicetype, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, ordertype, servicetype 
order by 1 desc, region, SALESCENTER, ordertype, servicetype;

select region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by region, SALESCENTER, ordertype 
order by region, SALESCENTER, ordertype;

select rcbill_my.GetCleanString(ordertype) as ordertype
from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by  ordertype 
order by ordertype;

select rcbill_my.GetCleanString(SALESCENTER) as SalesCenter
from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by  SalesCenter 
order by SalesCenter;

select region
from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by  region 
order by region;
*/
/*
select a.clientcode, a.clientclass, a.contract, a.contracttype, a.servicetype, a.cost, a.price, a.orderdate, a.ordertype, a.state
from dailysales a
where 
state in ('Completed::10','Open::0')
order by orderdate, clientcode
;
*/