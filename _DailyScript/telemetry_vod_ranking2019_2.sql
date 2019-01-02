
-- select resource, jan from rcbill_my.rep_vodpivot2019 order by jan desc;

-- select * from rcbill_my.rep_vodpivot2019 order by total_duration desc ;

drop table if exists rcbill_my.rep_vodranking2019_2;

create table rcbill_my.rep_vodranking2019_2 as
(
	select g.title as `TITLE`, g.resource as `RESOURCE`
	, g.`JUL_RANK` as `JUL`
	, h.`AUG_RANK` as `AUG`
	, i.`SEP_RANK` as `SEP`
	, j.`OCT_RANK` as `OCT`
	, k.`NOV_RANK` as `NOV`
	, l.`DEC_RANK` as `DEC`
	-- , m.`OVERALL_RANK` as `OVERALL`
	from 

	(
	select title, resource, JUL,
		  -- @rownum7 := @rownum7 + 1 as `JUL_RANK`
		  case when JUL = 0 then NULL else @rownum7 := @rownum7 + 1 end as `JUL_RANK`
	from rcbill_my.rep_vodpivot2019
    -- where title is null
	cross join (select @rownum7 := 0) r
	order by `JUL` desc
	) g
	-- on a.resource=g.resource


	inner join
	(
	select resource, AUG,
		  -- @rownum8 := @rownum8 + 1 as `AUG_RANK`
		  case when AUG = 0 then NULL else @rownum8 := @rownum8 + 1 end as `AUG_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum8 := 0) r
	order by `AUG` desc
	) h
	on g.resource=h.resource


	inner join
	(
	select resource, SEP,
			case when SEP = 0 then NULL else @rownum9 := @rownum9 + 1 end as `SEP_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum9 := 0) r
	-- where `SEP`<>0
	order by `SEP` desc
	) i
	on g.resource=i.resource


	inner join
	(
	select resource, OCT,
		  -- @rownum10 := @rownum10 + 1 as `OCT_RANK`
		  case when OCT = 0 then NULL else @rownum10 := @rownum10 + 1 end as `OCT_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum10 := 0) r
	order by `OCT` desc
	) j
	on g.resource=j.resource


	inner join
	(
	select resource, NOV,
		  -- @rownum11 := @rownum11 + 1 as `NOV_RANK`
		  case when NOV = 0 then NULL else @rownum11 := @rownum11 + 1 end as `NOV_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum11 := 0) r
	order by `NOV` desc
	) k
	on g.resource=k.resource


	inner join
	(
	select resource, `DEC`,
		  -- @rownum12 := @rownum12 + 1 as `DEC_RANK`
		  case when `DEC` = 0 then NULL else @rownum12 := @rownum12 + 1 end as `DEC_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum12 := 0) r
	order by `DEC` desc
	) l
	on g.resource=l.resource

/*
	inner join
	(
	select resource, TOTAL_DURATION,
		  -- @rownum13 := @rownum13 + 1 as `OVERALL_RANK`
		  case when `TOTAL_DURATION` = 0 then NULL else @rownum13 := @rownum13 + 1 end as `OVERALL_RANK`
	from rcbill_my.rep_vodpivot2019
	cross join (select @rownum13 := 0) r
	order by `TOTAL_DURATION` desc
	) m
	on g.resource=m.resource
*/
)
;

-- select * from rcbill_my.rep_vodranking2019_2 order by overall asc;
-- select * from rcbill_my.rep_vodranking2019_2 where resource like '2019%' order by overall asc;

