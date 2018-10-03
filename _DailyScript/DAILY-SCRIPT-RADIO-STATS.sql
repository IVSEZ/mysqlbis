-- mysqlcheck -o rcbill;
use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 

-- set @rundate = '2018-07-21';

-- select distinct date(sessionstart) from rcbill.rcb_livetvtelemetry;
-- select distinct date(sessionstart), count(*) from rcbill.templivetv group by 1 order by 1 desc;
-- select max(date(sessionstart)) from rcbill.rcb_livetvtelemetry;
-- select max(date(sessionstart)) from rcbill.clientlivetvstats;


-- FIRST TIME


drop table if exists rcbill.tempradio;
CREATE TABLE rcbill.tempradio
(INDEX idxtrad1 (device), index idxtrad2(sessionstart)) as 
(
select a.device,a.duration,trim(upper(a.resource)) as resource,a.sessionstart,a.subscriber
-- ,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_radiotelemetry a 
	-- where 
    -- date(a.SessionStart)> (select max(date(sessionstart)) from rcbill.clientradiostats)
	order by a.device
)
;


show index from rcbill.tempradio;

-- select * from rcbill.tempradio;



/*
insert into rcbill.templivetv
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber
-- ,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_livetvtelemetry a 
	-- inner join 
	-- rcbill.rcb_vodtitles b 
	-- on 
	-- a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>=@rundate
	order by a.device
)
;
*/


-- select * from templivetv limit 1000;
-- select * from templivetv where device='0c.56.5c.65.c6.c1';

-- FIRST TIME
/*
drop table if exists rcbill.clientradiostats;

create table rcbill.clientradiostats
(INDEX idxcrad1 (clientcode), INDEX idxcrad2(contractcode)) as
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempradio a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
)
;

-- show index from rcbill.clientradiostats;
*/

insert into rcbill.clientradiostats
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.tempradio a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
where 
date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clientradiostats)
);


-- select * from rcbill.clientlivetvstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientlivetvstats group by 1;

-- select * from rcbill.clientradiostats limit 1000;
-- select * from rcbill.clientlivetvstats where clientname like '%rahul%' and resource='IVSE01' order by sessionstart desc;
-- select * from rcbill.clientlivetvstats where clientname like '%rahul%' order by sessionstart desc;

/*
select month(sessionstart) as view_month, year(sessionstart) as view_year, clientcode, clientname, resource
, sum(duration) as duration_sec
-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
, TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
, count(*) as sessions from 
rcbill.clientlivetvstats
group by 1,2,3,4,5
order by 2 desc,1 desc;
*/

-- MOST TS LOYAL CUSTOMERS
/*
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientlivetvstats
group by clientcode, clientname, contractcode
order by 2, 4 desc;
*/

-- MOST LISTENED RADIO CHANNELS
drop table if exists rcbill_my.rep_radiostats;

create table rcbill_my.rep_radiostats as
(

	select date(sessionstart) as view_date, day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year
    , upper(trim(resource)) as resource, count(*) as sessions
	, sum(duration) as duration_sec
	-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
	-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
	from rcbill.clientradiostats
	group by 1,2,3,4,5
	-- order by 3 desc,2 desc,1 desc,5 desc
    order by 1 asc
)
;

select count(*) as rep_radiostats from rcbill_my.rep_radiostats;
-- select * from rcbill_my.rep_radiostats;

/*
select 
-- month(sessionstart) as view_month, year(sessionstart) as view_year, 
resource, count(*) as timeswatched, sum(duration) as duration
from rcbill.clientlivetvstats
group by 1
order by 2 desc,3 desc
;
*/

/*
select 
-- month(sessionstart) as view_month, year(sessionstart) as view_year, 
resource, count(*) as timeswatched, sum(duration) as duration
from rcbill.clientlivetvstats
group by 1
order by 3 desc
;
*/

-- GET ACTIVE CLIENTS FOR THE TS STATS
/*
select a.*, b.* 
from 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientlivetvstats
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
*/

-- GET DISTINCT ACTIVE CLIENTS WHO HAVE USED TS
/*
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientlivetvstats where 
clientcode in 
(select clientcode from rcbill_my.clientstats)
group by clientcode, clientname
order by 3 desc, 5 desc
;
*/

-- GET DISTINCT CLIENTS WHO HAVE USED TS
/*
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientlivetvstats 

group by clientcode, clientname
order by 3 desc, 5 desc
;
*/

-- select * from rcbill_my.clientstats where network='GPON' order by clientname;

-- GET CLIENTSTATS and JOIN THEM WITH TS
/*
select a.period,a.clientcode,a.clientname,a.region,a.network,a.clientclass,a.clienttype,a.services, b.*
from rcbill_my.clientstats a 
inner join 
(
select distinct clientcode, clientname, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate
from rcbill.clientlivetvstats 

group by clientcode, clientname
-- order by 7 desc, 5 desc
) b
on 
a.clientcode=b.clientcode
;
*/