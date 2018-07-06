-- mysqlcheck -o rcbill;
use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 


-- select * from rcbill.clientcontractdevices;
-- select * from rcbill.rcb_vodtelemetry;

-- create temporary table vodstats as 
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

-- select * from rcbill.clientvodstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientvodstats group by 1;


-- select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart;


select month(sessionstart) as view_month, year(sessionstart) as view_year, clientcode, clientname, originaltitle, sum(duration) as duration, count(*) from 
rcbill.clientvodstats
group by 1,2,3,4,5
order by 2 desc,1 desc;

-- MOST VOD LOYAL CUSTOMERS
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientvodstats
group by clientcode, clientname, contractcode
order by 5 desc;

-- MOST WATCHED VOD TITLES PER DAY
select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, originaltitle, resource, count(*)
from rcbill.clientvodstats
group by 1,2,3,4,5
order by 3,2,1,6 desc
;

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
