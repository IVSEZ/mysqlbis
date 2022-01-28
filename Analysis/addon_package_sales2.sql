# INTELENOVELA as per New Sales #
-- set @startdate='2018-01-01';
-- set @enddate='2018-08-31';
-- set @package='INTELENOVELA';
SET @row_number = 0;

-- select @startdate := subdate(current_date(),1);
-- select @enddate := subdate(current_date(),1);



SET @startdate = (select min(month_all_date) from rcbill_my.month_all_date);
SET @enddate = (select max(month_all_date) from rcbill_my.month_all_date);

-- SET @startdate='2017-01-01';
-- SET @enddate='2021-12-24';


select @startdate;
select @enddate;

select 'IN ADDON PACKAGE SALES';

-- set @package='INTELENOVELA';
-- set @package='DUALVIEW';
-- set @package='MULTIVIEW';
SET @package='VOD';

-- show index from rcbill_my.customercontractactivity ;
-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

drop table if exists a;

create temporary table a (index idx1(firstactive))
(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
);

select 'table A created' as message;

drop table if exists rcbill_my.rep_newfirstactive_vod;

create table rcbill_my.rep_newfirstactive_vod(index idxnfav1(clientcode))
(

	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME
    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from 
	a
	where a.firstactive>=@startdate

	/*
	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME

    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from 
	(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
	) a
	where a.firstactive>=@startdate
    */
)
;

drop table if exists a;

select count(*) as rep_newfirstactive_vod from rcbill_my.rep_newfirstactive_vod;

-- select * from rcbill_my.rep_newfirstactive_vod;


SET @package='INTELENOVELA';


drop table if exists a;

create temporary table a (index idx1(firstactive))
(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
);

select 'table A created' as message;

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

drop table if exists rcbill_my.rep_newfirstactive_int;

create table rcbill_my.rep_newfirstactive_int(index idxnfai1(clientcode))
(
	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME
    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from
    /*
	(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package
		
		group by clientcode
		order by 4 desc
	)*/
    a
	where a.firstactive>=@startdate
)
;

drop table if exists a;

select count(*) as rep_newfirstactive_int from rcbill_my.rep_newfirstactive_int;

-- select * from rcbill_my.rep_newfirstactive_int;

SET @package='DUALVIEW';


drop table if exists a;

create temporary table a (index idx1(firstactive))
(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
);

select 'table A created' as message;

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;
drop table if exists rcbill_my.rep_newfirstactive_dv;

create table rcbill_my.rep_newfirstactive_dv(index idxnfad1(clientcode))
(

	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME
    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from 
	/*(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
	)*/ 
    a
	where a.firstactive>=@startdate
)
;

drop table if exists a;

select count(*) as rep_newfirstactive_dv from rcbill_my.rep_newfirstactive_dv;


SET @package='MULTIVIEW';
-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;


drop table if exists a;

create temporary table a (index idx1(firstactive))
(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
);

select 'table A created' as message;

drop table if exists rcbill_my.rep_newfirstactive_mv;

create table rcbill_my.rep_newfirstactive_mv(index idxnfam1(clientcode))
(

	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME
    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from 
	/*(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
	)*/
    a
	where a.firstactive>=@startdate
)
;
drop table if exists a;

select count(*) as rep_newfirstactive_mv from rcbill_my.rep_newfirstactive_mv;

SET @package='IGO';

-- select distinct clientcode from rcbill_my.customercontractsnapshot where package=@package and firstcontractdate>=@startdate and lastcontractdate<=@enddate;

drop table if exists a;

create temporary table a (index idx1(firstactive))
(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
);

select 'table A created' as message;

drop table if exists rcbill_my.rep_newfirstactive_igo;

create table rcbill_my.rep_newfirstactive_igo(index idxnfaig1(clientcode))
(

	select @package as PACKAGE, a.clientcode AS CLIENTCODE
    -- , rcbill.GetClientName(a.clientcode) as CLIENTNAME
    , (select firm from rcbill.rcb_tclients where kod=a.clientcode) as CLIENTNAME
    , a.clientclass AS CLIENTCLASS, a.clienttype AS CLIENTTYPE, a.region AS REGION
	, a.firstactive AS FIRSTACTIVE, a.lastactive AS LASTACTIVE
	, case when a.lastactive=@lastdate then 'ACTIVE' else 'INACTIVE' end as `CURRENTSTATUS`
	from 
	/*(
		select clientcode, clientclass, clienttype, min(period) as firstactive, max(period) as lastactive, region
		from rcbill_my.customercontractactivity 
		where 
		clientcode in 
		(
			select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and (period>=@startdate and period<=@enddate)
			and package=@package
		)
		and package=@package

		group by clientcode
		order by 4 desc
	)*/ a
	where a.firstactive>=@startdate
)
;
drop table if exists a;

select count(*) as rep_newfirstactive_igo from rcbill_my.rep_newfirstactive_igo;

/*

explain 		select distinct clientcode from rcbill_my.customercontractactivity where reported='Y' and period>=@startdate and period<=@enddate
		and package=@package
        
 show index from rcbill_my.customercontractactivity;       
        
*/