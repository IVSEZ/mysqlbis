
select region, network
-- , clientclass, clienttype
, servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
-- where period=@rundate
group by region, network
-- , clientclass, clienttype
, servicecategory, package
order by region, network,servicecategory, package
-- with rollup
;


select region
-- , network
-- , clientclass, clienttype
, servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
-- where period=@rundate
group by region
-- , network
-- , clientclass, clienttype
, servicecategory, package
order by region, network,servicecategory, package
-- with rollup
;


select 
-- region
-- , network
-- , clientclass, clienttype
servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
-- where period=@rundate
group by 
-- region
-- , network
-- , clientclass, clienttype
-- , 
servicecategory, package
order by servicecategory, package
-- with rollup
;

select 
-- region
-- , network
-- , clientclass, clienttype
servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
where region='Mahe'
group by 
-- region
-- , network
-- , clientclass, clienttype
-- , 
servicecategory, package
order by servicecategory, package
-- with rollup
;

select 
-- region
-- , network
-- , clientclass, clienttype
servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
where region='Praslin'
group by 
-- region
-- , network
-- , clientclass, clienttype
-- , 
servicecategory, package
order by servicecategory, package
-- with rollup
;


select 
-- region
-- , network
-- , clientclass, clienttype
servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
where region='Mahe' and network='GPON'
group by 
-- region
-- , network
-- , clientclass, clienttype
-- , 
servicecategory, package
order by servicecategory, package
-- with rollup
;

select 
-- region
-- , network
-- , clientclass, clienttype
servicecategory, package 
-- , count(clientcode) as clientcount
, count(distinct clientcode) as accountcount
, sum(ServiceCount) as contractcount
, sum(activecount) as activecount
from rcbill_my.clientnetworkservicepkg 
where region='Mahe' and network='HFC'
group by 
-- region
-- , network
-- , clientclass, clienttype
-- , 
servicecategory, package
order by servicecategory, package
-- with rollup
;

select *
-- , min(firstcontractdate) 
from rcbill_my.customercontractsnapshot
where 
clientcode in 
(
select clientcode from rcbill_my.clientstats where services='Internet Only'
)

and CurrentStatus='Active'
and servicecategory='Internet'
order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
;


select *
-- , min(firstcontractdate) 
from rcbill_my.customercontractsnapshot
where 
clientcode in 
(
	select clientcode from 
    (


			select distinct clientcode, count(distinct network) as networkcount
			-- , min(firstcontractdate) 
			from rcbill_my.customercontractsnapshot
			where 
			clientcode in 
			(
			select clientcode from rcbill_my.clientstats where services='Internet Only'
			)

			and CurrentStatus='Active'
			-- and servicecategory='Internet'
			-- order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
			group by clientcode
			order by 2 desc
	) a 
    where networkcount>1
)    
and clientclass not in ('Corporate Large','USD_standard')
-- and CurrentStatus='Active'
;


select distinct clientcode, clientname, clientclass 
from 
(

	select *
	-- , min(firstcontractdate) 
	from rcbill_my.customercontractsnapshot
	where 
	clientcode in 
	(
		select clientcode from 
		(


				select 
                -- * 
                distinct clientcode, count(distinct network) as networkcount
				-- , min(firstcontractdate) 
				from rcbill_my.customercontractsnapshot
				where 
				clientcode in 
				(
				select clientcode from rcbill_my.clientstats where services='Internet Only'
				)

				and CurrentStatus='Active'
				-- and servicecategory='Internet'
				-- order by clientcode, lastcontractdate, contractcode, servicecategory, packagetype
				group by clientcode
				order by 2 desc
		) a 
		where networkcount>1
	)    
	and clientclass not in ('Corporate Large','USD_standard')
	and CurrentStatus='Active'


) a 
;