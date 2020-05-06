#PAYMENT COLLECTIONS
-- select * from rcbill.rcb_casa order by id desc limit 100;

-- drop table if exists rcbill_my.rep_paycol_channel;
-- create table rcbill_my.rep_paycol_channel as 
-- (
	select month(PAYDATE) as paymth, year(PAYDATE) as payyear
    , payobjectname as pay_channel
    , count(distinct clid) as d_clients
    , sum(money) as pay_amount
	from 
	(
		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday
        , clid
        , money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		from rcbill.rcb_casa 
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
	) a 
	group by 1,2,3
    -- order by 2 desc-- , 1 desc
-- )
; 
-- select count(*) as rep_paycol_channel from rcbill_my.rep_paycol_channel;

-- drop table if exists rcbill_my.rep_paycol_pos;
-- create table rcbill_my.rep_paycol_pos as 
-- (
	select month(PAYDATE) as paymth, year(PAYDATE) as payyear
    , cashpointname as pay_pos
    , count(distinct clid) as d_clients
    , sum(money) as pay_amount
	from 
	(
		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday
        , clid
        , money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		from rcbill.rcb_casa 
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
	) a 
	group by 1,2,3
    -- order by 2 desc , 1 desc
-- )
; 
-- select count(*) as rep_paycol_pos from rcbill_my.rep_paycol_pos;
