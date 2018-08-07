# INTELENOVELA as per New Sales #
set @startdate='2018-07-01';
set @enddate='2018-07-31';

select * from rcbill_my.sales where orderday>=@startdate and orderday<=@enddate
and salestype='New Sales'
and upper(servicetype)='INTELENOVELA'
;

/*
select * from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)='INTELENOVELA'
;
*/
select distinct clientcode, clientname from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)='INTELENOVELA'
;


	select clientcode, min(period) as firstintelenovela
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	and upper(package)='INTELENOVELA')


	and upper(package)='INTELENOVELA'

	group by clientcode
	order by 2 desc
;

select a.* from 
(
	select clientcode, min(period) as firstintelenovela
	from rcbill_my.customercontractactivity 
	where 
	clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
	and upper(package)='INTELENOVELA')


	and upper(package)='INTELENOVELA'

	group by clientcode
	order by 2 desc
) a
where a.firstintelenovela>=@startdate
;

select * from rcbill_my.sales where clientcode in (select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
and upper(package)='INTELENOVELA')
and salestype='New Sales'
and upper(servicetype)='INTELENOVELA'
order by orderday desc
;