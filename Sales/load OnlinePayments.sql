-- SET SESSION sql_mode = '';

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\eBarclays-PaymentsList-01012017-30092017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\eBarclays-PaymentsList-24122017-25122017.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\DailySales\\eBarclays-PaymentsList-26122017.csv' 
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


select count(*) from rcbill_my.onlinepayments;

select * from rcbill_my.onlinepayments order by paymentdate desc;

-- select * from rcbill_my.onlinepayments where clientname like '%rahul%';

select * from 
(
select date(paymentdate) as paymentdate, count(*) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1
with rollup
) t
order by 1 desc
;


select * from 
(
select month(paymentdate) as paymentmonth, count(*) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1
with rollup
) t
order by 1 desc
;

select date(paymentdate) as paymentdate, service, count(*), sum(paymentamount) 
from rcbill_my.onlinepayments
group by 1, 2
order by 1 desc;

select date(paymentdate) as paymentdate, package, count(*), sum(paymentamount) 
from rcbill_my.onlinepayments
group by 1, 2
order by 1 desc;

select clientcode, clientname, count(*) as payments, sum(paymentamount) as paymentamount
from rcbill_my.onlinepayments
group by 1,2
order by sum(paymentamount) desc, clientname;

select clientcode, clientname, package, count(*) as payments, sum(paymentamount) as paymentamount
from rcbill_my.onlinepayments
group by 1,2, 3
order by clientname;

-- select * from rcbill_my.clientstats where clientname = 'ABISON DE GIORGIO';
-- select * from rcbill.clientextendedreport where cl_clientname = 'ABISON DE GIORGIO';

select a.*, b.* 
from 
(
select clientcode, clientname, package, count(*) as onlinepayments, sum(paymentamount) as onlinepaymentamount, min(paymentdate) as firstonlinepayment, max(paymentdate) as lastonlinepayment
from rcbill_my.onlinepayments
group by 1,2, 3
order by clientname
) a 
inner join 
rcbill.clientextendedreport b
on a.clientcode=b.cl_clientcode
order by a.onlinepaymentamount
;