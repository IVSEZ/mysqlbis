#######
/*
ORDERS CREATED
INSTALLATION TICKETS
GPON CONVERSIONS
TICKETS RAISED
CALLS MADE
ONLINE PAYMENTS
BIGGEST COLLECTIONS
MOST ACTIVE
LEAST ACTIVE
MOST TV WATCHED
MOST VOD WATCHED
TOP 10 MOVIES / SERIES
DATA USED CAPPED VS UNCAPPED


*/

-- ==================================
select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;
select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;
SELECT year(orderday) as orderyear, salestype, sum(ordercount) as orders from rcbill_my.rep_dailysales group by 1,2;
-- ==================================

#SERVICE TICKETS
select * from rcbill_my.rep_servicetickets_2019 limit 100;
select * from rcbill_my.rep_servicetickets_2018 limit 100;

select 
case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
-- , service
, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2
;

select 
case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, service
-- , month(opendate) as tkt_month
, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2
;

select 
case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, tickettype
-- , month(opendate) as tkt_month
, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2
;

select 
case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, service
, tickettype
, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2, 3
;

select tickettype, month(opendate) as tkt_month, count(distinct ticketid) as tkt_count
from rcbill_my.rep_servicetickets_2019
group by 1,2
;


