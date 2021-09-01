use rcbill_usage;

select count(*) from sandvine_usage;

show columns from sandvine_usage;
show index from sandvine_usage;

select date(timestamp) as u_date, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1
;


select * from sandvine_usage limit 100;

select * from rcbill.clientcontractdevices where length(mac)>0; -- limit 100;
select * from rcbill_my.rep_clientcontractdevices where length(mac)>0; -- limit 100;

select * from sandvine_usage where subscriber='00:02:71:cd:0c:89';
select * from sandvine_usage where upper(subscriber)='00:02:71:cd:10:71';


select date(timestamp) as u_date, signature_service_category, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;

select date(timestamp) as u_date, signature_service_category, signature_service_name, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2,3
;

select timestamp as u_date, service_plan, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;

select timestamp as u_date, location, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;