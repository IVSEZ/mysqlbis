-- select * from rcbill.clientcontractdevices limit 100;

-- duration 1883.640 sec

set @perioddate='2018-12-22';

drop table if exists rcbill_my.tempcpp;
create table rcbill_my.tempcpp
as
(
	select distinct contractcode, period, package from rcbill_my.customercontractactivity where period>=@perioddate
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


-- select * from rcbill_my.tempcpp where contractcode='I.000344969' limit 100;
-- show index from rcbill_my.tempcpp;
-- select * from rcbill_my.tempcppd where contractcode='I.000344969' contractid=2164698 limit 100;
-- show index from rcbill_my.tempcppd;

-- select count(*) as tempcpp from rcbill_my.tempcpp;
-- select count(*) as tempcppd from rcbill_my.tempcppd ;


-- show index from rcbill.rcb_ipusage;
-- select * from rcbill.rcb_ipusage where usagedate>=@perioddate and cid=2164698;
-- select * from rcbill.rcb_ipusage where usagedate>=@perioddate and cid=2181700;

drop table if exists rcbill_my.package_ip_usage;
create table rcbill_my.package_ip_usage as
-- (
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
		rcbill.rcb_ipusage a 
		-- (
		-- 	select * from rcbill.rcb_ipusage a where a.USAGEDATE>='2018-01-01 00:00:00'
        -- ) a
        left join 
		rcbill_my.tempcppd  b 
		on a.cid=b.contractid
        and a.csid=b.csid
		and a.USAGEDATE=b.period
        
        where a.USAGEDATE>=@perioddate
        -- where date(a.USAGEDATE)>='2018-01-01'
		-- and a.deviceid=b.Deviceid
	
    )
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
		rcbill.rcb_ipusageold a 
        -- (
		-- select * from rcbill.rcb_ipusageold a where a.USAGEDATE>='2018-01-01 00:00:00'
        -- ) a 
        left join 
		rcbill_my.tempcppd  b 
		on a.cid=b.contractid
        and a.csid=b.csid
        and a.USAGEDATE=b.period
		where a.USAGEDATE>=@perioddate
        -- and a.deviceid=b.Deviceid
        -- where date(a.USAGEDATE)>='2018-01-01'
    ) 
    
    
-- )
;


-- select * from rcbill_my.package_ip_usage where clientcode='I.000011750';
-- TrafficType
-- select *, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as ttype from rcbill_my.package_ip_usage where package in ('Crimson','Crimson Corporate');
-- select *, (select name from rcbill.rcb_traffictypes where id=TRAFFICTYPE) as ttype from rcbill_my.package_ip_usage where package in ('Amber','Amber Corporate');


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
				when contracttype='BUNDLE (GPON)' then 'GPON'
				when contracttype='BUNDLE (CI)' then 'HFC'
				when contracttype='INTERNET' then 'HFC'
			end as NETWORK
		from rcbill_my.package_ip_usage 
        where 
        0=0
        -- and package in ('Crimson','Crimson Corporate')
        and package in ('Amber','Amber Corporate')
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