use rcbill_my;
#SET DATE
-- SET @REPORTDATE=str_to_date('2018-01-10','%Y-%m-%d');
-- SET @rundate='2018-01-10';

## change all csv dates 6 files

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\SalesReport-25082019-02092019-1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\SalesReport-10082020-1.csv' 
 
REPLACE INTO TABLE `rcbill_my`.`dailysales` CHARACTER SET LATIN1 FIELDS TERMINATED BY ',' 
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

select count(1) as dailysales from rcbill_my.dailysales;

-- select * from rcbill_my.dailysales order by insertedon desc;
-- set SQL_SAFE_UPDATES=0;
-- delete from rcbill_my.dailysales where insertedon='2018-10-18 11:08:32';

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
, case 
	when rcbill_my.GetCleanString(STATE) = "Canceled" then "Cancelled" 
    when rcbill_my.GetCleanString(STATE) = "Canceled Officialy" then "Cancelled" 
    when rcbill_my.GetCleanString(STATE) = "Completed" then "Processed" 
    when rcbill_my.GetCleanString(STATE) = "Open" then "Processed" 
    when rcbill_my.GetCleanString(STATE) = "Rejected" then "Rejected" 
    when rcbill_my.GetCleanString(STATE) = "Double" then "Double" 
  end as `orderstatus`
, orderid, dayname(orderdate) as weekday, monthname(ORDERDATE) as ordermonth, date(orderdate) as orderday, orderdate, clientcode, clientclass, contract as contractcode, contracttype, service, servicetype, cost, price, num, originalcontract, ORIGINALSERVICE, ORIGINALSERVICETYPE, ORIGINALPRICE, CLEANORIGCOST, CLEANORIGPRICE, insertedon

from rcbill_my.dailysales order by orderdate desc
)
;

select count(1) as sales from rcbill_my.sales;

################################################################################################
#REPORTS FOR SALES

drop table if exists rcbill_my.rep_dailysales;
CREATE TABLE rcbill_my.rep_dailysales AS (SELECT orderday,
    weekday,
    salescenter,
    salestype,
    COUNT(*) AS ordercount FROM
    rcbill_my.sales
WHERE
    0 = 0 AND orderstatus = 'Processed'
GROUP BY 1 , 2 , 3 , 4
ORDER BY orderday , salescenter , salestype);

select count(1) as rep_dailysales from rcbill_my.rep_dailysales;
-- select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;
/*
drop table if exists rcbill_my.rep_dailysalesreg;
create table rcbill_my.rep_dailysalesreg as
(
		select orderday, weekday, region, salescenter, salestype, count(*) as ordercount
		from rcbill_my.sales
		where 
		0=0
		and orderstatus='Processed'
		group by 1,2,3,4,5

		order by orderday ,salescenter, salestype, region        

);
*/


drop table if exists rcbill_my.rep_dailysalesreg;
create table rcbill_my.rep_dailysalesreg as
(
	select orderday, weekday, salescenter, salestype, sum(`MAHE`) as `Mahe`, sum(`PRASLIN`) as `Praslin`, sum(`UNKNOWN`) as `Unknown`
    from 
    (
		select orderday, weekday, salescenter, salestype
			,case region when 'MAHE' then sum(ordercount) else 0  end as `MAHE`
			,case region when 'PRASLIN' then sum(ordercount) else 0 end as `PRASLIN`
			,case region when '' then sum(ordercount) else 0 end as `UNKNOWN`
            -- case when as ordercount
		from
        (
			select orderday, weekday, upper(trim(region)) as region, salescenter, salestype, count(*) as ordercount
			from rcbill_my.sales
			where 
			0=0
			and orderstatus='Processed'
			group by 1,2,3,4,5    
            -- order by orderday desc
             
        ) a
		group by 1,2,3,4, region

		-- order by orderday DESC ,salescenter, salestype        
	) a 
    group by 1,2,3,4
);

select count(1) as rep_dailysalesreg from rcbill_my.rep_dailysalesreg;
-- select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;

################################################################################################

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

select count(1) as saleslist from rcbill_my.saleslist;

/*
select orderday, rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, region, salestype, state, count(1) as salesorders from rcbill_my.sales
where 
-- ordermonth='January' and 
--  salestype='New Sales' 
-- and 
state in ('Open','Completed')
group by orderday, 2, region, salestype, state
order by orderday desc, region, salestype
-- with rollup
;
*/

/*
select orderday, rcbill_my.GetWeekdayName(weekday(orderdate)) as weekday, region, salestype, state, count(1) as salesorders from rcbill_my.sales
where 
-- ordermonth='January' and 
salestype='New Sales' 
and 
state in ('Open','Completed')
group by orderday, 2, region, salestype, state
order by orderday desc, region, salestype
-- with rollup
;
*/
#####################################################################

# DAILY SINGLE SALES

use rcbill_my;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\PrepaidCardSales-25082019-02092019-P1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\PrepaidCardSales-10082020-P1.csv' 

REPLACE INTO TABLE `rcbill_my`.`dailysinglesales` CHARACTER SET LATIN1 FIELDS TERMINATED BY ',' 
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



select count(1) as dailysinglesales from rcbill_my.dailysinglesales;

-- select * from rcbill_my.dailysinglesales order by insertedon desc;
-- delete from rcbill_my.dailysinglesales where insertedon='2018-10-18 11:08:43';
/*
select distinct date(entrydate) as entrydate, rcbill_my.GetWeekdayName(weekday(entrydate)) as weekday
, clientname
, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as PrepaidType
, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as ValidityPeriod
, place
, count(1) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
group by 1,2,3,4,5,6
order by 1 desc;
*/

-- PREPAID AND CAMERA REPORT FOR LYNSEY
/*
select distinct date(entrydate) as entrydate, rcbill_my.GetWeekdayName(weekday(entrydate)) as weekday
, clientname
, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as PrepaidType
, trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as ValidityPeriod
, place
, cashpoint
, count(1) as salescount, sum(amount) as salesamount

from rcbill_my.dailysinglesales 
group by 1,2,3,4,5,6, 7
order by 1 desc;
*/


/*
SELECT trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as PrepaidType,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as ValidityPeriod
from dailysinglesales where date(entrydate)>='2017-06-01' and date(entrydate)<='2017-06-30';
*/

#####################################################################

# DAILY ADDON SALES

use rcbill_my;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\Sales-Addon-25082019-02092019.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\Sales-Addon-10082020.csv'

REPLACE INTO TABLE `rcbill_my`.`dailyaddonsales` CHARACTER SET LATIN1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ClientId ,
@SalesId ,
@ExternalRef ,
@PaymentDate ,
@ClientCode ,
@ClientName ,
@PaymentAmount ,
@SalesType ,
@DebtPeriod ,
@Place ,
@CashPoint ,
@ConfirmStatus ,
@SalesComment ,
@ContractCode ,
@CancellationReason ,
@ReceiptID 
) 
set 
SALESID=@SalesId ,
CLIENTID=@ClientId ,
EXTERNALREF=@ExternalRef ,
-- PAYMENTDATE=str_to_date(@PaymentDate,'%Y-%m-%d %H:%i:%s')  ,
PAYMENTDATE=str_to_date(@PaymentDate,'%m/%d/%Y %H:%i')  ,
CLIENTCODE=@ClientCode ,
CLIENTNAME=@ClientName ,
PAYMENTAMOUNT=@PaymentAmount ,
SALESTYPE=@SalesType ,
DEBTPERIOD=@DebtPeriod ,
PLACE=@Place ,
CASHPOINT=@CashPoint ,
CONFIRMSTATUS=@ConfirmStatus ,
SALESCOMMENT=@SalesComment ,
CONTRACTCODE=@ContractCode ,
CANCELLATIONREASON=@CancellationReason ,
RECEIPTID=@ReceiptID ,

INSERTEDON=now()

;

/*
SET SQL_SAFE_UPDATES = 0;
-- delete from rcbill_my.dailyaddonsales where paymentdate = '2017-11-08 00:00:00';
delete from rcbill_my.dailyaddonsales where paymentdate is null;


select * from rcbill_my.dailyaddonsales order by insertedon desc;
delete from rcbill_my.dailyaddonsales where insertedon='2018-10-18 11:08:43';

SET SQL_SAFE_UPDATES = 1;
*/

select count(1) as dailyaddonsales from rcbill_my.dailyaddonsales;
-- select * from rcbill_my.dailyaddonsales order by PAYMENTDATE desc;

-- ADDON REPORT FOR LYNSEY
/*
select a.*, b.clientclass, b.clienttype 
from 
rcbill_my.dailyaddonsales a
left join 
rcbill_my.customercontractactivity b
on
a.CLIENTCODE=b.clientcode
and 
a.CONTRACTCODE=b.contractcode
and
date(a.paymentdate)=b.period
order by a.paymentdate desc
;
*/

/*
-- commented on 08012019
select date(PAYMENTDATE) as paymentdate, rcbill_my.GetWeekdayName(weekday(PAYMENTDATE)) as weekday,
salestype, cashpoint, sum(paymentamount) as PAYMENT, (round((sum(paymentamount))/57.5)) as GB_ADDON, count(1) as Transactions
from rcbill_my.dailyaddonsales 
group by 1,2,3,4
order by 1 desc;




select clientcode, clientname, sum(paymentamount) as PaymentAmount
from rcbill_my.dailyaddonsales
group by clientcode, clientname
order by 3 desc
;
*/

##################################################################

# ONLINE PAYMENTS

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\eBarclays-PaymentsList-25082019-02092019.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\_csv\\eBarclays-PaymentsList-10082020.csv' 
REPLACE INTO TABLE `rcbill_my`.`onlinepayments` CHARACTER SET Latin1 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@ClientID ,
@PaymentID ,
@ExternalRef ,
@PaymentDate ,
@User ,
@CashPoint ,
@ClientCode ,
@ClientName ,
@PaymentAmount ,
@PaymentPlace ,
@Service ,
@Package ,
@DebtPeriod ,
@PaymentComment ,
@ClientClass ,
@ContractCode ,
@CancellationReason ,
@ReceiptID 

) 
set 
 
CLIENTID=@ClientID ,
PAYMENTID=@PaymentID ,
EXTERNALREF=upper(trim(@ExternalRef)) ,
PAYMENTDATE=str_to_date(@PaymentDate,'%m/%d/%Y %H:%i:%s') ,
-- PAYMENTDATE=@PaymentDate,
USER=upper(trim(@User)),
CASHPOINT=upper(trim(@CashPoint)) ,
CLIENTCODE=@ClientCode ,
CLIENTNAME=upper(trim(@ClientName)) ,
PAYMENTAMOUNT=@PaymentAmount ,
PAYMENTPLACE=upper(trim(@PaymentPlace)) ,
SERVICE=@Service ,
PACKAGE=@Package ,
DEBTPERIOD=@DebtPeriod ,

DEBTPERIODFROM=str_to_date(SUBSTRING_INDEX(@DebtPeriod,';',1),'%Y-%m-%d'),
DEBTPERIODTO=str_to_date(SUBSTRING_INDEX(@DebtPeriod,';',-1),'%Y-%m-%d'),

PAYMENTCOMMENT=upper(trim(@PaymentComment)) ,
CLIENTCLASS=rcbill_my.GetCleanString(@ClientClass) ,
CONTRACTCODE=upper(trim(@ContractCode)) ,
CANCELLATIONREASON=upper(trim(@CancellationReason)) ,
RECEIPTID=@ReceiptID ,


INSERTEDON=now()

;


select count(1) as onlinepayments from rcbill_my.onlinepayments;

-- select * from rcbill_my.onlinepayments where date(paymentdate)='2019-08-01' order by paymentdate desc;
-- select * from rcbill_my.onlinepayments where externalref like '%5430431440000329138%' order by paymentdate desc;
-- select * from rcbill_my.onlinepayments where clientname like '%rahul%';

/*

select * from rcbill_my.onlinepayments order by insertedon desc;
delete from rcbill_my.onlinepayments where insertedon='2018-10-18 11:08:43';

set sql_update_on=0;

delete from rcbill_my.onlinepayments where clientid=0;

*/

select * from 
(
select date(paymentdate) as paymentdate, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1
with rollup
) t
order by 1 desc
limit 5
;


select * from 
(
select year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1, 2
with rollup
) t
order by 1 desc, 2 desc
limit 5
;

