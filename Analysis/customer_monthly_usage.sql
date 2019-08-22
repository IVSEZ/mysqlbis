set @custcode='I.000015232';
set @custid='727208';

set @custcode='I.000015403';
set @custid='727380';

set @custcode='I21441';
set @custid='694263';




set @custcode='I21441';
set @custcode='I.000020029';
set @custcode='I.000002447';
set @custcode='I.000007041';



	select b.clientcode, b.datestart, b.dateend, b.category, b.traffictype, b.device
	, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
	, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

	from rcbill_my.dailyusage b 	
    where b.clientcode=@custcode
    and TRAFFICTYPE='Default'
	order by b.dateend desc;
    
    select * from rcbill_my.customercontractsnapshot where clientcode=@custcode;
 --   select * from rcbill.clientcontractdevices a where a.clientcode=@custcode;
    select * from rcbill_my.dailyusage where clientcode=@custcode;
  
  
  select a.clientcode, a.contractcode, a.servicecategory2, a.package, a.network, a.firstcontractdate, a.lastcontractdate
, b.clientcode, b.DATESTART, b.DATEEND, b.category, b.traffic_mb
from  rcbill_my.customercontractsnapshot a 
left join rcbill_my.dailyusage b
on a.clientcode=b.clientcode 
and (a.firstcontractdate<=b.datestart) and (a.lastcontractdate>=b.dateend)
where a.clientcode=@custcode
    and b.TRAFFICTYPE='Default'
;

select clientcode, contractcode, servicecategory2, package, network, category
, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
-- , sum(DurationForContract) as DurationForContract, sum(ActiveDaysForContract) as ActiveDaysForContract
-- , sum(InActiveDaysForContract) as InActiveDaysForContract
, min(DATESTART) as DATESTART, max(DATEEND) as DATEEND
, sum(TRAFFIC_MB) as traffic_mb
, (sum(TRAFFIC_MB)/1024) as traffic_gb
from 
(
	select a.clientcode, a.contractcode, a.servicecategory2, a.package, a.network, a.firstcontractdate, a.lastcontractdate
	-- , b.clientcode
    -- , a.DurationForContract, a.ActiveDaysForContract, a.InActiveDaysForContract
    , b.DATESTART, b.DATEEND, b.category, b.traffic_mb
	from  rcbill_my.customercontractsnapshot a 
	left join rcbill_my.dailyusage b
	on a.clientcode=b.clientcode 
	and (a.firstcontractdate<=b.datestart) and (a.lastcontractdate>=b.dateend)
	where a.clientcode=@custcode
        and b.TRAFFICTYPE='Default'
) a 
group by 1, 2, 3, 4, 5, 6
;
 
  
           select b.CLIENTCODE, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode
        , b.CATEGORY
        , sum(b.traffic_mb) as traffic_mb, min(b.datestart) as datestart, max(b.dateend) as dateend

		from rcbill_my.dailyusage b 	
		where b.clientcode=@custcode
		and TRAFFICTYPE='Default'
        
        group by 1, 2, 3;
		-- order by b.dateend desc;
   


 
   
   
   
   
   
    select a.clientcode
    -- , a.clientclass
    , a.contractcode, a.package, a.firstcontractdate, a.lastcontractdate
    , a.durationforcontract, a.activedaysforcontract, a.inactivedaysforcontract
    -- , a.currentstatus
    , b.datestart, b.dateend, b.contractcode, b.traffic_mb
    from 
    ( 
    -- rcbill_my.customercontractsnapshot 
		select clientcode, contractcode, servicecategory2, package, region, network
        , min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
        , sum(durationforcontract) as durationforcontract, sum(ActiveDaysForContract) as ActiveDaysForContract
        , sum(InActiveDaysForContract) as InActiveDaysForContract
        from rcbill_my.customercontractsnapshot 
        where clientcode=@custcode
        group by 1, 2, 3, 4, 5, 6
    
    ) a 
    left join 
    (
		/*
		select b.clientcode, b.datestart, b.dateend, b.category, b.traffictype, b.device
		, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode
        , b.traffic_mb
		, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

		from rcbill_my.dailyusage b 	
		where b.clientcode=@custcode
		and TRAFFICTYPE='Default'
		order by b.dateend desc
        */
        
        select b.CLIENTCODE, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode
        , b.CATEGORY
        , sum(b.traffic_mb) as traffic_mb, min(b.datestart) as datestart, max(b.dateend) as dateend

		from rcbill_my.dailyusage b 	
		where b.clientcode=@custcode
		and TRAFFICTYPE='Default'
        
        group by 1, 2, 3
		-- order by b.dateend desc
    ) b
    on a.clientcode=b.clientcode -- and a.contractcode=b.contractcode 
    and (b.DATESTART>=a.firstcontractdate and b.DATEEND<=a.lastcontractdate)
    
    where a.clientcode=@custcode
    ;
    
    
    
    -- select * from rcbill.rcb_casa where clid=@custid;
    
    select clid
	, cid
    , rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
	, date(BegDate) as SubStartDate, date(EndDate) as SubEndDate
	from rcbill.rcb_casa
	where
    clid=@custid
    and date(BegDate)>='2018-01-01'
    and
	(hard not in (100, 101, 102) or hard is null)
	-- group by clid, cid, 3, 4, 5, 6
	order by clid, 6 desc, 5 desc;
    
    
    select a.*, b.*
    from 
    (
		select clid
		, cid
		, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
		, date(BegDate) as SubStartDate, date(EndDate) as SubEndDate
		from rcbill.rcb_casa
		where
		clid=@custid
		and date(BegDate)>='2018-01-01'
		and
		(hard not in (100, 101, 102) or hard is null)
		-- group by clid, cid, 3, 4, 5, 6
		order by clid, 6 desc, 5 desc
 	) a
    left join 
    (
		select b.datestart, b.dateend, b.category, b.traffictype, b.device
		, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as b_contractcode, b.traffic_mb
		, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

		from rcbill_my.dailyusage b 	
		where b.clientcode=@custcode
        and b.traffictype<>'Free'
		order by b.dateend desc    
    ) b
	on a.contractcode=b.b_contractcode
	and ((b.DATESTART>=a.SubStartDate and b.DATEEND<=a.SubEndDate))
    -- or (a.SubEndDate=b.DateEnd))
    ;
    
   
    select clid, cid, clientcode, contractcode, substartdate, subenddate, category, traffictype, sum(traffic_mb) as traffic_mb
    from 
    (

			select a.*, b.*
			from 
			(
				select clid
				, cid
				, rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
				, date(BegDate) as SubStartDate, date(EndDate) as SubEndDate
				from rcbill.rcb_casa
				where
				clid=@custid
				and date(BegDate)>='2018-01-01'
				and
				(hard not in (100, 101, 102) or hard is null)
				-- group by clid, cid, 3, 4, 5, 6
				order by clid, 6 desc, 5 desc
			) a
			left join 
			(
				select b.datestart, b.dateend, b.category, b.traffictype, b.device
				, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as b_contractcode, b.traffic_mb
				, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

				from rcbill_my.dailyusage b 	
				where b.clientcode=@custcode
				and b.traffictype<>'Free'
				order by b.dateend desc    
			) b
			on a.contractcode=b.b_contractcode
			and ((b.DATESTART>=a.SubStartDate and b.DATEEND<=a.SubEndDate))
			-- or (a.SubEndDate=b.DateEnd))
			
    
    
    ) a 
    group by clid, cid, clientcode, contractcode, substartdate, subenddate, category, traffictype
    order by 5 desc
    ;