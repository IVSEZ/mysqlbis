select * from rcbill.rcb_ipusage limit 1000;

SELECT INET_ATON('41.203.243.61');

SELECT INET_NTOA('701231933');

select usagedate, deviceid, TRAFFICTYPE, clientip, INET_NTOA(clientip) as processedclientip, usagedirection, octets, cid, csid, serviceid from rcbill.rcb_ipusage where CLIENTIP in (select INET_ATON('41.203.244.36'));

select * from rcbill.clientcontractdevices where contractid in (2139598);

select * from rcbill.rcb_devices where contractid in (2139598);

select a.*, b.*
from 
(
	select usagedate, deviceid, TRAFFICTYPE, clientip, INET_NTOA(clientip) as processedclientip, usagedirection, octets, cid, csid, serviceid 
	from rcbill.rcb_ipusage 
    where 
    CLIENTIP in (select INET_ATON('41.203.244.36'))
    and 
    date(USAGEDATE)='2018-02-17'
) a 
left join
rcbill.clientcontractdevices b on a.cid=b.contractid
and a.deviceid=b.Deviceid
order by usagedate 

;

select  a.USAGEDATE, a.CLIENTIP
-- ,  INET_NTOA(a.clientip) as processedclientip
,
-- all negative integers to be added with this number https://it.toolbox.com/question/function-required-to-convert-negative-ip-addresses-to-dotted-notation-021513
case when a.clientip<0 then INET_NTOA((a.clientip+4294967296)) 
else INET_NTOA(a.clientip)
end as processedclientip 

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
where
    a.CLIENTIP in (select INET_ATON('41.203.244.36'))
    -- and 
    -- date(a.USAGEDATE)='2018-02-17'
order by a.usagedate desc
;


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
where
    -- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
    -- and 
    -- date(a.USAGEDATE)='2018-02-17'
	b.clientcode='I.000011750'	
    -- b.clientcode='I.000010761'
order by a.usagedate desc
;


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
where
    -- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
    -- and 
    -- date(a.USAGEDATE)='2018-02-17'
	b.clientcode='I.000011750'	
    -- b.clientcode='I.000010761'
order by a.usagedate desc
;

select distinct traffictype from rcbill.rcb_ipusageold order by traffictype;

select distinct traffictype from rcbill.rcb_ipusage order by traffictype;
