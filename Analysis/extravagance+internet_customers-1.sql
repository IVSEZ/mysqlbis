/*
select * from rcbill_my.clientstats where (DualView>0 or MultiView>0 or IGO>0 or VOD>0) ; -- and clientclass in ('EMPLOYEE','INTELVISION OFFICE');


select * from rcbill_my.rep_custconsolidated
where clientcode in 
(
	select clientcode from rcbill_my.clientstats where (DualView>0 or MultiView>0 or IGO>0 or VOD>0) -- and clientclass in ('EMPLOYEE','INTELVISION OFFICE')
)
;

select * from rcbill_my.customers_contracts_collection_pivot
where clientcode in 
(
	select clientcode from rcbill_my.clientstats where (DualView>0 or MultiView>0 or IGO>0 or VOD>0) -- and clientclass in ('EMPLOYEE','INTELVISION OFFICE')
)

;
*/

select * from  rcbill_my.customercontractactivity where period='2020-07-01';

select clientclass, count(*) from rcbill_my.customercontractactivity where period='2020-07-01' 
group by clientclass
;
select period, count(*) from rcbill_my.customercontractactivity
where clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
group by period
;

select period, count(*) from rcbill_my.customercontractactivity
where clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
and 
(
package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE')
or 
servicecategory in ('Internet')
)
group by period
;

select period, count(*) from rcbill_my.customercontractactivity
where clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
and 
(
package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE','AMBER','AMBER CORPORATE')

)
group by period
;

select period, clientcode, clientclass, network, package from rcbill_my.customercontractactivity
where clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
and 
(
package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE','AMBER','AMBER CORPORATE')

)
;



select period, clientcode, clientclass
, sum(Extravagance) as `Extravagance`
, sum(Amber) as `Amber`
from 
(
	select period, clientcode, clientclass
	, case when package = 'Extravagance' or package = 'Extravagance Corporate' then 1 else 0 end as `Extravagance`
	, case when package = 'Amber' or package = 'Amber Corporate' then 1 else 0 end as `Amber`
	from 
	(
	select period, clientcode, clientclass, network, package from rcbill_my.customercontractactivity
	where 
	-- clientcode ='I.000018187' and 
	clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
	and 
	(
	package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE','AMBER','AMBER CORPORATE')
	)


	) a 
	group by period, clientcode, clientclass, package
) a 
group by period, clientcode, clientclass
;

select *
from 
(

	select period, clientcode, clientclass
	, sum(Extravagance) as `Extravagance`
	, sum(Amber) as `Amber`
	from 
	(
		select period, clientcode, clientclass
		, case when package = 'Extravagance' or package = 'Extravagance Corporate' then 1 else 0 end as `Extravagance`
		, case when package = 'Amber' or package = 'Amber Corporate' then 1 else 0 end as `Amber`
		from 
		(
		select period, clientcode, clientclass, network, package from rcbill_my.customercontractactivity
		where 
		-- clientcode ='I.000018187' and 
		clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
		and 
		(
		package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE','AMBER','AMBER CORPORATE')
		)


		) a 
		group by period, clientcode, clientclass, package
	) a 
	group by period, clientcode, clientclass
) a 
where `Extravagance`>0 and `Amber`>0
-- group by period, clientclass
;

select period, clientclass, count(*)
from 
(

	select period, clientcode, clientclass
	, sum(Extravagance) as `Extravagance`
	, sum(Amber) as `Amber`
	from 
	(
		select period, clientcode, clientclass
		, case when package = 'Extravagance' or package = 'Extravagance Corporate' then 1 else 0 end as `Extravagance`
		, case when package = 'Amber' or package = 'Amber Corporate' then 1 else 0 end as `Amber`
		from 
		(
		select period, clientcode, clientclass, network, package from rcbill_my.customercontractactivity
		where 
		-- clientcode ='I.000018187' and 
		clientclass in ('Corporate','Corporate Bulk','Corporate Bundle','Residential')
		and 
		(
		package in ('EXTRAVAGANCE','EXTRAVAGANCE CORPORATE','AMBER','AMBER CORPORATE')
		)


		) a 
		group by period, clientcode, clientclass, package
	) a 
	group by period, clientcode, clientclass
) a 
where `Extravagance`>0 and `Amber`>0
group by period, clientclass
;
