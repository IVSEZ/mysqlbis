/*  
### FROM PLAMEN

select left(d.mac,8), count(*)
from devices d
join services s on s.id = d.SERVICEID and s.ServiceTypeID=-16 where mac like '%.%.%.%.%.%'
group by left(d.mac,8)
having count(*)>2;
*/

##### TO GET THE STARTING MAC ADDRESS OF THE DEVICES
##### THIS MAC ADDRESS CAN BE LOOKED AGAINST https://maclookup.app/ TO FIND THE MANUFACTURER

select upper(trim(replace(left(d.mac,8),'.',':'))) as mac_prefix, count(*)
from rcbill.rcb_devices d
join rcbill.rcb_services s on s.id = d.SERVICEID and s.ServiceTypeID=-16 
-- where mac in ('cc.d3.e2.82.a5.ae','68.db.67.59.9b.4e','0c.56.5c.65.c6.c1','0c:56:5c:7d:21:3a')
group by left(d.mac,8)
-- having count(*)>2
order by 2 desc
;

-- hareen : cc:d3:e2:82:a5:ae
-- reza office: 0c:56:5c:7d:21:3a
-- rahul : 68:db:67:59:9b:4e, 0c:56:5c:65:c6:c1
  -- where mac in ('68.db.67.59.9b.4e','0c.56.5c.65.c6.c1')
  -- where mac in ('cc.d3.e2.82.a5.ae')
  
--  select * from rcbill.rcb_devices limit 1000;
--  select * from rcbill.rcb_services where servicetypeid=-16 limit 1000;
  
  
  select a.*,b.*
  from 
  ( 
		select upper(trim(replace(left(d.mac,8),'.',':'))) as mac_prefix, count(*) as devices
		from rcbill.rcb_devices d
		join rcbill.rcb_services s on s.id = d.SERVICEID and s.ServiceTypeID=-16 
		-- where mac in ('cc.d3.e2.82.a5.ae','68.db.67.59.9b.4e','0c.56.5c.65.c6.c1')
		group by left(d.mac,8)
		-- having count(*)>2
		order by 2 desc  
  ) a 
  left join 
  rcbill_my.mac_vendors b 
  on a.mac_prefix=b.macprefix
  ;
  
select a.* from rcbill_my.rep_clientcontractdevices a;

select MAC_VENDOR, MAC_PREFIX, DEVICE_NAME, GATEKEEPER_NAME, count(distinct client_code) as d_clients, count(distinct contract_code) as d_contracts
from rcbill_my.rep_clientcontractdevices
group by 1,2,3,4
order by 5 desc
;



