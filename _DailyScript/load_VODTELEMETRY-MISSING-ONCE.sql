
#################################################################

# VOD TELEMETRY MISSING DAILY


use rcbill;

LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\rcbill\\AllVODTelemetry-Missing-26082018.csv' 
REPLACE INTO TABLE `rcbill`.`rcb_vodtelemetry` CHARACTER SET latin1 FIELDS TERMINATED BY '|' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\r\n' 
IGNORE 2 LINES 
( 
@﻿ID ,
@Device ,
@Type ,
@Resource ,
@StartPosition ,
@EndTime ,
@Duration ,
@Subscriber ,
@SessionStart ,
@SessionEnd ,
@SessionStart2 ,
@SessionEnd2 
)
set 
﻿ID=@﻿ID ,
DEVICE=@Device ,
TYPE=@Type ,
RESOURCE=@Resource ,
STARTPOSITION=@StartPosition ,
ENDTIME=@EndTime ,
DURATION=@Duration ,
SUBSCRIBER=@Subscriber ,
SESSIONSTART=@SessionStart2 ,
SESSIONEND=@SessionEnd2 ,

INSERTEDON=now()
;

explain select count(1) as vodtelemetry from rcb_vodtelemetry;


########################################################



drop table if exists rcbill.tempvod;
CREATE TEMPORARY TABLE rcbill.tempvod 
(INDEX idxtv1 (device)) as 
(
	select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.TITLE,b.imdbtitleref
    -- , a.insertedon
	from
	rcbill.rcb_vodtelemetry a 
	-- inner join 
	left join
    rcbill.rcb_vodtitles b 
	on 
	a.resource=b.IMDBTITLEREF
    -- or a.resource=b.IMDBTITLEREF
	where 
	-- date(a.SessionStart)>=@rundate
    -- date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clientvodstats)
	a.insertedon='2018-08-27 21:46:29'
    order by a.sessionstart desc, a.device
)
;

show index from rcbill.tempvod;

-- select * from rcbill.tempvod;



insert into rcbill.clientvodstats
(
	select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
	from 
	rcbill.tempvod a 
	inner join 
	rcbill.clientcontractdevices b 
	on a.device=b.mac and a.device=b.phoneno
	-- where 
	-- date(a.SessionStart)>=@rundate
	-- date(a.SessionStart)> (select max(date(sessionstart)) from rcbill.clientvodstats)
)
;

-- SET SQL_SAFE_UPDATES=0;
-- delete from rcbill.clientvodstats where date(sessionstart)>='2018-07-24';
-- select * from rcbill.clientvodstats order by sessionstart desc;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientvodstats group by 1;


-- select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart desc;
-- select * from rcbill.clientvodstats where clientname like '%cindy%' order by sessionstart desc;

/*
select month(sessionstart) as view_month, year(sessionstart) as view_year, clientcode, clientname, originaltitle
, sum(duration) as duration
, count(*) from 
rcbill.clientvodstats
group by 1,2,3,4,5
order by 2 desc,1 desc;
*/

drop table if exists rcbill_my.rep_vodstats;

create table rcbill_my.rep_vodstats as
(

	select date(sessionstart) as view_date, day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year
    -- , clientcode, clientname
    , upper(trim(originaltitle)) as originaltitle, upper(trim(resource)) as resource
	, sum(duration) as duration_sec
	-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
	-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
	, count(*) as sessions from 
	rcbill.clientvodstats
	group by 1,2,3,4,5, 6
    -- ,6,7
	-- order by 3 desc, 2 desc,1 desc
    order by 1 asc
)
;

select count(*) as rep_vodstats from rcbill_my.rep_vodstats;

