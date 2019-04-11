select * from rcbill_my.dailysales;

-- show columns from rcbill_my.sales;
select * from rcbill_my.sales order by orderday desc;
select state, count(*) from rcbill_my.sales group by 1;
select * from rcbill_my.sales where salescenter=saleschannel;
select 



select orderday, region, salescenter, salestype, state, orderstatus, count(*)
from rcbill_my.sales
where 
0=0
group by 1,2,3, 4, 5, 6

order by orderday desc
,region asc, salescenter, salestype, state, orderstatus
;


select orderday, salescenter, salestype, state, orderstatus, count(*)
from rcbill_my.sales
where 
0=0
group by 1,2,3, 4, 5

order by orderday desc
,salescenter, salestype, state, orderstatus
;


select orderday, region, salescenter, salestype, orderstatus, count(*)
from rcbill_my.sales
where 
0=0
group by 1,2,3, 4, 5

order by orderday desc
,region asc, salescenter, salestype, orderstatus
;


select orderday, salescenter, salestype, orderstatus, count(*)
from rcbill_my.sales
where 
0=0
group by 1,2,3, 4

order by orderday desc
,salescenter, salestype, orderstatus
;

select orderday, salescenter, salestype,  count(*) as ordercount
from rcbill_my.sales
where 
0=0
and orderstatus='Processed'
group by 1,2,3

order by orderday desc
,salescenter, salestype
;

-- =========================================================================

drop table if exists rcbill_my.rep_dailysales;
create table rcbill_my.rep_dailysales as
(
		select orderday, weekday, salescenter, salestype,  count(*) as ordercount
		from rcbill_my.sales
		where 
		0=0
		and orderstatus='Processed'
		group by 1,2,3,4

		order by orderday, salescenter, salestype        

);

-- select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;


set session group_concat_max_len = 100000;
set innodb_strict_mode             = 0;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(orderday = '''
				, orderday
				, ''', ordercount,0))  AS `'
				, replace(orderday,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_dailysales where year(orderday)>=2019
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_dailysales_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_dailysales_pv as (SELECT salescenter, salestype, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_dailysales where year(orderday)>=2019
		   GROUP BY salescenter, salestype)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

-- select * from rcbill_my.rep_dailysales_pv;

-- =========================================================================

drop table if exists rcbill_my.rep_dailysalesreg;
create table rcbill_my.rep_dailysalesreg as
(
		select orderday, weekday, region, salescenter, salestype, count(*) as ordercount
		from rcbill_my.sales
		where 
		0=0
		and orderstatus='Processed'
		group by 1,2,3,4,5

		order by orderday ,salescenter, salestype, region        

);

-- select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;


set session group_concat_max_len = 100000;
set innodb_strict_mode             = 0;
SET @sql_dynamic = (
	SELECT
		GROUP_CONCAT( DISTINCT
			CONCAT(
				'  sum(IF(orderday = '''
				, orderday
				, ''', ordercount,0))  AS `'
				, replace(orderday,'-','') , '`'
			)
		)
	FROM rcbill_my.rep_dailysalesreg where year(orderday)>=2019
);

-- select @sql_dynamic;

drop table if exists rcbill_my.rep_dailysalesreg_pv; 

SET @sql = CONCAT('create table rcbill_my.rep_dailysalesreg_pv as (SELECT salescenter, salestype, region, ', 
			  @sql_dynamic, ' 
		   FROM 
				rcbill_my.rep_dailysalesreg where year(orderday)>=2019
		   GROUP BY salescenter, salestype, region)'
	   );

-- select @sql;
	 
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

set session group_concat_max_len = 1024;

-- select * from rcbill_my.rep_dailysalesreg_pv;
