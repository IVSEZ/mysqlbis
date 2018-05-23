use rcbill_my;

use rcbill_my;

set @gamingdate='2017-12-23 00:00:00';
 
select * from rcbill.clientcontractdevices
where mac in 
(
  select REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3 from rcbill_my.dhcp_hosts where expiry>=@gamingdate
);



-- select *, REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3 from rcbill_my.dhcp_hosts where expiry>=@gamingdate;

select name, cpe_mac, cm_mac, relay_ip, client_ip, ip_pool, expiry, REPLACE(IF(LENGTH(CM_MAC)>0, CM_MAC, CPE_MAC), ":", ".") as mac3
from rcbill_my.dhcp_hosts where expiry>=@gamingdate; 

	select a.*, b.name, b.cpe_mac, b.cm_mac, b.relay_ip, b.client_ip, b.ip_pool, b.expiry, REPLACE(IF(LENGTH(b.CM_MAC)>0, b.CM_MAC, b.CPE_MAC), ":", ".") as mac3
	from 
	rcbill_my.dailygamingusage a
	inner join 
	rcbill_my.dhcp_hosts b 
	on 
	a.ip=b.client_ip
	where b.expiry>=@gamingdate
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
	rcbill_my.dhcp_hosts b 
	on 
	a.ip=b.client_ip
	where b.expiry>=@gamingdate
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
		rcbill_my.dhcp_hosts b 
		on 
		a.ip=b.client_ip
		where b.expiry>=@gamingdate
	) b 
	on 
	a.mac=b.mac3
	and 
	a.ContractType in ('BUNDLE (CI)','BUNDLE (GPON)','CAPPED GNET','CAPPED INTERNET','GNET','INTERNET') 
) a 
group by clientid, clientcode, clientname, contractcode, mac, mac3, name, ip_pool
order by 11 desc
;


