select date(max(PAYMENTDATE)) as LASTPAYMENTDATE from rcbill_my.onlinepayments;

select * from rcbill_my.onlinepayments order by PAYMENTDATE desc li;

select * from 
(
select 
-- date(paymentdate) as paymentdate
year(paymentdate) as paymentyear
, month(paymentdate) as paymentmonth
, day(paymentdate) as paymentday
, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1,2,3
-- with rollup
) t
order by 1 desc, 2 desc, 3 desc
-- limit 5
;

##REPORT TO FIND HOW MANY CUSTOMERS PAID ONLINE
select * from 
(
select 
-- date(paymentdate) as paymentdate, 
year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth
, count(distinct CLIENTCODE) as clients
, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1, 2
-- with rollup
) t
order by 1 desc, 2 desc
-- limit 5
-- with rollup
;


select 
-- coalesce(paymentyear, 'GRAND TOTAL') as payment_year
-- , coalesce(paymentmonth, 'TOTAL') as payment_month
-- , coalesce(monthname, 'TOTAL') as monthname
-- , 
monthname
, paymentyear, paymentmonth, paymentday
, sum(onlinepayments) as onlinepayments, sum(onlinepaymentamount) as onlinepaymentamount from 
(
select 
year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth, monthname(paymentdate) as monthname, day(max(date(paymentdate))) as paymentday, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1, 2, 3
-- with rollup
) t
group by paymentyear, paymentmonth
order by paymentyear desc, paymentmonth desc

;


select year(lastpaymentdate) as lastpaymentyear, month(lastpaymentdate) as lastpaymentmonth, day(lastpaymentdate) as lastpaymentday,
onlinepayments, onlinepaymentamount
from 
(
	select 
	year(paymentdate) as paymentyear, max(PAYMENTDATE) as lastpaymentdate, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
	from rcbill_my.onlinepayments
	group by 1
	order by 1 desc
) a
;

-- select * from rcbill_my.onlinepayments;
/*
select year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth, count(distinct clientcode) as d_clients
from rcbill_my.onlinepayments
group by 1, 2
;
*/

-- select * from rcbill_my.rep_paycol_channel;
-- select * from rcbill_my.rep_paycol_pos;
### REPORT FOR CHAIRMAN
select payyear, paymth, pay_pos, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_pos
group by 1,2,3
order by 1 desc, 2 desc, 4 desc
;


select payyear, paymth,  pay_channel, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_channel
group by 1,2,3
order by 1 desc, 2 desc, 4 desc
;
### REPORT FOR CHAIRMAN


select payyear, paymth, payday, pay_pos, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_pos
group by 1,2,3, 4
order by 1 desc, 2 desc, 3 desc, 5 desc
;


select payyear, paymth, payday, pay_channel, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_channel
group by 1,2,3, 4
-- with rollup
order by 1 desc, 2 desc, 3 desc, 5 desc
;