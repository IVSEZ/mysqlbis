-- select * from rcbill_my.dailyusage limit 1000;

select datestart, traffictype, clientcode, clientname,(traffic_mb) as traffic_mb, (sum(traffic_mb)/1024) as traffic_gb from rcbill_my.dailyusage where clientcode='I.000006611' and datestart>='2018-01-24'
group by datestart, traffictype, clientcode, clientname
;

select datestart, traffictype, clientcode, clientname,(traffic_mb) as traffic_mb, (sum(traffic_mb)/1024) as traffic_gb 
from rcbill_my.dailyusage where clientcode='I.000006611' 
and datestart>='2017-11-01' and datestart<='2017-11-30'
group by datestart, traffictype, clientcode, clientname
;



-- Mathew During
select datestart, traffictype, clientcode, clientname,(traffic_mb) as traffic_mb, (sum(traffic_mb)/1024) as traffic_gb 
from rcbill_my.dailyusage where clientcode='I.000016996' 
-- and datestart>='2017-11-01' and datestart<='2017-11-30'
group by datestart, traffictype, clientcode, clientname
with rollup
;

-- Nathalia Mishicheva 
select datestart, traffictype, clientcode, clientname,(traffic_mb) as traffic_mb, (sum(traffic_mb)/1024) as traffic_gb 
from rcbill_my.dailyusage where clientcode='I.000016982' 
-- and datestart>='2017-11-01' and datestart<='2017-11-30'
group by datestart, traffictype, clientcode, clientname
-- with rollup
;