use rcbill_my;

use rcbill_my;

set @amberdate='2021-04-07 00:00:00';

-- CRIMSON TO AMBER
-- SUBNET 197.234.0.0 to 197.234.0.254

drop temporary table if exists crimtoamber;
create temporary table crimtoamber as
( 
	select * from rcbill_my.dhcp_hosts where date(INSERTEDON)='2018-01-16' and IP_POOL='hfc_crimson' and CLIENT_IP like '197.234.0.%' and date(EXPIRY)>=date(@amberdate)
);
 
select * from rcbill.clientcontractdevices
where mac in 
(
  select REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3 from 
  crimtoamber
)
and mac=phoneno
order by clientname
;



-- select *, REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3 from rcbill_my.dhcp_hosts where expiry>=@amberdate;

select name, cpe_mac, cm_mac, relay_ip, client_ip, ip_pool, expiry, REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3
from crimtoamber
; 

	select a.*, b.name, b.cpe_mac, b.cm_mac, b.relay_ip, b.client_ip, b.ip_pool, b.expiry, REPLACE(IF(LENGTH(b.CM_MAC)>0, b.CM_MAC, b.CPE_MAC), ":", ".") as mac3
	from 
	rcbill_my.dailygamingusage a
	inner join 
	crimtoamber b 
	on 
	a.ip=b.client_ip
	-- where 
    -- b.expiry>=@amberdate
    ;
    
select a.*, b.*, (b.totalbytes/1048576) as TOTALMB, (b.totalbytes/1073741824) as TOTALGB
from 
rcbill.clientcontractdevices a 
right join 
(
	select a.*, b.name, b.cpe_mac, b.cm_mac, b.relay_ip, b.client_ip, b.ip_pool, b.expiry, REPLACE(IF(LENGTH(b.CM_MAC)>0, b.CM_MAC, b.CPE_MAC), ":", ".") as mac3
	from 
	rcbill_my.dailygamingusage a
	inner join 
	crimtoamber b 
	on 
	a.ip=b.client_ip
	-- where b.expiry>=@amberdate
) b 
on 
a.mac=b.mac3
and 
a.ContractType in ('BUNDLE (CI)','BUNDLE (GPON)','CAPPED GNET','CAPPED INTERNET','GNET','INTERNET') -- 'INTERNET'
;


select distinct clientid, clientcode, clientname, contractcode, mac, mac3, name, ip_pool, count(ip) as countip, sum(totalmb) as TOTAL_MB, sum(totalgb) as TOTAL_GB 
from 
(
	select a.*, b.*, (b.totalbytes/1048576) as TOTALMB, (b.totalbytes/1073741824) as TOTALGB
	from 
	rcbill.clientcontractdevices a 
	right join 
	(
		select a.*, b.name, b.cpe_mac, b.cm_mac, b.relay_ip, b.client_ip, b.ip_pool, b.expiry, REPLACE(IF(LENGTH(b.CM_MAC)>0, b.CM_MAC, b.CPE_MAC), ":", ".") as mac3
		from 
		rcbill_my.dailygamingusage a
		inner join 
		crimtoamber b 
		on 
		a.ip=b.client_ip
		-- where b.expiry>=@amberdate
	) b 
	on 
	a.mac=b.mac3
	and 
	a.ContractType in ('BUNDLE (CI)','BUNDLE (GPON)','CAPPED GNET','CAPPED INTERNET','GNET','INTERNET') 
) a 
group by clientid, clientcode, clientname, contractcode, mac, mac3, name, ip_pool
order by 11 desc
;


