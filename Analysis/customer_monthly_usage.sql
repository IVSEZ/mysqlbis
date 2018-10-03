set @custcode='I.000015232';
set @custid='727208';

set @custcode='I.000015403';
set @custid='727380';

set @custcode='I6816';
set @custid='694263';




	select b.datestart, b.dateend, b.category, b.traffictype, b.device
	, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
	, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

	from rcbill_my.dailyusage b 	
    where b.clientcode=@custcode
	order by b.dateend desc;
    
    
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