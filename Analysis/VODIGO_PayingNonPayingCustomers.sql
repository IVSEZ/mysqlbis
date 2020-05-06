select a.*, rcbill.GetClientCode(a.clid) as clientcode, rcbill.GetContractCode(a.cid) as contractcode from rcbill.rcb_casa a order by a.id desc limit 100;
select * from rcbill_my.clientstats where (`IGO`>0 or `VOD`>0);

select * from rcbill_my.customercontractsnapshot
	where clientcode in 
	(
	select clientcode from rcbill_my.clientstats where (`IGO`>0 or `VOD`>0)
	)
	and CurrentStatus='Active'
;

set @startdate='2020-01-01';

drop temporary table if exists tempa1;
create temporary table tempa1(index idxa11(contractcode), index idxa12(clientcode)) as 
(
	select * from rcbill_my.customercontractsnapshot
		where clientcode in 
		(
		select clientcode from rcbill_my.clientstats where (`IGO`>0 or `VOD`>0)
		)
		and CurrentStatus='Active'
        and service in ('Subscription VOD','Subscription iGo')

);

select * from tempa1;

drop temporary table if exists tempa2;
create temporary table tempa2(index idxa21(contractcode), index idxa22(clientcode)) as 
(
		select * from 
        (
			select paydate, BegDate, EndDate
			, (select name from rcbill.rcb_users where id in (a.USERID)) as CASHIERNAME
			, clid
			, cid
			, rcbill.GetClientCode(a.clid) as clientcode, rcbill.GetContractCode(a.cid) as contractcode
			, money
			, (select name from rcbill.rcb_payobjects where id=payobjectid) as PayObjectName
			, (select name from rcbill.rcb_services where id=(paytype*-1)) as PayTypeName 
			, (select name from rcbill.rcb_cashpoints where id=cashpointid) as CashPointName
			from rcbill.rcb_casa a
			where
			(hard not in (100, 101, 102) or hard is null)
			and date(PAYDATE)>=@startdate -- and date(PAYDATE)<=@enddate
        ) a 
        where a.PayTypeName in ('SUBSCRIPTION IGO', 'SUBSCRIPTION VOD')
);

select * from tempa2;

select a.*,b.*
from 
tempa1 a 
left join
tempa2 b 
on 
-- a.clientcode=b.clientcode and 
a.contractcode=b.contractcode
and b.EndDate>=a.lastcontractdate
;



