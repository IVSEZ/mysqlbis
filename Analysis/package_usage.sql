-- select * from rcbill.clientcontractdevices limit 100;

-- duration 1883.640 sec

drop table if exists rcbill_my.tempcpp;
create table rcbill_my.tempcpp
as
(
	select distinct contractcode, period, package from rcbill_my.customercontractactivity where period>='2018-01-01'
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


-- select * from rcbill_my.tempcpp limit 100;
-- show index from rcbill_my.tempcpp;
-- select * from rcbill_my.tempcppd limit 100;
-- show index from rcbill_my.tempcppd;

-- select count(*) as tempcpp from rcbill_my.tempcpp;
-- select count(*) as tempcppd from rcbill_my.tempcppd ;


-- show index from rcbill.rcb_ipusage;

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
        
        where a.USAGEDATE>='2018-01-01'
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
		where a.USAGEDATE>='2018-01-01'
        -- and a.deviceid=b.Deviceid
        -- where date(a.USAGEDATE)>='2018-01-01'
    ) 
    
    
-- )
;


select * from rcbill_my.package_ip_usage;


/*
drop table if exists rcbill_my.tempcpp;
drop table if exists rcbill_my.tempcppd;
*/