-- mysqlcheck -o rcbill;
use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 

set @rundate = '2018-07-09';


-- select * from rcbill.clientcontractdevices;
-- select * from rcbill.rcb_vodtelemetry;

-- create temporary table vodstats as 

/*
drop table if exists rcbill.tempvod;
CREATE TEMPORARY TABLE rcbill.tempvod 
(INDEX idxtv1 (device)) as 
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_vodtelemetry a 
	inner join 
	rcbill.rcb_vodtitles b 
	on 
	a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>'2016-01-01'
	order by a.device
)
;

show index from rcbill.tempvod;

select * from tempvod;
*/

insert into rcbill.tempvod
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_vodtelemetry a 
	inner join 
	rcbill.rcb_vodtitles b 
	on 
	a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>=@rundate
	order by a.device
)
;


-- delete from rcbill.tempvod where date(SessionStart)>=@rundate
-- FIRST TIME
/*
drop table if exists rcbill.clientvodstats;

create table rcbill.clientvodstats
(INDEX idxcvs1 (clientcode), INDEX idxcvs2(contractcode)) as
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempvod a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
)
;
*/

insert into rcbill.clientvodstats
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempvod a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
where 
date(a.SessionStart)>=@rundate
)
;


-- select * from rcbill.clientvodstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientvodstats group by 1;


-- select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart;

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

select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, clientcode, clientname, originaltitle, resource
, sum(duration) as duration_sec
-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
, TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
, count(*) as sessions from 
rcbill.clientvodstats
group by 1,2,3,4,5,6,7
order by 3 desc, 2 desc,1 desc
)
;

select * from rcbill_my.rep_vodstats;

select view_day, view_month, view_year, originaltitle
, count(*) as sessions
, sum(duration_sec) as duration_sec
-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
from rcbill_my.rep_vodstats
group by 1,2,3,4
order by 3 desc,2 desc,1 desc,5 desc
;

-- MOST WATCHED VOD TITLES PER DAY
/*
select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, originaltitle, resource, count(*)
from rcbill.clientvodstats
group by 1,2,3,4,5
order by 3,2,1,6 desc
;
*/

select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, originaltitle, resource, count(*) as sessions
, sum(duration) as duration_sec
-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
from rcbill.clientvodstats
group by 1,2,3,4,5
order by 3 desc,2 desc,1 desc,5 desc
;


-- MOST VOD LOYAL CUSTOMERS
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientvodstats
group by clientcode, clientname, contractcode
order by 5 desc;



##TOP VOD TITLES
select 
-- month(sessionstart) as view_month, year(sessionstart) as view_year, 
originaltitle, resource, count(*) as timeswatched, sum(duration) as duration
from rcbill.clientvodstats
group by 1,2
order by 3 desc,4 desc
;


-- GET ACTIVE CLIENTS FOR THE VOD STATS
select a.*, b.* 
from 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientvodstats
group by clientcode, clientname
order by 2, 3 desc
) a 
left join
(
select * from rcbill_my.clientstats
) b
on
a.clientcode=b.clientcode
order by 2
;


-- GET DISTINCT ACTIVE CLIENTS WHO HAVE USED VOD
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched
, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientvodstats where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
group by clientcode, clientname
order by 7 desc, 5 desc
;

-- GET DISTINCT CLIENTS WHO HAVE USED VOD
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched
, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientvodstats 
/*
where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
*/
group by clientcode, clientname
order by 7 desc, 5 desc
;

-- select * from rcbill_my.clientstats where network='GPON' order by clientname;

-- GET CLIENTSTATS and JOIN THEM WITH VOD
select a.period,a.clientcode,a.clientname,a.region,a.network,a.clientclass,a.clienttype,a.services, b.*
from rcbill_my.clientstats a 
inner join 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientvodstats 
/*
where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
*/
group by clientcode, clientname
-- order by 7 desc, 5 desc
) b
on 
a.clientcode=b.clientcode
;

-- GET DISTINCT CLIENT CONTRACT DATE
select distinct clientcode, clientname, contractcode, date(sessionstart) as vod_date
from rcbill.clientvodstats
group by clientcode, clientname, contractcode, date(sessionstart)
order by clientcode
;


#####################################################################################################



use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 

-- first time
/*
drop table if exists rcbill.tempts;
CREATE TEMPORARY TABLE rcbill.tempts 
(INDEX idxtv1 (device)) as 
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber
-- ,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_tstelemetry a 
	-- inner join 
	-- rcbill.rcb_vodtitles b 
	-- on 
	-- a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>'2017-05-31'
	order by a.device
)
;

show index from rcbill.tempts;

select * from tempts;
*/

insert into rcbill.tempts
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber
-- ,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_tstelemetry a 
	-- inner join 
	-- rcbill.rcb_vodtitles b 
	-- on 
	-- a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>=@rundate
	order by a.device
)
;

-- select * from rcbill.tempts where date(SessionStart)>=@rundate
-- delete from rcbill.tempts where date(SessionStart)>=@rundate
-- delete from rcbill.tempts where date(SessionStart)>=@rundate

-- first time
/*
drop table if exists rcbill.clienttsstats;

create table rcbill.clienttsstats
(INDEX idxcvs1 (clientcode), INDEX idxcvs2(contractcode)) as
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempts a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
)
;
*/

insert into rcbill.clienttsstats
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempts a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
where 
date(a.SessionStart)>=@rundate
)
;


-- select * from rcbill.clienttsstats where date(SessionStart)>=@rundate
-- delete from rcbill.clienttsstats where date(SessionStart)>=@rundate

-- select * from rcbill.clientvodstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientvodstats group by 1;


-- select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart;

select month(sessionstart) as view_month, year(sessionstart) as view_year, clientcode, clientname, resource, sum(duration) as duration, count(*) from 
rcbill.clienttsstats
group by 1,2,3,4,5
order by 2 desc,1 desc;






-- MOST TS LOYAL CUSTOMERS
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clienttsstats
group by clientcode, clientname, contractcode
order by 2, 4 desc;


-- MOST WATCHED TS CHANNELS PER DAY
select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, resource, count(*)
from rcbill.clienttsstats
group by 1,2,3,4
order by 3 desc,2 desc,1 desc,5 desc
;

select 
-- month(sessionstart) as view_month, year(sessionstart) as view_year, 
resource, count(*) as timeswatched, sum(duration) as duration
from rcbill.clienttsstats
group by 1
order by 2 desc,3 desc
;

select 
-- month(sessionstart) as view_month, year(sessionstart) as view_year, 
resource, count(*) as timeswatched, sum(duration) as duration
from rcbill.clienttsstats
group by 1
order by 3 desc
;

-- GET ACTIVE CLIENTS FOR THE TS STATS
select a.*, b.* 
from 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clienttsstats
group by clientcode, clientname
order by 2, 3 desc
) a 
left join
(
select * from rcbill_my.clientstats
) b
on
a.clientcode=b.clientcode
order by 2
;


-- GET DISTINCT ACTIVE CLIENTS WHO HAVE USED TS
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clienttsstats where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
group by clientcode, clientname
order by 3 desc, 5 desc
;

-- GET DISTINCT CLIENTS WHO HAVE USED TS
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clienttsstats 
/*
where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
*/
group by clientcode, clientname
order by 3 desc, 5 desc
;

-- select * from rcbill_my.clientstats where network='GPON' order by clientname;

-- GET CLIENTSTATS and JOIN THEM WITH TS
select a.period,a.clientcode,a.clientname,a.region,a.network,a.clientclass,a.clienttype,a.services, b.*
from rcbill_my.clientstats a 
inner join 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clienttsstats 
/*
where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
*/
group by clientcode, clientname
-- order by 7 desc, 5 desc
) b
on 
a.clientcode=b.clientcode
;
