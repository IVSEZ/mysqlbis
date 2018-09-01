# VOD as per New Sales #
set @startdate='2018-07-01';
set @enddate='2018-07-31';
set @package='VOD';

select *,rcbill.GetClientName(clientcode) as ClientName from rcbill_my.sales where orderday>=@startdate and orderday<=@enddate
and salestype='New Sales'
and upper(servicetype)=@package
;

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


	select clientcode, rcbill.GetClientName(clientcode) as ClientName, min(period) as firstactive
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	and upper(package)=@package)


	and upper(package)=@package

	group by clientcode
	order by 3 desc
;

select a.*, rcbill.GetClientName(a.clientcode) as clientname from 
(
	select clientcode, clientclass, clienttype, min(period) as firstactive
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	and upper(package)=@package)


	and upper(package)=@package

	group by clientcode
	order by 4 desc
) a
where a.firstactive>=@startdate
;

/*
select * from rcbill_my.sales where clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)=@package)
and salestype='New Sales'
and upper(servicetype)=@package
order by orderday desc
;
*/