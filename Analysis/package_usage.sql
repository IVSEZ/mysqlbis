-- select * from rcbill.clientcontractdevices limit 100;

-- duration 1883.640 sec

set @startdate='2020-01-01';
set @enddate='2020-04-21';
-- select * from rcbill_my.customercontractactivity where period>=@startdate and period<=@enddate

drop table if exists rcbill_my.tempcpp;
create table rcbill_my.tempcpp
as
(
	select distinct contractcode, period, package from rcbill_my.customercontractactivity 
    where 
    0=0
    and servicecategory='Internet'
    and period>=@startdate and period<=@enddate
);
	CREATE INDEX tdxtempcpp1
	ON rcbill_my.tempcpp (contractcode);
	CREATE INDEX tdxtempcpp2
	ON rcbill_my.tempcpp (period);


drop table if exists rcbill_my.tempcppd;
create table rcbill_my.tempcppd as
(
			select a.contractcode as a_contractcode
            , a.period, a.package
            -- , b.* 
			, b.contractid
            , b.contractcode
            , b.contracttype
			, b.clientcode
			, b.clientid
            , b.csid

            from 
			rcbill_my.tempcpp a
			left join
			rcbill.clientcontractdevices b 
			on a.contractcode=b.contractcode	

);

	CREATE INDEX idxtempcppd1
	ON rcbill_my.tempcppd (contractid);
	CREATE INDEX idxtempcppd2
	ON rcbill_my.tempcppd (period);
	CREATE INDEX idxtempcppd3
	ON rcbill_my.tempcppd (csid);
	CREATE INDEX idxtempcppd4
	ON rcbill_my.tempcppd (contractid, csid, period);

-- select * from rcbill_my.tempcpp where contractcode='I.000344969' limit 100;
-- show index from rcbill_my.tempcpp;
-- select * from rcbill_my.tempcppd where contractcode='I.000290470' contractid=2164698 limit 100;
-- show index from rcbill_my.tempcppd;

-- select count(*) as tempcpp from rcbill_my.tempcpp;
-- select count(*) as tempcppd from rcbill_my.tempcppd ;


-- show index from rcbill.rcb_ipusage;
-- select * from rcbill.rcb_ipusage where usagedate>=@startdate and cid=2124054;
-- select * from rcbill.rcb_ipusage where usagedate>=@startdate and cid=2181700;

-- RENAME TABLE rcbill_my.package_ip_usage TO rcbill_my.package_ip_usage2018;

drop table if exists rcbill_my.tempipusage;
create table rcbill_my.tempipusage as
(
		select *

		from 
		rcbill.rcb_ipusage a 
        where 0=0
        and a.USAGEDATE>=@startdate
        and a.USAGEDATE<=@enddate

);

	CREATE INDEX idxtempipusage1
	ON rcbill_my.tempipusage (cid);
	CREATE INDEX idxtempipusage2
	ON rcbill_my.tempipusage (usagedate);
	CREATE INDEX idxtempipusage3
	ON rcbill_my.tempipusage (csid);
	CREATE INDEX idxtempipusage4
	ON rcbill_my.tempipusage (cid, csid, usagedate);

-- show index from rcbill_my.tempipusage;
-- select * from rcbill_my.tempipusage where cid=2124054;


drop table if exists rcbill_my.tempipusageold;
create table rcbill_my.tempipusageold as
(
		select *

		from 
		rcbill.rcb_ipusageold a 
        where 0=0
        and a.USAGEDATE>=@startdate
        and a.USAGEDATE<=@enddate

);

	CREATE INDEX idxtempipusageold1
	ON rcbill_my.tempipusageold (cid);
	CREATE INDEX idxtempipusageold2
	ON rcbill_my.tempipusageold (usagedate);
	CREATE INDEX idxtempipusageold3
	ON rcbill_my.tempipusageold (csid);
    
	CREATE INDEX idxtempipusageold4
	ON rcbill_my.tempipusageold (cid, csid, usagedate);
    
    
-- select * from rcbill_my.tempipusageold;

/*
select count(*) from rcbill_my.tempipusage;
select count(*) from rcbill_my.tempcppd;


*/

drop table if exists rcbill_my.package_ip_usage;
create table rcbill_my.package_ip_usage as 
(

  		select  a.USAGEDATE, a.CLIENTIP, 
		-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
		case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
		else INET_NTOA(a.clientip)
		end as processedclientip 
		-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
		, b.contractcode
        , b.package
        , b.contracttype, b.clientcode
        -- , b.clientname, b.clientaddress
		, a.usagedirection, a.octets
		, (a.octets)/(1024.0*1024.0) as MB_USED
		, b.clientid, a.cid, a.csid, a.serviceid  
		-- , b.phoneno, b.mac
        , a.deviceid
        -- , b.address
        , b.contractid
		,a.TRAFFICTYPE
		from 
		-- rcbill.rcb_ipusage a 
        rcbill_my.tempipusage a
		-- (
		-- 	select * from rcbill.rcb_ipusage a where a.USAGEDATE>='2018-01-01 00:00:00'
        -- ) a
        left join 
		rcbill_my.tempcppd  b 
		on a.cid=b.contractid
        and a.csid=b.csid
		and a.USAGEDATE=b.period
        
--        where 0=0
--        and a.USAGEDATE>=@startdate
--        and a.USAGEDATE<=@enddate
        -- where date(a.USAGEDATE)>='2018-01-01'
		-- and a.deviceid=b.Deviceid
        -- limit 10000000
        

)
;


-- create table rcbill_my.package_ip_usage as
-- (
/*
	(
		select  a.USAGEDATE, a.CLIENTIP, 
		-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
		case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
		else INET_NTOA(a.clientip)
		end as processedclientip 
		-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
		, b.contractcode
        , b.package
        , b.contracttype, b.clientcode
        -- , b.clientname, b.clientaddress
		, a.usagedirection, a.octets
		, (a.octets)/(1024.0*1024.0) as MB_USED
		, b.clientid, a.cid, a.csid, a.serviceid  
		-- , b.phoneno, b.mac
        , a.deviceid
        -- , b.address
        , b.contractid
		,a.TRAFFICTYPE
		from 
		-- rcbill.rcb_ipusage a 
        rcbill_my.tempipusage a
		-- (
		-- 	select * from rcbill.rcb_ipusage a where a.USAGEDATE>='2018-01-01 00:00:00'
        -- ) a
        left join 
		rcbill_my.tempcppd  b 
		on a.cid=b.contractid
        and a.csid=b.csid
		and a.USAGEDATE=b.period
        
--        where 0=0
--        and a.USAGEDATE>=@startdate
--        and a.USAGEDATE<=@enddate
        -- where date(a.USAGEDATE)>='2018-01-01'
		-- and a.deviceid=b.Deviceid
	
    )
    */
    /*
    union
    (
    	select  a.USAGEDATE, a.CLIENTIP, 
		-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
		case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
		else INET_NTOA(a.clientip)
		end as processedclientip 
		-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
		, b.contractcode
        , b.package
        , b.contracttype, b.clientcode
        -- , b.clientname, b.clientaddress
		, a.usagedirection, a.octets
		, (a.octets)/(1024.0*1024.0) as MB_USED
		, b.clientid, a.cid, a.csid, a.serviceid  
		-- , b.phoneno, b.mac
        , a.deviceid
        -- , b.address
        , b.contractid
		,a.TRAFFICTYPE
		from 
		-- rcbill.rcb_ipusageold a 
        rcbill_my.tempipusageold
        -- (
		-- select * from rcbill.rcb_ipusageold a where a.USAGEDATE>='2018-01-01 00:00:00'
        -- ) a 
        left join 
		rcbill_my.tempcppd  b 
		on a.cid=b.contractid
        and a.csid=b.csid
        and a.USAGEDATE=b.period
		where 0=0
		and a.USAGEDATE>=@startdate
        and a.USAGEDATE<=@enddate
        -- and a.deviceid=b.Deviceid
        -- where date(a.USAGEDATE)>='2018-01-01'
    ) 
    */
    
-- )
-- ;

-- select count(1) from rcbill_my.package_ip_usage;
-- select * from rcbill_my.package_ip_usage where clientcode='I.000011750' and traffictype=9 and package='TURQUOISE HIGH TIDE';
--  select * from rcbill_my.package_ip_usage where contracttype is null;
-- select distinct contracttype from rcbill_my.package_ip_usage;

-- TrafficType
-- select * from rcbill.rcb_traffictypes;
-- select *, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as ttype from rcbill_my.package_ip_usage where package in ('Crimson','Crimson Corporate');
-- select *, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as ttype from rcbill_my.package_ip_usage where package in ('Amber','Amber Corporate');

/*
	select Month(usagedate) as USAGEMONTH, PACKAGE, NETWORK, TRAFFIC, count(distinct date(usagedate)) as usagedays
	, count(clientcode) as clients, count(distinct clientcode) as d_clients
	, sum(mb_used) as mb_used
	from 
	(
		select *
		, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as TRAFFIC 
		,
		   case 
				when contracttype='GNET' then 'GPON'
                when contracttype='CAPPED GNET' then 'GPON'
				when contracttype='BUNDLE (GPON)' then 'GPON'
				when contracttype='BUNDLE (CI)' then 'HFC'
				when contracttype='INTERNET' then 'HFC'
                when contracttype='CAPPED INTERNET' then 'HFC'
                when contracttype='INTERNET,' then 'HFC'
                when contracttype='INTERNET, VOICE' then 'HFC'
			end as NETWORK
		from rcbill_my.package_ip_usage 
        where 
        0=0
        -- and package in ('Crimson','Crimson Corporate')
        -- and package in ('Amber','Amber Corporate')
        -- and clientcode='I.000002333'
	) a 
	where
	0=0 
	and TRAFFIC='Default'
	-- and date(usagedate)='2018-12-01'
	group by 1, 2, 3, 4, 5

*/



select PACKAGE, NETWORK, TRAFFIC, mb_used, usagedays, clients, d_clients
, (mb_used/d_clients) as usageperclient
, (mb_used/usagedays) as usageperday
, ((mb_used/d_clients)/usagedays) as usageperclientperday
from
(
	select PACKAGE, NETWORK, TRAFFIC, count(distinct date(usagedate)) as usagedays
	, count(clientcode) as clients, count(distinct clientcode) as d_clients
	, sum(mb_used) as mb_used
	from 
	(
		select *
		, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as TRAFFIC 
		,
		   case 
				when contracttype='GNET' then 'GPON'
                when contracttype='CAPPED GNET' then 'GPON'
				when contracttype='BUNDLE (GPON)' then 'GPON'
				when contracttype='BUNDLE (CI)' then 'HFC'
				when contracttype='INTERNET' then 'HFC'
                when contracttype='CAPPED INTERNET' then 'HFC'
                when contracttype='INTERNET,' then 'HFC'
                when contracttype='INTERNET, VOICE' then 'HFC'
			end as NETWORK
		from rcbill_my.package_ip_usage 
        where 
        0=0
        -- and package in ('Crimson','Crimson Corporate')
        -- and package in ('Amber','Amber Corporate')
        -- and clientcode='I.000002333'
	) a 
	where
	0=0 
	and TRAFFIC='Default'
	-- and date(usagedate)='2018-12-01'
	group by 1, 2, 3
) a
;



/*
drop table if exists rcbill_my.tempcpp;
drop table if exists rcbill_my.tempcppd;
*/