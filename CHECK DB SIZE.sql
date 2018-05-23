-- use rcbill;
-- use rcbill_my;

SELECT table_schema `Database`,
    Round(Sum(data_length + index_length) / 1024 / 1024, 1) `Size in MB`
FROM information_schema.TABLES
GROUP BY table_schema
with rollup
;


SELECT table_schema `Database`, table_name `Table`,
    Round(Sum(data_length + index_length) / 1024 / 1024, 1) `Size in MB`
FROM information_schema.TABLES
where TABLE_SCHEMA in ('rcbill','rcbill_my')
GROUP BY table_schema, table_name
with rollup
-- order by 1, 3 desc

;

-- some comments here

-- select * from information_schema.TABLES;

select * from information_schema.columns
where table_schema = 'rcbill'
order by table_name,ordinal_position;


select * from information_schema.columns
where table_schema = 'rcbill_my'
order by table_name,ordinal_position;