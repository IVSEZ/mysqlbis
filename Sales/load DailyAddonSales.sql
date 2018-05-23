use rcbill_my;


-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\PrepaidCardSales-03112017-05112017-P1.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01012017-31032017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01042017-30042017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01052017-31052017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01062017-30062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01072017-31072017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01082017-31082017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01092017-30092017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-01102017-31102017.csv'
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-24122017-25122017.csv'
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\Sales-Addon-26122017.csv'

REPLACE INTO TABLE `rcbill_my`.`dailyaddonsales` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
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

select * from rcbill_my.dailyaddonsales order by paymentdate desc;

select date(PAYMENTDATE) as paymentdate, rcbill_my.GetWeekdayName(weekday(PAYMENTDATE)) as weekday,
salestype, cashpoint, sum(paymentamount) as PAYMENT, (round((sum(paymentamount))/57.5)) as GB_ADDON, count(*) as Transactions
from rcbill_my.dailyaddonsales 
group by 1,2,3,4
order by 1 desc;


select clientcode, clientname, sum(paymentamount) as PaymentAmount
from rcbill_my.dailyaddonsales
group by clientcode, clientname
order by 3 desc
;

select clientcode, clientname, place, sum(paymentamount) as PaymentAmount
from rcbill_my.dailyaddonsales
group by clientcode, clientname, place
order by 4 desc
;

select month(PAYMENTDATE) as PayMonth, paymentamount, (round((paymentamount)/57.5)) as GB_ADDON, count(*)
from rcbill_my.dailyaddonsales
group by 1, 2, 3
order by 1 desc, 4 desc
-- with rollup
;

select month(PAYMENTDATE) as PayMonth, sum(paymentamount), count(*)
from rcbill_my.dailyaddonsales
group by 1
-- order by 1 desc
with rollup
;

select clientcode, clientname, month(PAYMENTDATE) as PayMonth,  sum(paymentamount) as PaymentAmount, (round(sum(paymentamount)/57.5)) as GB_ADDON
from rcbill_my.dailyaddonsales
group by clientcode, clientname, 3
order by PAYMENTDATE desc
;

/*
-- join it to customer contract activity
select a.clientcode, a.clientname, a.contractcode, b.package, sum(a.paymentamount) as PaymentAmount, (round(sum(a.paymentamount)/57.5)) as GB_ADDON
from 
rcbill_my.dailyaddonsales a 
left join
rcbill_my.customercontractactivity  b
on a.clientcode=b.clientcode and a.contractcode=b.contractcode
and date(a.PAYMENTDATE)=b.period
group by 1,2,3,4
;
*/

-- select * from rcbill_my.customercontractactivity where clientname like '%pauline cooper%' and servicecategory='Internet';