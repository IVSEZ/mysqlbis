select * from rcbill_my.rep_custconsolidated limit 1000;

select coalesce(activenetwork, 'GRAND TOTAL') as activenetwork, clients
from 
(
	select ifnull(activenetwork,'INACTIVE') as activenetwork,count(*) as clients from rcbill_my.rep_custconsolidated group by 1 with rollup
) a ;

select activenetwork, clientarea, clientlocation
, count(clientcode)
from rcbill_my.rep_custconsolidated 
-- where IsAccountActive='Active'
group by 1,2,3
-- with rollup
;


select coalesce(ISLAND,'GRAND TOTAL') as ISLAND
, coalesce(DISTRICT,'DISTRICT TOTAL') as DISTRICT
, ActiveClients_GPON, ActiveClients_HFC, ActiveClients_MIX
from 
(
	select 
	clientarea as ISLAND
	, clientlocation as DISTRICT
	, ifnull(sum(`ActiveClients_GPON`),0) as `ActiveClients_GPON` 
	, ifnull(sum(`ActiveClients_HFC`),0) as `ActiveClients_HFC` 
	, ifnull(sum(`ActiveClients_MIX`),0) as `ActiveClients_MIX` 

	from 
	(
		select clientarea, clientlocation, activenetwork
		, case when activenetwork='GPON' then count(clientcode) end as ActiveClients_GPON 
		, case when activenetwork='HFC' then count(clientcode) end as ActiveClients_HFC 
		, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveClients_MIX 
		-- , case when activenetwork is null then count(clientcode) end as ActiveClients_INACTIVE 

		from rcbill_my.rep_custconsolidated 
		where IsAccountActive='Active'
		group by 1,2,3
		-- with rollup
	) a 
	group by 1,2
	with rollup
) a 
;


select  coalesce(ISLAND,'GRAND TOTAL') as ISLAND
, coalesce(DISTRICT,'DISTRICT TOTAL') as DISTRICT
, coalesce(SUBDISTRICT,'SUBDISTRICT TOTAL') as SUBDISTRICT
, ActiveClients_GPON, ActiveClients_HFC, ActiveClients_MIX
from
(
	select clientarea as ISLAND, clientlocation as DISTRICT, subdistrict as SUBDISTRICT
	, ifnull(sum(`ActiveClients_GPON`),0) as `ActiveClients_GPON` 
	, ifnull(sum(`ActiveClients_HFC`),0) as `ActiveClients_HFC` 
	, ifnull(sum(`ActiveClients_MIX`),0) as `ActiveClients_MIX` 

	from 
	(
		select clientarea, clientlocation, subdistrict, activenetwork
		, case when activenetwork='GPON' then count(clientcode) end as ActiveClients_GPON 
		, case when activenetwork='HFC' then count(clientcode) end as ActiveClients_HFC 
		, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveClients_MIX 
		-- , case when activenetwork is null then count(clientcode) end as ActiveClients_INACTIVE 

		from rcbill_my.rep_custconsolidated 
		where IsAccountActive='Active'
		group by 1,2,3,4
		-- with rollup
	) a 
	group by 1,2,3
-- 	 with rollup
) a 
;



select clientarea, clientlocation, count(clientcode) as InActiveClients from rcbill_my.rep_custconsolidated 
where IsAccountActive='InActive'
group by 1,2;

select clientarea, clientlocation, subdistrict, count(clientcode) as ActiveClients from rcbill_my.rep_custconsolidated 
where IsAccountActive='Active'
group by 1,2,3;

select clientarea, clientlocation, subdistrict, count(clientcode) as InActiveClients from rcbill_my.rep_custconsolidated 
where IsAccountActive='InActive'
group by 1,2,3;