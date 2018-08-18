/*
select * from rcbill_my.rep_livetvstats;
select * from rcbill_my.rep_vodstats;
select * from rcbill_my.rep_tsstats;
select * from rcbill_my.rep_radiostats;

select * from rcbill.rcb_livetvtelemetry limit 100;
select * from rcbill.rcb_vodtelemetry limit 100;
select * from rcbill.rcb_tstelemetry limit 100;
select * from rcbill.rcb_radiotelemetry limit 100;


*/


select duration, instances, SEC_TO_TIME(duration) as in_time from 
(
	select duration, count(*) as instances from rcbill.rcb_livetvtelemetry 
	group by duration
	order by 2 desc
) a 
where duration > 14000
-- order by duration desc
;
-- the most common 3 durations are 14431, 14430 and 14429. remove them from the data


select * from rcbill.rcb_livetvtelemetry where subscriber in ('0c.56.5c.65.c6.c1');
select * from rcbill.rcb_livetvtelemetry where duration in (1715737,1644168, 1452617);
select * from rcbill.rcb_livetvtelemetry where duration > 1160000;
select * from rcbill.rcb_livetvtelemetry where duration in (14431);

select date(sessionstart) as sessiondate, resource, count(*) as instances, sum(duration) as session_duration, SEC_TO_TIME(sum(duration)) as in_time
from 
rcbill.rcb_livetvtelemetry
group by 1, 2
; 

select date(sessionstart) as sessiondate, resource, count(*) as instances, sum(duration) as session_duration, SEC_TO_TIME(sum(duration)) as in_time
from 
rcbill.rcb_livetvtelemetry
where duration not in (14431, 14430 and 14429)
group by 1, 2
; 


-- select * from rcbill.rcb_livetvtelemetry where device <> subscriber;

explain
select a.*, b.client_code, b.client_name,b.contract_type, b.service_type, b.mac
from 
(
	select device, resource, duration, subscriber, date(sessionstart) as session_start
	from rcbill.rcb_livetvtelemetry 
    -- where date(SESSIONSTART)>='2018-04-01'
) a
left join rcbill_my.rep_clientcontractdevices b
on a.device=b.mac
;
-- select * from rcbill_my.rep_clientcontractdevices;



