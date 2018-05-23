drop table if exists rcbill_my.amber_usage;

-- duration 1883.640 sec

create table rcbill_my.amber_usage as
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
		-- 	select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
			select a.contractcode as a_contractcode,a.period, b.* from 
			(
			 select distinct contractcode, period from rcbill_my.customercontractactivity where package in ('Amber','Amber Corporate')
			 ) a
			 left join
			 rcbill.clientcontractdevices b 
			 on a.contractcode=b.contractcode	
        
        
        ) b 
		on a.cid=b.contractid
        and a.csid=b.csid
		and date(a.USAGEDATE)=b.period
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
		-- 	select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
			select a.contractcode as a_contractcode,a.period, b.* from 
			(
			 select distinct contractcode, period from rcbill_my.customercontractactivity where package in ('Amber','Amber Corporate')
			 ) a
			 left join
			 rcbill.clientcontractdevices b 
			 on a.contractcode=b.contractcode	

        
        ) b 
		on a.cid=b.contractid
        and a.csid=b.csid
        and date(a.USAGEDATE)=b.period
		-- and a.deviceid=b.Deviceid
    ) 
    
    
-- )
;


select * from rcbill_my.amber_usage;


-- select * from rcbill_my.amber_usage where USAGEDATE>='2018-02-01' and USAGEDATE<='2018-04-30';

select a.package, a.USAGEDATE, a.CLIENTIP, a.CLIENTCODE, a.CLIENTNAME, a.CONTRACTCODE

, a.CONTRACTTYPE, a.DEVICE
, a.TRAFFICTYPENAME 
, sum(a.UPLOAD_MB) as UPLOAD_MB
, sum(a.DOWNLOAD_MB) as DOWNLOAD_MB
, (sum(a.UPLOAD_MB)+sum(a.DOWNLOAD_MB)) as TOTAL_MB
, ((sum(a.UPLOAD_MB)+sum(a.DOWNLOAD_MB))/1024) as TOTAL_GB
from 
(

		select a.package, date(a.USAGEDATE) as USAGEDATE, a.processedclientip as CLIENTIP, a.clientcode as CLIENTCODE, a.clientname as CLIENTNAME, a.contractcode as CONTRACTCODE
		, a.contracttype as CONTRACTTYPE, a.phoneno as DEVICE
        , a.traffictype
		, c.Name as TRAFFICTYPENAME
		, case when a.usagedirection='O' then MB_USED else 0 end as `UPLOAD_MB`
		, case when a.usagedirection='I' then MB_USED else 0 end as `DOWNLOAD_MB`
		from 
        (
				select cca.package , a.* from rcbill_my.amber_usage a
				left join 
				rcbill_my.customercontractactivity cca
				on 
				a.CLIENTCODE=cca.clientcode
				and
				a.CONTRACTCODE=cca.contractcode
				and
				a.usagedate=cca.period
		) a
        left join 
		rcbill.rcb_traffictypes c
		on a.traffictype=c.id
) a
where a.package='Amber'
group by 1,2,3,4,5,6,7,8,9
order by a.USAGEDATE desc
;
