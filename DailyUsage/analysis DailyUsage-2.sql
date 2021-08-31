use rcbill_usage;

select count(*) from sandvine_usage;

show columns from sandvine_usage;
show index from sandvine_usage;

select date(timestamp) as u_date, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1
;

select date(timestamp) as u_date, signature_service_category, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;

select date(timestamp) as u_date, signature_service_category, signature_service_name, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2,3
;

select date(timestamp) as u_date, service_plan, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;