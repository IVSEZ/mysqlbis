
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


-- select * from rcbill_my.rep_livetvpivot2018 order by total_duration desc ;
/*

select * FROM rcbill_my.rep_livetvstats;
select * FROM rcbill_my.rep_vodstats;
select * FROM rcbill_my.rep_radiostats;
select * FROM rcbill_my.rep_tsstats;

select * from rcbill_my.rep_livetvpivot2018;
select * from rcbill_my.rep_vodpivot2018;
select * from rcbill_my.rep_radiopivot2018;
select * from rcbill_my.rep_tspivot2018;
*/