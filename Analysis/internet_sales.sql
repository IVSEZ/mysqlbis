# INTELENOVELA as per New Sales #
set @startdate='2018-06-01';
set @enddate='2018-06-30';
set @package='AMBER';
set @category='INTERNET';


select a.*, rcbill.GetClientName(a.clientcode) as clientname from 
(
	select clientcode, clientclass, clienttype, package, min(period) as firstactive
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	-- and upper(package)=@package 
    and upper(servicecategory)=@category
    )


	-- and upper(package)=@package
	and upper(servicecategory)=@category

	group by clientcode
	order by 5 desc
) a
where a.firstactive>=@startdate
;
