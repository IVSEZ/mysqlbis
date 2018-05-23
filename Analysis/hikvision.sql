

select distinct date(entrydate) as entrydate, clientname, place, count(*) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION')
group by 1,2,3
-- with rollup
order by 1 desc

;


select * from rcbill_my.dailysinglesales ;

select distinct date(entrydate) as entrydate, clientname, place, amount, DEBTPERIOD, SALESCOMMENT
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION')
-- group by 1,2,3
-- with rollup
order by 1 desc

;

select distinct date(entrydate) as entrydate, clientname, count(*) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION') and date(entrydate)<'2017-10-23'
group by 1,2
-- with rollup
order by 1 desc

;


select distinct month(entrydate) as entrymonth, clientname, count(*) as salescount, sum(amount) as salesamount
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION') and date(entrydate)<'2017-10-23'
group by 1,2
-- with rollup
order by 1 desc

;

select * from 
(
select year(entrydate) as paymentyear, month(entrydate) as paymentmonth,clientname, count(*) as salescount, sum(amount) as salesamount 
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION')
group by 1, 2
with rollup
) t
order by 1 desc, 2 desc
;

select * from 
(
select year(entrydate) as paymentyear, month(entrydate) as paymentmonth,clientname, count(*) as salescount, sum(amount) as salesamount 
from rcbill_my.dailysinglesales 
where CLIENTNAME in ('HIKVISION') and date(entrydate)<='2017-10-31'
group by 1, 2
with rollup
) t
order by 1 desc, 2 desc
;