#PAYMENT COLLECTIONS
-- select * from rcbill.rcb_casa order by id desc limit 100;

set @startdate='2020-01-01';

		select paydate, week(PAYDATE,1) as weeknum, rcbill_my.GetWeekdayName(weekday(paydate)) as weekday
        , (select name from rcbill.rcb_users where id in (a.USERID)) as CASHIERNAME
        , clid
        , money
        , (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
		, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
		, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
		from rcbill.rcb_casa a
		where
		(hard not in (100, 101, 102) or hard is null)
		and date(PAYDATE)>=@startdate -- and date(PAYDATE)<=@enddate
        ;
        
        

