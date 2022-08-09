select count(*) as rep_paycol_pos from rcbill_my.rep_paycol_pos;

select count(*) as rep_paycol_channel from rcbill_my.rep_paycol_channel;

select * from rcbill.rcb_payobjects;
select * from rcbill.rcb_cashpoints;

select * from rcbill_my.rep_paycol_pos where year(paydate)>=2017;

select * from rcbill_my.rep_paycol_channel where year(paydate)>=2017;
select * from rcbill_my.rep_paycol_usr where year(paydate)>=2017;

SELECT paydate as PAY_DATE, weekday as WEEK_DAY, UserName as COL_NAME, pay_amount as PAY_AMT from rcbill_my.rep_paycol_pos order by paydate asc

		select *, paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		, (select a.name from rcbill.rcb_users a  where a.ID=c.USERID limit 1) as UserName
		from rcbill.rcb_casa c
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
        -- and year(paydate)>=2022
        and date(PAYDATE)='2022-08-05'
        ;


select * from rcbill.rcb_tickettechusers;
select * from rcbill.rcb_users;

drop table if exists rcbill_my.rep_paycol_usr;
create table rcbill_my.rep_paycol_usr as 
(
	select date(PAYDATE) as paydate, day(PAYDATE) as payday, month(PAYDATE) as paymth, year(PAYDATE) as payyear, weeknum, weekday, UserName, sum(money) as pay_amount
	from 
	(
		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
        -- , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		-- , (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		-- , (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
        , (select a.name from rcbill.rcb_users a  where a.ID=c.USERID limit 1) as UserName
		from rcbill.rcb_casa c
		where
		(hard not in (100, 101, 102) or hard is null)
		-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
		-- limit 100
	) a 
	group by 1,2,3,4,5,6,7
    order by 1 desc
)
; 
select count(*) as rep_paycol_usr from rcbill_my.rep_paycol_usr;

select * from rcbill_my.rep_paycol_usr;
