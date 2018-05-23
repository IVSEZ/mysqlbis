use rcbill_my;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-25032017-12052017-1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-01012017-06072017-1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-25112017-26112017-1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-26122017-1.csv' 
 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-24122017-25122017-1.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-01102017-26102017-1.csv' 
REPLACE INTO TABLE `rcbill_my`.`dailysales` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@SalesChannel ,
@SalesCenter ,
@CreatedBy ,
@Region ,
@OrderService ,
@ModelType ,
@OrderType ,
@State ,
@OrderID ,
@OrderDate ,
@ClientCode ,
@ClientClass ,
@Contract ,
@ContractType ,
@Service ,
@ServiceType ,
@Cost ,
@Price ,
@Num ,
@OriginalContract ,
@OriginalService ,
@OriginalServiceType ,
@OriginalPrice
) 
set 
SALESCHANNEL=@SalesChannel ,
SALESCENTER=@SalesCenter ,
CREATEDBY=@CreatedBy ,
REGION=@Region ,
ORDERSERVICE=@OrderService ,
MODELTYPE=@ModelType ,
ORDERTYPE=@OrderType ,
STATE=@State ,
ORDERID=@OrderID ,
ORDERDATE=str_to_date(@OrderDate,'%m/%d/%Y %H:%i'),	
CLIENTCODE=@ClientCode ,
CLIENTCLASS=@ClientClass ,
CONTRACT=@Contract ,
CONTRACTTYPE=@ContractType ,
SERVICE=@Service ,
SERVICETYPE=@ServiceType ,
COST=@Cost ,
PRICE=@Price ,

NUM=@Num ,
ORIGINALCONTRACT=@OriginalContract ,
ORIGINALSERVICE=@OriginalService ,
ORIGINALSERVICETYPE=@OriginalServiceType ,

ORIGINALPRICE=@OriginalPrice ,
CLEANORIGPRICE=GetCleanOrigPrice(@ContractType,@OriginalPrice),
CLEANORIGCOST=GetOrigCost(@OriginalService,@OriginalPrice),

INSERTEDON=now()

;


drop table if exists rcbill_my.sales;

create table rcbill_my.sales as 
(
select rcbill_my.GetCleanString(SALESCHANNEL) as saleschannel
, rcbill_my.GetCleanString(SALESCENTER) as salescenter
, rcbill_my.GetCleanString(CREATEDBY) as createdby
, region
, rcbill_my.GetCleanString(ORDERTYPE) as ordertype
, case 
	when rcbill_my.GetCleanString(ORDERTYPE) = "Convert Contracts" then "Renewals" 
    when rcbill_my.GetCleanString(ORDERTYPE) = "Adding Contracts" then "New Sales" 
    when rcbill_my.GetCleanString(ORDERTYPE) = "New Contracts" then "New Sales" 
    when rcbill_my.GetCleanString(ORDERTYPE) = "Renew Contract" then "Renewals" 
    when rcbill_my.GetCleanString(ORDERTYPE) = "Renew Contracts" then "Renewals" 
  end as `salestype`

, rcbill_my.GetCleanString(STATE) as state
, orderid, dayname(orderdate) as weekday, monthname(ORDERDATE) as ordermonth, date(orderdate) as orderday, orderdate, clientcode, clientclass, contract, contracttype, service, servicetype, cost, price, num, originalcontract, ORIGINALSERVICE, ORIGINALSERVICETYPE, ORIGINALPRICE, CLEANORIGCOST, CLEANORIGPRICE, insertedon

from rcbill_my.dailysales order by orderdate desc
)
;


-- CREATE TABLE SALES LIST
drop table if exists rcbill_my.saleslist;

create table rcbill_my.saleslist as
(
select distinct
salescenter, region, salestype, state, clientclass, contracttype, servicetype
from rcbill_my.sales
group by salescenter, region, salestype, state, clientclass, contracttype, servicetype
order by salescenter, region, salestype, state, clientclass, contracttype, servicetype
);

select * from rcbill_my.saleslist;



select * from rcbill_my.sales order by orderday desc;
select * from rcbill_my.sales where 
-- ordermonth='January' and 
 salestype='New Sales' 
 order by orderday desc;

-- select * from rcbill_my.sales where clientcode = 'I.000015879';

select orderday, rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, region, salestype, state, count(*) as salesorders from rcbill_my.sales
where 
-- ordermonth='January' and 
 salestype='New Sales' 
 and 
state in ('Open','Completed')
group by orderday, 2, region, salestype, state
order by orderday desc
-- with rollup
;




select servicetype, sum(num), count(*) 
from rcbill_my.sales
where 
ordermonth='December' 
and 
year(orderdate)=2017
and
salestype='New Sales' and state in ('Open','Completed')
and 
clientclass='Residential'
group by servicetype
-- order by orderday desc
with rollup
;

select orderday,rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, servicetype, sum(num), count(*) 
from rcbill_my.sales
where 
-- ordermonth='November' 
-- and 
year(orderdate)=2017
and
salestype='New Sales' and state in ('Open','Completed')
and 
clientclass='Residential'
and 
servicetype='Crimson'
group by orderday, 2, servicetype
-- order by orderday desc
-- with rollup
;


select ordermonth, orderday,rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, sum(num), count(*) 
from rcbill_my.sales
where 
-- ordermonth='November' 
-- and 
year(orderdate)=2017
and
salestype='New Sales' and state in ('Open','Completed')
and 
clientclass='Residential'
group by ordermonth, orderday,2
order by orderday desc
-- with rollup
;

select orderday, rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, region, salestype, state, count(*) as salesorders from rcbill_my.sales
where 
-- ordermonth='January' and 
-- salestype='New Sales' 
-- and 
state in ('Open','Completed')
group by orderday, 2, region, salestype, state
order by orderday desc

;


select orderday, rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, region, salestype, count(*) as salesorders from rcbill_my.sales
where 
-- ordermonth='January' and 
-- salestype='New Sales' 
-- and 
state in ('Open','Completed')
group by orderday, 2, region, salestype
order by orderday desc

;

-- select * from rcbill_my.sales;

select orderday,rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, servicetype, sum(num), count(*) 
from rcbill_my.sales
where 
-- ordermonth='November' 
-- and 
year(orderdate)=2017
and
salestype='New Sales' and state in ('Open','Completed')
and 
clientclass='Residential'
group by orderday,2, servicetype
-- order by orderday desc
with rollup
;




/*
select distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, ordertype, state 
order by 1 desc, region, SALESCENTER, ordertype, state;

select distinct date(orderdate) as orderdate, region, rcbill_my.GetCleanString(SALESCENTER) as SalesCenter, rcbill_my.GetCleanString(ordertype) as ordertype, 
rcbill_my.GetCleanString(state) as state, count(*) as orders from rcbill_my.dailysales
where state in ('Completed::10','Open::0')
group by 1, region, SALESCENTER, ordertype, state 
order by 1 desc, region, SALESCENTER, ordertype, state;

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
-- where state in ('Completed::10','Open::0')
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