use rcbill_my;
#SET DATE
-- SET @REPORTDATE=str_to_date('2018-01-10','%Y-%m-%d');
-- SET @rundate='2018-01-10';

## change all csv dates 6 files

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-05052018-06052018-1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\SalesReport-16062018-1.csv' 
 
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

-- select * from rcbill_my.dailysales;

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

select count(1) as sales from rcbill_my.sales;

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

#####################################################################

# DAILY SINGLE SALES

use rcbill_my;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-05052018-06052018-P1.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-16062018-P1.csv' 

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

/*
SELECT trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 1),'/',-1)) as PrepaidType,
trim(SUBSTRING_INDEX(SUBSTRING_INDEX(salescomment, ',', 2),',',-1)) as ValidityPeriod
from dailysinglesales where date(entrydate)>='2017-06-01' and date(entrydate)<='2017-06-30';
*/

#####################################################################

# DAILY ADDON SALES

use rcbill_my;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-05052018-06052018.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-16062018.csv'

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
SET SQL_SAFE_UPDATES = 1;
*/

select count(1) as dailyaddonsales from rcbill_my.dailyaddonsales;
-- select * from rcbill_my.dailyaddonsales order by PAYMENTDATE desc;

-- ADDON REPORT FOR LYNSEY
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


##################################################################

# ONLINE PAYMENTS

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\eBarclays-PaymentsList-05052018-06052018.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\eBarclays-PaymentsList-16062018.csv' 
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

-- select * from rcbill_my.onlinepayments order by paymentdate desc;

-- select * from rcbill_my.onlinepayments where clientname like '%rahul%';

select * from 
(
select date(paymentdate) as paymentdate, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1
with rollup
) t
order by 1 desc
;


select * from 
(
select year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1, 2
with rollup
) t
order by 1 desc, 2 desc
;


#################################################################

# VOD TELEMETRY

-- SET SESSION sql_mode = '';
use rcbill;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-11052018-12052018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-16062018.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-16062018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()



;

select count(1) as vodtelemetry from rcb_vodtelemetry;

select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_vodtelemetry
group by 1
order by 1 desc;


########################################################

# TS TELEMETRY

-- SET SESSION sql_mode = '';
use rcbill;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-03092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-03092017-12092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-14092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-11052018-12052018.csv'

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-16062018.csv'
-- REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
-- OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllTSTelemetry-16062018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_tstelemetry` CHARACTER SET UTF8 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd 
) 
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=upper(trim(@Resource)) ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart ,
SESSIONEND=@SessionEnd ,

INSERTEDON=now()



;

select count(1) as tstelemetry from rcb_tstelemetry;


select date(SESSIONSTART) as sessiondate, rcbill_my.GetWeekdayName(weekday(date(SESSIONSTART))) as weekday, count(1) from rcbill.rcb_tstelemetry
group by 1
order by 1 desc;
##############################################################################