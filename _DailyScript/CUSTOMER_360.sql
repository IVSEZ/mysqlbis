/*CUSTOMER 360*/

/*
CUSTOMER has ACCOUNT has CONTRACT has SUBSCRIPTION
ACCOUNT has CONTRACT, COMMENTS
CONTRACT has SUBSCRIPTION, TICKETS, DEVICES, TELEMETRY
SUBSCRIPTION has ACTIVITY STATUS, USAGE, PAYMENT, TELEMETRY


CUSTOMER tables

RCBILL
clientcontracts
clientcontractsubs
clientcontracthistory (NOT NEEDED as clientextendedreport has all the information)
clientcontractinvpmt (per contract payment details)
clientcontractdiscounts
clientextendedreport
clientcontractdevices (per contract devices)


RCBILL_MY
callingclients (gives possible client matches based on numbers that have called 4414243)
*/

use rcbill;
-- set @clientcode='I.000011750';
-- set @clientcode='I.000013630';
set @clientcode='I.000012237';
-- set @clientcode='I.000016982';
-- set @clientcode='I3231';


select * from rcbill_my.customercontractactivity where clientcode in (@clientcode) order by period desc;

select * from rcbill.clientcontracts where CL_CLIENTCODE in (@clientcode) order by CON_CONTRACTID;

select * from rcbill.clientcontractssubs where cl_clientcode in (@clientcode);

select * from rcbill.clientcontracthistory where CL_CLIENTCODE in (@clientcode);

select * from rcbill.clientcontractinvpmt where CL_CLIENTCODE in (@clientcode) order by CON_CONTRACTID;

select * from rcbill.clientcontractdiscounts where clientcode in (@clientcode);

select * from rcbill.clientreport where CL_CLIENTCODE in (@clientcode);

select * from rcbill.clientextendedreport where CL_CLIENTCODE in (@clientcode);

select * from rcbill.clientcontractdevices where clientcode in (@clientcode);

select a.USAGEDATE, a.CLIENTIP, a.CLIENTCODE, a.CLIENTNAME, a.CONTRACTCODE
, cca.package
, a.CONTRACTTYPE, a.SERVICETYPE, a.DEVICE
, a.TRAFFICTYPE
, sum(a.UPLOAD_MB) as UPLOAD_MB
, sum(a.DOWNLOAD_MB) as DOWNLOAD_MB
, (sum(a.UPLOAD_MB)+sum(a.DOWNLOAD_MB)) as TOTAL_MB
, ((sum(a.UPLOAD_MB)+sum(a.DOWNLOAD_MB))/1024) as TOTAL_GB
from
(
		select date(a.USAGEDATE) as USAGEDATE, a.processedclientip as CLIENTIP, a.clientcode as CLIENTCODE, a.clientname as CLIENTNAME, a.contractcode as CONTRACTCODE
		, a.contracttype as CONTRACTTYPE, a.servicetype as SERVICETYPE, a.phoneno as DEVICE
		, a.TRAFFICTYPENAME as TRAFFICTYPE
		, case when a.usagedirection='O' then MB_USED else 0 end as `UPLOAD_MB`
		, case when a.usagedirection='I' then MB_USED else 0 end as `DOWNLOAD_MB`

		from 

		(

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
				, b.clientid, a.cid, a.csid, a.serviceid , b.servicetype 
				, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
				,a.TRAFFICTYPE
				, c.NAME as TRAFFICTYPENAME
				from 
				rcbill.rcb_ipusage a 
				left join
				rcbill.rcb_traffictypes c
				on a.traffictype=c.id

				left join 
				rcbill.clientcontractdevices b 
				on a.cid=b.contractid
                and a.csid=b.csid
                -- and a.SERVICEID=b.ServiceId
				-- and a.deviceid=b.Deviceid
				where
					-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
					-- and 
					-- date(a.USAGEDATE)='2018-02-17'
					b.clientcode in (@clientcode)
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
				, b.clientid, a.cid, a.csid, a.serviceid , b.servicetype   
				, b.phoneno, b.mac, a.deviceid, b.address, b.contractid
				,a.TRAFFICTYPE
				, c.NAME as TRAFFICTYPENAME
				from 
				rcbill.rcb_ipusageold a 
				left join
				rcbill.rcb_traffictypes c
				on a.traffictype=c.id

				left join 
				rcbill.clientcontractdevices b 
				on a.cid=b.contractid
                and a.csid=b.csid
				-- and a.deviceid=b.Deviceid
				where
					-- a.CLIENTIP in (select INET_ATON('41.203.244.36'))
					-- and 
					-- date(a.USAGEDATE)='2018-02-17'
					b.clientcode in (@clientcode)	
					-- b.clientcode='I.000010761'
				order by a.usagedate desc
				)
		) a
) a 
left join 
rcbill_my.customercontractactivity cca
on 
a.CLIENTCODE=cca.clientcode
and
a.CONTRACTCODE=cca.contractcode
and
a.usagedate=cca.period
group by 1,2,3,4,5,6,7,8,9,10
order by a.USAGEDATE desc
;



-- select * from rcbill_my.callingclients where kod in (@clientcode) order by CALL_DATE, CALL_TIME;

-- set @clientcode = 'I.000016982';

-- select * from rcbill_my.crimson_usage where ClientCode in (@clientcode) order by USAGEDATE desc;
-- select * from rcbill_my.crimson_usage2 where ClientCode in (@clientcode) order by USAGEDATE desc;
select * from rcbill_my.amber_usage where ClientCode in (@clientcode) order by USAGEDATE desc;






