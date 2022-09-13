select count(*) as rep_paycol_pos from rcbill_my.rep_paycol_pos;

select count(*) as rep_paycol_channel from rcbill_my.rep_paycol_channel;

select * from rcbill.rcb_payobjects;
select * from rcbill.rcb_cashpoints;

select * from rcbill_my.rep_paycol_pos where PAYYEAR>=2017 order by PAY_DATE desc;
select * from rcbill_my.rep_paycol_channel where PAYYEAR>=2017 order by PAY_DATE desc;
select * from rcbill_my.rep_paycol_usr where PAYYEAR>=2017 order by PAY_DATE desc;


select PAYYEAR, PAYMTH, USERNAME, USERID, sum(PAY_AMOUNT) as PAY_AMOUNT, sum(PAYMENTS) as PAYMENTS from rcbill_my.rep_paycol_usr where PAYYEAR>=2017 group by 1,2,3,4 order by 1 desc, 2 desc;


-- SELECT paydate as PAY_DATE, weekday as WEEK_DAY, UserName as COL_NAME, pay_amount as PAY_AMT from rcbill_my.rep_paycol_pos order by paydate asc;


select * from rcbill.rcb_casa_2 where PAY_DATE='2022-09-04' and CASHPOINTNAME='DOUBLE CLICK MERCHANT CASH POINT';
select * from rcbill.rcb_casa_2 where PAY_DATE='2022-09-05' and PAYOBJECTNAME='CASH';
select * from rcbill.rcb_casa_2 where PAY_DATE='2022-09-05' and USERNAME='Solina';


select *, date(paydate) as pay_date, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday, money
, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
, (select a.name from rcbill.rcb_users a  where a.ID=c.USERID limit 1) as UserName
from rcbill.rcb_casa c
where
(hard not in (100, 101, 102) or hard is null)
-- and date(PAYDATE)>=@startdate and date(PAYDATE)<=@enddate
-- limit 100
-- and year(paydate)>=2017
-- and date(PAYDATE)='2018-04-30'
;

USE rcbill;
drop table if exists rcbill.rcb_casa_2;

create table rcbill.rcb_casa_2 as 
(
select a.*, date(a.paydate) as PAY_DATE, week(a.PAYDATE,1) as WEEKNUM, rcbill_my.GetWeekdayName(weekday(a.paydate)) as WEEKDAY
-- , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
-- , (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
-- , (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
-- , (select a.name from rcbill.rcb_users a  where a.ID=c.USERID limit 1) as UserName
, b.name as PAYOBJECTNAME 
, c.name as PAYTYPENAME
, d.name as CASHPOINTNAME
, e.name as USERNAME
from rcbill.rcb_casa a
left join rcbill.rcb_payobjects b on b.id=a.payobjectid
left join rcbill.rcb_services c on c.id=(a.paytype*-1)
left join rcbill.rcb_cashpoints d on d.id=a.cashpointid
left join rcbill.rcb_users e on e.id=a.USERID
where
(a.hard not in (100, 101, 102) or a.hard is null)
)
;


CREATE INDEX IDXCASA1
ON rcb_casa_2 (ID);

CREATE INDEX IDXCASA2
ON rcb_casa_2 (CLID);

CREATE INDEX IDXCASA3
ON rcb_casa_2 (CID);

CREATE INDEX IDXCASA4
ON rcb_casa_2 (INVID);


-- drop index IDXCASA5 ON rcb_casa;
CREATE INDEX IDXCASA5
ON rcb_casa_2 (CLID, CID, RSID);


CREATE INDEX IDXCASA6
ON rcb_casa_2 (PAY_DATE, USERID, USERNAME);
CREATE INDEX IDXCASA7
ON rcb_casa_2 (PAY_DATE, PAYOBJECTID, PAYOBJECTNAME);
CREATE INDEX IDXCASA8
ON rcb_casa_2 (PAY_DATE, CashPointID, CASHPOINTNAME);
CREATE INDEX IDXCASA9
ON rcb_casa_2 (PAY_DATE, PAYTYPE, PAYTYPENAME);




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
