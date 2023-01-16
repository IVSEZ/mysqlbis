
-- select resource, jan from rcbill_my.rep_vodpivot2023 order by jan desc;

-- select * from rcbill_my.rep_vodpivot2023 order by total_duration desc ;

drop table if exists rcbill_my.rep_vodranking2023_1;

create table rcbill_my.rep_vodranking2023_1 as
(
	select a.title as `TITLE`, a.resource as `RESOURCE`
	, a.`JAN_RANK` as `JAN`
	, b.`FEB_RANK` as `FEB`
	, c.`MAR_RANK` as `MAR`
	, d.`APR_RANK` as `APR`
	, e.`MAY_RANK` as `MAY`
	, f.`JUN_RANK` as `JUN`
	-- , m.`OVERALL_RANK` as `OVERALL`
	from 
	(
	select title, resource, JAN,
		  -- @rownum1 := @rownum1 + 1 as `JAN_RANK`
		  case when JAN = 0 then NULL else @rownum1 := @rownum1 + 1 end as `JAN_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum1 := 0) r
	order by `JAN` desc
	) a 
	inner join
	(
	select resource, FEB,
		  -- @rownum2 := @rownum2 + 1 as `FEB_RANK`
		  case when FEB = 0 then NULL else @rownum2 := @rownum2 + 1 end as `FEB_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum2 := 0) r
	order by `FEB` desc
	) b 
	on a.resource=b.resource

	inner join
	(
	select resource, MAR,
		  -- @rownum3 := @rownum3 + 1 as `MAR_RANK`
		  case when MAR = 0 then NULL else @rownum3 := @rownum3 + 1 end as `MAR_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum3 := 0) r
	order by `MAR` desc
	) c
	on a.resource=c.resource

	inner join
	(
	select resource, APR,
		  -- @rownum4 := @rownum4 + 1 as `APR_RANK`
		  case when APR = 0 then NULL else @rownum4 := @rownum4 + 1 end as `APR_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum4 := 0) r
	order by `APR` desc
	) d
	on a.resource=d.resource


	inner join
	(
	select resource, MAY,
		  -- @rownum5 := @rownum5 + 1 as `MAY_RANK`
		  case when MAY = 0 then NULL else @rownum5 := @rownum5 + 1 end as `MAY_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum5 := 0) r
	order by `MAY` desc
	) e
	on a.resource=e.resource


	inner join
	(
	select resource, JUN,
		  -- @rownum6 := @rownum6 + 1 as `JUN_RANK`
		  case when JUN = 0 then NULL else @rownum6 := @rownum6 + 1 end as `JUN_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum6 := 0) r
	order by `JUN` desc
	) f
	on a.resource=f.resource

	/*
	inner join
	(
	select resource, TOTAL_DURATION,
		  -- @rownum13 := @rownum13 + 1 as `OVERALL_RANK`
		  case when `TOTAL_DURATION` = 0 then NULL else @rownum13 := @rownum13 + 1 end as `OVERALL_RANK`
	from rcbill_my.rep_vodpivot2023
	cross join (select @rownum13 := 0) r
	order by `TOTAL_DURATION` desc
	) m
	on a.resource=m.resource
	*/
)
;

-- select * from rcbill_my.rep_vodranking2023_1 order by overall asc;
-- select * from rcbill_my.rep_vodranking2023_1 where resource like '2023%' order by overall asc;

