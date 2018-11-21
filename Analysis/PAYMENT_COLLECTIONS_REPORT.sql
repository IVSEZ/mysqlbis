set @startdate='2018-01-01';
set @enddate='2018-10-31';
set @startdate='2017-01-01';
set @enddate='2017-12-31';
set @startdate='2018-10-01';
set @enddate='2018-10-31';

/*
select * 
, paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
from rcbill.rcb_casa 	where
	(hard not in (100, 101, 102) or hard is null)
    and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate;

select week('2018-01-13 00:00:00',1), weekday('2018-01-13 00:00:00');
*/

## REPORT FOR PAYMENT COLLECTIONS
select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
from 
 rcbill.rcb_casa 
	-- only the residential customers
    -- (select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where CLClass=13)) tx
	where
	(hard not in (100, 101, 102) or hard is null)
   and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
    -- limit 100
    ;



-- CHANNEL
select date(PAYDATE) as paydate,day(PAYDATE) as payday, month(PAYDATE) as paymonth, year(PAYDATE) as payyear, weeknum, weekday, payobjectname as pay_channel, sum(money) as pay_amount
from 
(
	select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
	, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
	, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
	from 
    rcbill.rcb_casa 
	-- only the residential customers
    -- (select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where CLClass=13)) tx
    where
	(hard not in (100, 101, 102) or hard is null)
	and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
	-- limit 100
) a 
-- where payobjectname = 'CHEQUE'
group by 1,2,3,4,5,6,7
-- with rollup
; 




-- POS
select date(PAYDATE) as paydate, day(PAYDATE) as payday, month(PAYDATE) as paymonth, year(PAYDATE) as payyear, weeknum, weekday, cashpointname as pay_pos, sum(money) as pay_amount
from 
(
	select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
	, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
	, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
	from rcbill.rcb_casa 
	where
	(hard not in (100, 101, 102) or hard is null)
	-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
	-- limit 100
) a 
group by 1,2,3,4,5,6,7
; 



select sum(money) from rcbill.rcb_casa 
	where
	(hard not in (100, 101, 102) or hard is null)
    and date(PAYDATE)>='2018-01-01' and date(PAYDATE)<='2018-10-31'
    -- limit 100
    ;

select * from rcbill.rcb_casa limit 100;