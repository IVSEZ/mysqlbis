
SET @startdate='2018-01-01';
-- select @startdate := subdate(current_date(),1);


select @enddate := subdate(current_date(),1);
-- SET @enddate='2018-11-30';


-- set @package='INTELENOVELA';
-- set @package='DUALVIEW';
-- set @package='MULTIVIEW';
SET @package='VOD';


select 
a.*
,b.*
from 
(
	select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname
    -- , a.clientclass, a.clienttype
	, a.subfirstactive 
	, a.sublastactive
	,case
				when @enddate=a.sublastactive then 'Active' 
				else 'InActive'
				end as `IsSubActive` 
    , a.dayssincesublastactive
	,
	case 
		when a.dayssincesublastactive=0 then '1. Alive' 
		when a.dayssincesublastactive>0 and a.dayssincesublastactive<=7 then '2. Snoozing (1 to 7 days)'
		when a.dayssincesublastactive>7 and a.dayssincesublastactive<=30 then '3. Asleep (8 to 30 days)'
		when a.dayssincesublastactive>30 and a.dayssincesublastactive<=90 then '4. Hibernating (31 to 90 days)'
		when a.dayssincesublastactive>90 then '5. Dormant (more than 90 days)'
		when a.dayssincesublastactive is null then '5. Dormant (more than 90 days)'
	end as `SubActivityStage` 
	from 
	(
		select clientcode
        -- , clientclass, clienttype
        ,min(period) as subfirstactive
		,max(period) as sublastactive
		, datediff(@enddate,max(period)) as dayssincesublastactive
        , sum(ACTIVECOUNT) as subsactive
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
			and upper(package)=@package
		)
		and upper(package)=@package

		group by clientcode
		order by 4 desc
	) a
	where a.subfirstactive>=@startdate
) a 
left join
rcbill_my.rep_custconsolidated b 
on 
a.clientcode=b.clientcode
;