
-- select resource, jan from rcbill_my.rep_tspivot2023 order by jan desc;

-- select * from rcbill_my.rep_tspivot2023 order by total_sessions desc ;

drop table if exists rcbill_my.rep_tsranking2023;

create table rcbill_my.rep_tsranking2023 as
(
	select a.resource as `RESOURCE`
	, a.`JAN_RANK` as `JAN`
	, b.`FEB_RANK` as `FEB`
	, c.`MAR_RANK` as `MAR`
	, d.`APR_RANK` as `APR`
	, e.`MAY_RANK` as `MAY`
	, f.`JUN_RANK` as `JUN`
	, g.`JUL_RANK` as `JUL`
	, h.`AUG_RANK` as `AUG`
	, i.`SEP_RANK` as `SEP`
	, j.`OCT_RANK` as `OCT`
	, k.`NOV_RANK` as `NOV`
	, l.`DEC_RANK` as `DEC`
	, m.`OVERALL_RANK` as `OVERALL`
	from 
	(
	select resource, JAN,
		  -- @rownum1 := @rownum1 + 1 as `JAN_RANK`
		  case when JAN = 0 then NULL else @rownum1 := @rownum1 + 1 end as `JAN_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum1 := 0) r
	order by `JAN` desc
	) a 
	inner join
	(
	select resource, FEB,
		  -- @rownum2 := @rownum2 + 1 as `FEB_RANK`
		  case when FEB = 0 then NULL else @rownum2 := @rownum2 + 1 end as `FEB_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum2 := 0) r
	order by `FEB` desc
	) b 
	on a.resource=b.resource

	inner join
	(
	select resource, MAR,
		  -- @rownum3 := @rownum3 + 1 as `MAR_RANK`
		  case when MAR = 0 then NULL else @rownum3 := @rownum3 + 1 end as `MAR_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum3 := 0) r
	order by `MAR` desc
	) c
	on a.resource=c.resource

	inner join
	(
	select resource, APR,
		  -- @rownum4 := @rownum4 + 1 as `APR_RANK`
		  case when APR = 0 then NULL else @rownum4 := @rownum4 + 1 end as `APR_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum4 := 0) r
	order by `APR` desc
	) d
	on a.resource=d.resource


	inner join
	(
	select resource, MAY,
		  -- @rownum5 := @rownum5 + 1 as `MAY_RANK`
		  case when MAY = 0 then NULL else @rownum5 := @rownum5 + 1 end as `MAY_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum5 := 0) r
	order by `MAY` desc
	) e
	on a.resource=e.resource


	inner join
	(
	select resource, JUN,
		  -- @rownum6 := @rownum6 + 1 as `JUN_RANK`
		  case when JUN = 0 then NULL else @rownum6 := @rownum6 + 1 end as `JUN_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum6 := 0) r
	order by `JUN` desc
	) f
	on a.resource=f.resource


	inner join
	(
	select resource, JUL,
		  -- @rownum7 := @rownum7 + 1 as `JUL_RANK`
		  case when JUL = 0 then NULL else @rownum7 := @rownum7 + 1 end as `JUL_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum7 := 0) r
	order by `JUL` desc
	) g
	on a.resource=g.resource


	inner join
	(
	select resource, AUG,
		  -- @rownum8 := @rownum8 + 1 as `AUG_RANK`
		  case when AUG = 0 then NULL else @rownum8 := @rownum8 + 1 end as `AUG_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum8 := 0) r
	order by `AUG` desc
	) h
	on a.resource=h.resource


	inner join
	(
	select resource, SEP,
			case when SEP = 0 then NULL else @rownum9 := @rownum9 + 1 end as `SEP_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum9 := 0) r
	-- where `SEP`<>0
	order by `SEP` desc
	) i
	on a.resource=i.resource


	inner join
	(
	select resource, OCT,
		  -- @rownum10 := @rownum10 + 1 as `OCT_RANK`
		  case when OCT = 0 then NULL else @rownum10 := @rownum10 + 1 end as `OCT_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum10 := 0) r
	order by `OCT` desc
	) j
	on a.resource=j.resource


	inner join
	(
	select resource, NOV,
		  -- @rownum11 := @rownum11 + 1 as `NOV_RANK`
		  case when NOV = 0 then NULL else @rownum11 := @rownum11 + 1 end as `NOV_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum11 := 0) r
	order by `NOV` desc
	) k
	on a.resource=k.resource


	inner join
	(
	select resource, `DEC`,
		  -- @rownum12 := @rownum12 + 1 as `DEC_RANK`
		  case when `DEC` = 0 then NULL else @rownum12 := @rownum12 + 1 end as `DEC_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum12 := 0) r
	order by `DEC` desc
	) l
	on a.resource=l.resource


	inner join
	(
	select resource, TOTAL_SESSIONS,
		  -- @rownum13 := @rownum13 + 1 as `OVERALL_RANK`
		  case when `TOTAL_SESSIONS` = 0 then NULL else @rownum13 := @rownum13 + 1 end as `OVERALL_RANK`
	from rcbill_my.rep_tspivot2023
	cross join (select @rownum13 := 0) r
	order by `TOTAL_SESSIONS` desc
	) m
	on a.resource=m.resource

)
;

-- select * from rcbill_my.rep_tsranking2023 order by overall asc;