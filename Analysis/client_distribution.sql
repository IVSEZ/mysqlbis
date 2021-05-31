select * from rcbill_my.rep_custconsolidated limit 1000;

select coalesce(activenetwork, 'GRAND TOTAL') as activenetwork, Accounts
from 
(
	select ifnull(activenetwork,'INACTIVE') as activenetwork,count(*) as Accounts from rcbill_my.rep_custconsolidated group by 1 with rollup
) a ;

select activenetwork, clientarea, clientlocation
, count(clientcode)
from rcbill_my.rep_custconsolidated 
-- where IsAccountActive='Active'
group by 1,2,3
-- with rollup
;


drop table if exists rcbill_my.rep_activecutomerdistribution_level1;

create table rcbill_my.rep_activecustomerdistribution_level1 
as
(

	select coalesce(ISLAND,'GRAND TOTAL') as ISLAND
	, coalesce(DISTRICT,'--------------') as DISTRICT
	, ActiveAccounts_GPON, ActiveAccounts_HFC, ActiveAccounts_MIX
	from 
	(
		select 
		clientarea as ISLAND
		, clientlocation as DISTRICT
		, ifnull(sum(`ActiveAccounts_GPON`),0) as `ActiveAccounts_GPON` 
		, ifnull(sum(`ActiveAccounts_HFC`),0) as `ActiveAccounts_HFC` 
		, ifnull(sum(`ActiveAccounts_MIX`),0) as `ActiveAccounts_MIX` 

		from 
		(
			select clientarea, clientlocation, activenetwork
			, case when activenetwork='GPON' then count(clientcode) end as ActiveAccounts_GPON 
			, case when activenetwork='HFC' then count(clientcode) end as ActiveAccounts_HFC 
			, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveAccounts_MIX 
			-- , case when activenetwork is null then count(clientcode) end as ActiveAccounts_INACTIVE 

			from rcbill_my.rep_custconsolidated 
			where IsAccountActive='Active'
			group by 1,2,3
			-- with rollup
		) a 
		group by 1,2
		with rollup
	) a 

)
;


drop table if exists rcbill_my.rep_activecutomerdistribution_level2;

create table rcbill_my.rep_activecustomerdistribution_level2 
as
(
	select  coalesce(ISLAND,'GRAND TOTAL') as ISLAND
	, coalesce(DISTRICT,'--------------') as DISTRICT
	, coalesce(SUBDISTRICT,'--------------') as SUBDISTRICT
	, ActiveAccounts_GPON, ActiveAccounts_HFC, ActiveAccounts_MIX
	from
	(
		select clientarea as ISLAND, clientlocation as DISTRICT, subdistrict as SUBDISTRICT
		, ifnull(sum(`ActiveAccounts_GPON`),0) as `ActiveAccounts_GPON` 
		, ifnull(sum(`ActiveAccounts_HFC`),0) as `ActiveAccounts_HFC` 
		, ifnull(sum(`ActiveAccounts_MIX`),0) as `ActiveAccounts_MIX` 

		from 
		(
			select clientarea, clientlocation, subdistrict, activenetwork
			, case when activenetwork='GPON' then count(clientcode) end as ActiveAccounts_GPON 
			, case when activenetwork='HFC' then count(clientcode) end as ActiveAccounts_HFC 
			, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveAccounts_MIX 
			-- , case when activenetwork is null then count(clientcode) end as ActiveAccounts_INACTIVE 

			from rcbill_my.rep_custconsolidated 
			where IsAccountActive='Active'
			group by 1,2,3,4
			-- with rollup
		) a 
		group by 1,2,3
		 with rollup
	) a 
)
;



select clientarea, clientlocation, count(clientcode) as InActiveAccounts from rcbill_my.rep_custconsolidated 
where IsAccountActive='InActive'
group by 1,2;

select clientarea, clientlocation, subdistrict, count(clientcode) as ActiveAccounts from rcbill_my.rep_custconsolidated 
where IsAccountActive='Active'
group by 1,2,3;

select clientarea, clientlocation, subdistrict, count(clientcode) as InActiveAccounts from rcbill_my.rep_custconsolidated 
where IsAccountActive='InActive'
group by 1,2,3;