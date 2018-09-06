select date(max(PAYMENTDATE)) as LASTPAYMENTDATE from rcbill_my.onlinepayments;


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


select * from 
(
select 
-- date(paymentdate) as paymentdate, 
year(paymentdate) as paymentyear, month(paymentdate) as paymentmonth, count(1) as onlinepayments, sum(paymentamount) as onlinepaymentamount 
from rcbill_my.onlinepayments
group by 1, 2
with rollup
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
