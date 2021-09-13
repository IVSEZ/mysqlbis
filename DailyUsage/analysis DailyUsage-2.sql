use rcbill_usage;

select count(*) from sandvine_usage;

show columns from sandvine_usage;
show index from sandvine_usage;

SELECT table_schema `Database`, table_name `Table`,
    Round(Sum(data_length + index_length) / 1024 / 1024, 1) `Total - Size in MB`,
    Round(Sum(data_length) / 1024 / 1024, 1) `Data - Size in MB`,
    Round(Sum(index_length) / 1024 / 1024, 1) `Index  - Size in MB`
FROM information_schema.TABLES
where TABLE_SCHEMA in ('rcbill_usage')
GROUP BY table_schema, table_name
-- with rollup
order by 1, 3 desc
;



select date(timestamp) as u_date, count( distinct subscriber) as u_device, count(*) 
from sandvine_usage
group by 1
order by 1 desc
;

/*

CREATE INDEX idxsu1
ON sandvine_usage (signature_service_category, signature_service_name);

CREATE INDEX idxsu2
ON sandvine_usage (signature_service_category);

CREATE INDEX idxsu3
ON sandvine_usage (signature_service_name);

*/



select * from sandvine_usage limit 100;

select * from rcbill.clientcontractdevices where length(mac)>0; -- limit 100;
select * from rcbill_my.rep_clientcontractdevices where length(mac)>0; -- limit 100;

select * from sandvine_usage where subscriber='00:02:71:cd:0c:89';
select * from sandvine_usage where upper(subscriber)='00:02:71:cd:10:71';
select * from sandvine_usage where (subscriber)='00:02:71:cd:10:71';


select distinct signature_service_category from sandvine_usage;
select distinct signature_service_name from sandvine_usage;
select distinct signature_service_category, signature_service_name from sandvine_usage;

-- 00:02:71:4a:ba:9e
-- 00:02:71:69:6b:ca

select * from rcbill_usage.sandvine_usage where signature_service_category='Remote Access' and signature_service_name='ExpressVPN';
select * from rcbill_usage.sandvine_usage where signature_service_category='File Transfer' and signature_service_name='MEGA';

select timestamp as u_date, signature_service_category,signature_service_name
, device, location, service_plan
, count( distinct subscriber) as u_device, count(*) as u_instance
, round(((sum(bytes_in)/1024)/1024)) as mb_dl
, round(((sum(bytes_out)/1024)/1024)) as mb_ul
from sandvine_usage
where 0=0 
-- and signature_service_category='Streaming Media'
-- and signature_service_name='Netflix'
group by 1,2,3,4,5,6
;




select signature_service_category,signature_service_name
, device, location, service_plan
, count(distinct timestamp) as days
, count( distinct subscriber) as u_device, count(*) as u_instance
, round(((sum(bytes_in)/1024)/1024)) as mb_dl
, round(((sum(bytes_out)/1024)/1024)) as mb_ul
from sandvine_usage
where 0=0 
-- and signature_service_category='Streaming Media'
-- and signature_service_name='Netflix'
group by 1,2,3,4,5
;


select device, location, service_plan
, count(distinct timestamp) as days
, count( distinct subscriber) as u_device, count(*) as u_instance
, round(((sum(bytes_in)/1024)/1024)) as mb_dl
, round(((sum(bytes_out)/1024)/1024)) as mb_ul
from sandvine_usage
where 0=0 
-- and signature_service_category='Streaming Media'
-- and signature_service_name='Netflix'
group by 1,2,3
order by 1,2,3
;



select month(timestamp) as u_month, signature_service_category,signature_service_name
, device, location, service_plan
, count(distinct timestamp) as days
, count( distinct subscriber) as u_device, count(*) as u_instance
, round(((sum(bytes_in)/1024)/1024)) as mb_dl
, round(((sum(bytes_out)/1024)/1024)) as mb_ul
from sandvine_usage
where 0=0 
and signature_service_category='Streaming Media'
-- and signature_service_name='Netflix'
group by 1,2,3,4,5,6
;














select signature_service_category, signature_service_name, count( distinct subscriber) as u_client
, round(((sum(bytes_in)/1024)/1024)) as in_mb
, round(((sum(bytes_out)/1024)/1024)) as out_mb

from sandvine_usage
where 0=0 
and signature_service_category='Streaming Media'
and signature_service_name='Netflix'
group by 1,2
;

select timestamp as u_date, signature_service_category, signature_service_name
, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2,3
;

select timestamp as u_date, service_plan, count( distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;

select timestamp as u_date, location, count(distinct subscriber) as u_client, count(*) 
from sandvine_usage
group by 1,2
;