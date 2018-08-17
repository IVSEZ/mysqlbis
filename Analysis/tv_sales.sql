set @startdate='2018-01-01';
set @enddate='2018-08-07';
set @package='EXTRAVAGANCE';
set @category='TV';


#FOR CATEGORY#
select a.*, rcbill.GetClientName(a.clientcode) as clientname from 
(
	select clientcode, clientclass, clienttype, servicecategory as category, package, min(period) as firstactiveforcategory
	from rcbill_my.customercontractactivity 
	where 
	clientcode in 
    (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
		-- and upper(package)=@package 
		and upper(servicecategory)=@category
    )
	-- and upper(package)=@package
	and upper(servicecategory)=@category

	group by clientcode, clientclass, clienttype, servicecategory, package
	order by 6 desc
) a
where a.firstactiveforcategory>=@startdate
;



#FOR PACKAGE#
select a.*, rcbill.GetClientName(a.clientcode) as clientname from 
(
	select clientcode, clientclass, clienttype, servicecategory as category, package, min(period) as firstactiveforpackage
	from rcbill_my.customercontractactivity 
	where 
	clientcode in 
    (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
		and upper(package)=@package 
		-- and upper(servicecategory)=@category
    )
	and upper(package)=@package
	-- and upper(servicecategory)=@category

	group by clientcode, clientclass, clienttype, servicecategory, package
	order by 6 desc
) a
where a.firstactiveforpackage>=@startdate
;

