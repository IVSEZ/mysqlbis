-- set @periodstart='2019-06-28';
-- set @periodend='2019-07-02';

set @periodstart='2019-08-14';
set @periodend='2019-08-20';



	select a.*
	,b.clientname, b.clientclass, b.clientphone, b.clientemail
	from
	(

	select a.*
	-- ,b.*
	-- , GROUP_CONCAT(b.servicecategory ORDER BY b.servicecategory SEPARATOR '|' ) as service
	-- , GROUP_CONCAT(b.package ORDER BY b.package SEPARATOR '|' ) as package
	, b.network
	, b.service
	, b.package
	, case 
		when b.service like '%OTT%' then 'OTT-YES'
		else 'OTT-NO'
		end as `OTTCHECK`
	, case 
		when b.package like '%VOD%' then 'VOD-YES'
		else 'VOD-NO'
		end as `VODCHECK`
	from 
	(

		SELECT 
			sessionstart,
			IFNULL(resource,
					rcbill.GetVODTitleFromResource(origresource)) AS resource,
			duration,
			device,
			contractcode,
			clientcode
		FROM
			(
			SELECT 
				sessionstart,
					TRIM(UPPER(originaltitle)) AS resource,
					resource AS origresource,
					duration,
					device,
					contractcode,
					clientcode
			FROM
				rcbill.clientvodstats
			WHERE
			--     clientcode = '" . $cust_code . "'
			date(sessionstart)>=@periodstart and date(sessionstart)<=@periodend
			ORDER BY sessionstart DESC
			) a
		ORDER BY sessionstart DESC
	) a 
	left join 
	-- rcbill_my.rep_custconsolidated b
	(
		select clientcode, contractcode, period, GROUP_CONCAT(servicecategory ORDER BY servicecategory SEPARATOR '|' ) as service
		, GROUP_CONCAT(package ORDER BY package SEPARATOR '|' ) as package
		, network from rcbill_my.customercontractactivity 
		-- where clientcode='I.000014301' and contractcode='I.000344067' and period='2019-07-01'
		where period>=@periodstart and period<=@periodend
		group by 
		clientcode
		-- , contractcode
		, period
	) b 
	on 
	a.clientcode=b.clientcode
	-- and 
	-- a.contractcode=b.contractcode
	and 
	date(a.sessionstart)=b.period

	-- group by clientcode, contractcode
	) a 
	left join 
	rcbill_my.rep_custconsolidated b 
	on a.clientcode=b.clientcode
	;










select clientcode, contractcode, period, GROUP_CONCAT(servicecategory ORDER BY servicecategory SEPARATOR '|' ) as service
, GROUP_CONCAT(package ORDER BY package SEPARATOR '|' ) as package
, network from rcbill_my.customercontractactivity 
-- where clientcode='I.000003563' and contractcode='I.000364846' and period='2019-07-01'
where period>=@periodstart and period<=@periodend
group by 
clientcode
-- , contractcode
, period
;
-- show columns from rcbill_my.rep_custconsolidated;