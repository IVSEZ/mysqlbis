# INTELENOVELA as per New Sales #
-- set @startdate='2018-01-01';
-- set @enddate='2018-08-31';
-- set @package='INTELENOVELA';
SET @row_number = 0;

SET @startdate='2019-06-01';
-- select @startdate := subdate(current_date(),1);


-- select @enddate := subdate(current_date(),1);
SET @enddate='2019-07-31';


-- set @package='INTELENOVELA';
-- set @package='DUALVIEW';
-- set @package='MULTIVIEW';
SET @package='VOD';

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='INTELENOVELA';

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='DUALVIEW';

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='MULTIVIEW';
-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='IGO';

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='INDIAN';
-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;

SET @package='FRENCH';
-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

select @package as Package, a.clientcode, rcbill.GetClientName(a.clientcode) as clientname, a.clientclass, a.clienttype, a.firstactive from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;


/*
select *,rcbill.GetClientName(clientcode) as ClientName from rcbill_my.sales where orderday>=@startdate and orderday<=@enddate
and salestype='New Sales'
and upper(servicetype)=@package
;
*/

/*
select * from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)='INTELENOVELA'
;
*/

/*
select distinct clientcode, clientname from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)=@package
;
*/

/*
	select clientcode, rcbill.GetClientName(clientcode) as ClientName, min(period) as firstactive
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	and upper(package)=@package)


	and upper(package)=@package

	group by clientcode
	order by 3 desc
;
*/

/*
select @package as Package, a.*, rcbill.GetClientName(a.clientcode) as clientname from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
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
where a.firstactive>=@startdate
;
*/

/*
select * from rcbill_my.sales where clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)=@package)
and salestype='New Sales'
and upper(servicetype)=@package
order by orderday desc
;
*/