use rcbill_my;

drop table if exists rcbill_my.crimson_usage3;


-- 841.125 sec

drop table if exists tempcca;
create table tempcca 
(INDEX idxcca1 (contractid), INDEX idxcca2 (csid), INDEX idxcca3 (period)) 
as
(
			select a.contractcode as a_contractcode, a.period, b.* from 
			(
			 select distinct contractcode, period from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate')
			 ) a
			 left join
			 -- rcbill.clientcontractdevices b 
             (
				select * from rcbill.clientcontractdevices where ServiceId in (19,115,128,137,139,143,144)
             ) b
			 on a.contractcode=b.contractcode	
)
;

-- select * from tempcca where period='2018-02-13' and contractid = 2098687 and csid=3857865;
-- Duration 16736.469 sec / 5 hours

create table rcbill_my.crimson_usage3 as
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
		-- (
		-- rcbill.clientcontractdevices 
		-- 	select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
			/*
            select a.contractcode as a_contractcode, a.period, b.* from 
			(
			 select distinct contractcode, period from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate')
			 ) a
			 left join
			 rcbill.clientcontractdevices b 
			 on a.contractcode=b.contractcode	
			*/
           -- tempcca
        
        -- ) 
        tempcca b 
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
		-- (
		-- rcbill.clientcontractdevices 
		-- 	select * from rcbill.clientcontractdevices where ContractCode in (select distinct contractcode from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate'))
			/*
            select a.contractcode as a_contractcode, a.period, b.* from 
			(
			 select distinct contractcode, period from rcbill_my.customercontractactivity where package in ('Crimson','Crimson Corporate')
			 ) a
			 left join
			 rcbill.clientcontractdevices b 
			 on a.contractcode=b.contractcode	
			*/
          --  tempcca
        
        -- ) 
        tempcca b 
		on a.cid=b.contractid
		and a.csid=b.csid
        and date(a.USAGEDATE)=b.period
		-- and a.deviceid=b.Deviceid
    ) 
    
    
-- )
;


select * from rcbill_my.crimson_usage3;

