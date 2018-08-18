
drop table if exists rcbill_my.rep_livetvpivot2018;

create table rcbill_my.rep_livetvpivot2018 as 
(
	SELECT  upper(trim(resource)) as RESOURCE,
		SUM( IF( MONTH(view_date) = 1, duration_sec, 0) ) AS `JAN`,
		SUM( IF( MONTH(view_date) = 2, duration_sec, 0) ) AS `FEB`,
		SUM( IF( MONTH(view_date) = 3, duration_sec, 0) ) AS `MAR`,
		SUM( IF( MONTH(view_date) = 4, duration_sec, 0) ) AS `APR`,
		SUM( IF( MONTH(view_date) = 5, duration_sec, 0) ) AS `MAY`,
		SUM( IF( MONTH(view_date) = 6, duration_sec, 0) ) AS `JUN`,
		SUM( IF( MONTH(view_date) = 7, duration_sec, 0) ) AS `JUL`,
		SUM( IF( MONTH(view_date) = 8, duration_sec, 0) ) AS `AUG`,
		SUM( IF( MONTH(view_date) = 9, duration_sec, 0) ) AS `SEP`,
		SUM( IF( MONTH(view_date) = 10, duration_sec, 0) ) AS `OCT`,
		SUM( IF( MONTH(view_date) = 11, duration_sec, 0) ) AS `NOV`,
		SUM( IF( MONTH(view_date) = 12, duration_sec, 0) ) AS `DEC`,


		SUM( duration_sec ) AS TOTAL_DURATION
	FROM rcbill_my.rep_livetvstats
	where view_date>='2018-01-01' and view_date<='2018-12-31'
	GROUP BY 1
	order by 1
)
;

drop table if exists rcbill_my.rep_vodpivot2018;

create table rcbill_my.rep_vodpivot2018 as 
(
	SELECT upper(trim(originaltitle)) as TITLE,  upper(trim(resource)) as RESOURCE,
		SUM( IF( MONTH(view_date) = 1, duration_sec, 0) ) AS `JAN`,
		SUM( IF( MONTH(view_date) = 2, duration_sec, 0) ) AS `FEB`,
		SUM( IF( MONTH(view_date) = 3, duration_sec, 0) ) AS `MAR`,
		SUM( IF( MONTH(view_date) = 4, duration_sec, 0) ) AS `APR`,
		SUM( IF( MONTH(view_date) = 5, duration_sec, 0) ) AS `MAY`,
		SUM( IF( MONTH(view_date) = 6, duration_sec, 0) ) AS `JUN`,
		SUM( IF( MONTH(view_date) = 7, duration_sec, 0) ) AS `JUL`,
		SUM( IF( MONTH(view_date) = 8, duration_sec, 0) ) AS `AUG`,
		SUM( IF( MONTH(view_date) = 9, duration_sec, 0) ) AS `SEP`,
		SUM( IF( MONTH(view_date) = 10, duration_sec, 0) ) AS `OCT`,
		SUM( IF( MONTH(view_date) = 11, duration_sec, 0) ) AS `NOV`,
		SUM( IF( MONTH(view_date) = 12, duration_sec, 0) ) AS `DEC`,


		SUM( duration_sec ) AS TOTAL_DURATION
	FROM rcbill_my.rep_vodstats
	where view_date>='2018-01-01' and view_date<='2018-12-31'
	GROUP BY 1,2
	order by 1,2
)
;

drop table if exists rcbill_my.rep_radiopivot2018;

create table rcbill_my.rep_radiopivot2018 as 
(
	SELECT  upper(trim(resource)) as RESOURCE,
		SUM( IF( MONTH(view_date) = 1, duration_sec, 0) ) AS `JAN`,
		SUM( IF( MONTH(view_date) = 2, duration_sec, 0) ) AS `FEB`,
		SUM( IF( MONTH(view_date) = 3, duration_sec, 0) ) AS `MAR`,
		SUM( IF( MONTH(view_date) = 4, duration_sec, 0) ) AS `APR`,
		SUM( IF( MONTH(view_date) = 5, duration_sec, 0) ) AS `MAY`,
		SUM( IF( MONTH(view_date) = 6, duration_sec, 0) ) AS `JUN`,
		SUM( IF( MONTH(view_date) = 7, duration_sec, 0) ) AS `JUL`,
		SUM( IF( MONTH(view_date) = 8, duration_sec, 0) ) AS `AUG`,
		SUM( IF( MONTH(view_date) = 9, duration_sec, 0) ) AS `SEP`,
		SUM( IF( MONTH(view_date) = 10, duration_sec, 0) ) AS `OCT`,
		SUM( IF( MONTH(view_date) = 11, duration_sec, 0) ) AS `NOV`,
		SUM( IF( MONTH(view_date) = 12, duration_sec, 0) ) AS `DEC`,


		SUM( duration_sec ) AS TOTAL_DURATION
	FROM rcbill_my.rep_radiostats
	where view_date>='2018-01-01' and view_date<='2018-12-31'
	GROUP BY 1
	order by 1
)
;


drop table if exists rcbill_my.rep_tspivot2018;

create table rcbill_my.rep_tspivot2018 as 
(
	SELECT  upper(trim(resource)) as RESOURCE,
		SUM( IF( MONTH(view_date) = 1, sessions, 0) ) AS `JAN`,
		SUM( IF( MONTH(view_date) = 2, sessions, 0) ) AS `FEB`,
		SUM( IF( MONTH(view_date) = 3, sessions, 0) ) AS `MAR`,
		SUM( IF( MONTH(view_date) = 4, sessions, 0) ) AS `APR`,
		SUM( IF( MONTH(view_date) = 5, sessions, 0) ) AS `MAY`,
		SUM( IF( MONTH(view_date) = 6, sessions, 0) ) AS `JUN`,
		SUM( IF( MONTH(view_date) = 7, sessions, 0) ) AS `JUL`,
		SUM( IF( MONTH(view_date) = 8, sessions, 0) ) AS `AUG`,
		SUM( IF( MONTH(view_date) = 9, sessions, 0) ) AS `SEP`,
		SUM( IF( MONTH(view_date) = 10, sessions, 0) ) AS `OCT`,
		SUM( IF( MONTH(view_date) = 11, sessions, 0) ) AS `NOV`,
		SUM( IF( MONTH(view_date) = 12, sessions, 0) ) AS `DEC`,


		SUM( sessions ) AS TOTAL_SESSIONS
	FROM rcbill_my.rep_tsstats
	where view_date>='2018-01-01' and view_date<='2018-12-31'
	GROUP BY 1
	order by 1
)
;


select * from rcbill_my.rep_livetvpivot2018 order by total_duration desc ;
select * from rcbill_my.rep_vodpivot2018;
select * from rcbill_my.rep_radiopivot2018;
select * from rcbill_my.rep_tspivot2018;

select resource, jan from rcbill_my.rep_livetvpivot2018 order by jan desc;

select * from rcbill_my.rep_livetvpivot2018 order by total_duration desc ;
select a.resource, a.`JAN_RANK` as `JAN`, b.`FEB_RANK` as `FEB`
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
      @rownum1 := @rownum1 + 1 as `JAN_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum1 := 0) r
order by `JAN` desc
) a 
inner join
(
select resource, FEB,
      @rownum2 := @rownum2 + 1 as `FEB_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum2 := 0) r
order by `FEB` desc
) b 
on a.resource=b.resource

inner join
(
select resource, MAR,
      @rownum3 := @rownum3 + 1 as `MAR_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum3 := 0) r
order by `MAR` desc
) c
on a.resource=c.resource

inner join
(
select resource, APR,
      @rownum4 := @rownum4 + 1 as `APR_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum4 := 0) r
order by `APR` desc
) d
on a.resource=d.resource


inner join
(
select resource, MAY,
      @rownum5 := @rownum5 + 1 as `MAY_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum5 := 0) r
order by `MAY` desc
) e
on a.resource=e.resource


inner join
(
select resource, JUN,
      @rownum6 := @rownum6 + 1 as `JUN_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum6 := 0) r
order by `JUN` desc
) f
on a.resource=f.resource


inner join
(
select resource, JUL,
      @rownum7 := @rownum7 + 1 as `JUL_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum7 := 0) r
order by `JUL` desc
) g
on a.resource=g.resource


inner join
(
select resource, AUG,
      @rownum8 := @rownum8 + 1 as `AUg_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum8 := 0) r
order by `AUG` desc
) h
on a.resource=h.resource


inner join
(
select resource, SEP,
      @rownum9 := @rownum9 + 1 as `SEP_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum9 := 0) r
order by `SEP` desc
) i
on a.resource=i.resource


inner join
(
select resource, OCT,
      @rownum10 := @rownum10 + 1 as `OCT_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum10 := 0) r
order by `OCT` desc
) j
on a.resource=j.resource


inner join
(
select resource, NOV,
      @rownum11 := @rownum11 + 1 as `NOV_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum11 := 0) r
order by `NOV` desc
) k
on a.resource=k.resource


inner join
(
select resource, `DEC`,
      @rownum12 := @rownum12 + 1 as `DEc_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum12 := 0) r
order by `DEC` desc
) l
on a.resource=l.resource


inner join
(
select resource, TOTAL_DURATION,
      @rownum13 := @rownum13 + 1 as `OVERALL_RANK`
from rcbill_my.rep_livetvpivot2018
cross join (select @rownum13 := 0) r
order by `TOTAL_DURATION` desc
) m
on a.resource=m.resource


;