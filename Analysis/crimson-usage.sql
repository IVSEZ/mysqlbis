select * from rcbill_my.customercontractactivity limit 100;
select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'));

-- 11791.656 sec
-- use rcbill_my;
drop table if exists rcbill_my.crimson_usage;
create table rcbill_my.crimson_usage as
-- (
	(
		select  a.USAGEDATE, a.CLIENTIP, 
		-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
		case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
		else INET_NTOA(a.clientip)
		end as processedclientip 
		-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
		, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
		, a.usagedirection, a.octets
		, (a.octets)/(1024.0*1024.0) as MB_USED
		, b.clientid, a.cid, a.csid, a.serviceid  
		, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
		,a.TRAFFICTYPE
		from 
		rcbill.rcb_ipusage a 
		inner join 
		(
		-- rcbill.clientcontractdevices 
			select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
		) b 
		on a.cid=b.contractid
		and a.deviceid=b.Deviceid
	
    )
    union
    (
    	select  a.USAGEDATE, a.CLIENTIP, 
		-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
		case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
		else INET_NTOA(a.clientip)
		end as processedclientip 
		-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
		, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
		, a.usagedirection, a.octets
		, (a.octets)/(1024.0*1024.0) as MB_USED
		, b.clientid, a.cid, a.csid, a.serviceid  
		, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
		,a.TRAFFICTYPE
		from 
		rcbill.rcb_ipusageold a 
		inner join 
		(
		-- rcbill.clientcontractdevices 
			select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
		) b 
		on a.cid=b.contractid
		and a.deviceid=b.Deviceid
    ) 
    
    
-- )
;


-- select * from rcbill_my.crimson_usage;
/*
drop table if exists rcbill_my.crimson_usage;
CREATE TABLE rcbill_my.crimson_usage
AS
SELECT *
  FROM crimsonusage
 WHERE 1=1;
*/


select * from rcbill_my.crimson_usage where clientcode='I.000007067';

select clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac, date(min(USAGEDATE)) as firstdate, date(max(USAGEDATE)) as lastdate, datediff(date(max(USAGEDATE)),date(min(USAGEDATE))), sum(mb_used) as mb_used
from 
rcbill_my.crimson_usage
group by clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac
order by 8
;


select clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac, date(min(USAGEDATE)) as firstdate, date(max(USAGEDATE)) as lastdate
-- , datediff(date(max(USAGEDATE)),date(min(USAGEDATE)))
, count(distinct usagedate) as daysused
, sum(mb_used) as mb_used
from 
rcbill_my.crimson_usage
where date(USAGEDATE)>='2017-03-25' and date(USAGEDATE)<='2018-02-28'
group by clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac
order by 8
;



select clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac, count(distinct usagedate), date(min(USAGEDATE)) as firstdate, date(max(USAGEDATE)) as lastdate, datediff(date(max(USAGEDATE)),date(min(USAGEDATE))), sum(mb_used) as mb_used
from 
rcbill_my.crimson_usage
where usagedirection='O'
group by clientcode, clientname, contractcode, USAGEDIRECTION, phoneno, mac
order by clientcode
;





select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Crimson','Crimson Corporate')
and service in ('Subscription Internet','Subscription gNet')
-- and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
 with rollup
;









select a.*, b.*
from 
(
	select period, clientcode, clientname, contractcode, package, clientclass from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate')
	-- and clientname like '%rahul%'
	-- order by period,clientcode;
) a 
left join 
(

	select  a.USAGEDATE, a.CLIENTIP, 
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as processedclientip 
	-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
	, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
	, a.usagedirection, a.octets
	, (a.octets)/(1024.0*1024.0) as MB_USED
	, b.clientid, a.cid, a.csid, a.serviceid  
	, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
	,a.TRAFFICTYPE
	from 
	rcbill.rcb_ipusage a 
	inner join 
    (
	-- rcbill.clientcontractdevices 
		select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
    ) b 
	on a.cid=b.contractid
	and a.deviceid=b.Deviceid
    -- where
    -- b.contractcode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
	-- where
		-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
		-- and 
		-- date(a.USAGEDATE)='2018-02-17'
	-- 	b.clientcode='I.000011750'	
		-- b.clientcode='I.000010761'
-- 	order by a.usagedate desc
) b 
on a.contractcode=b.contractcode
and 
a.period=date(b.usagedate)
;




select a.*,b.*
from 
(
	select  a.USAGEDATE, a.CLIENTIP, 
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as processedclientip 
	-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
	, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
	, a.usagedirection, a.octets
	, (a.octets)/(1024.0*1024.0) as MB_USED
	, b.clientid, a.cid, a.csid, a.serviceid  
	, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
	,a.TRAFFICTYPE
	from 
	rcbill.rcb_ipusage a 
	left join 
	rcbill.clientcontractdevices b 
	on a.cid=b.contractid
	and a.deviceid=b.Deviceid
	-- where
		-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
		-- and 
		-- date(a.USAGEDATE)='2018-02-17'
	-- 	b.clientcode='I.000011750'	
		-- b.clientcode='I.000010761'
	order by a.usagedate desc
) a 

;



(

	select  a.USAGEDATE, a.CLIENTIP, 
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as processedclientip 
	-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
	, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
	, a.usagedirection, a.octets
	, (a.octets)/(1024.0*1024.0) as MB_USED
	, b.clientid, a.cid, a.csid, a.serviceid  
	, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
	,a.TRAFFICTYPE
	from 
	rcbill.rcb_ipusage a 
	left join 
	rcbill.clientcontractdevices b 
	on a.cid=b.contractid
	and a.deviceid=b.Deviceid
	-- where
		-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
		-- and 
		-- date(a.USAGEDATE)='2018-02-17'
	-- 	b.clientcode='I.000011750'	
		-- b.clientcode='I.000010761'
	order by a.usagedate desc
) 
union
(

	select  a.USAGEDATE, a.CLIENTIP, 
	-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
	case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
	else INET_NTOA(a.clientip)
	end as processedclientip 
	-- INET_NTOA(a.clientip) as processedclientip, INET_NTOA((a.clientip+4294967296)) as PIP
	, b.contractcode, b.contracttype, b.clientcode, b.clientname, b.clientaddress
	, a.usagedirection, a.octets
	, (a.octets)/(1024.0*1024.0) as MB_USED
	, b.clientid, a.cid, a.csid, a.serviceid  
	, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
	,a.TRAFFICTYPE
	from 
	rcbill.rcb_ipusageold a 
	left join 
	rcbill.clientcontractdevices b 
	on a.cid=b.contractid
	and a.deviceid=b.Deviceid
	-- where
		-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
		-- and 
		-- date(a.USAGEDATE)='2018-02-17'
	-- 	b.clientcode='I.000011750'	
		-- b.clientcode='I.000010761'
	order by a.usagedate desc
) 
;

