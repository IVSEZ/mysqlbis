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
order by 2,1;

-- MOST VOD LOYAL CUSTOMERS
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct originaltitle) as UniqueMovies, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clientvodstats
group by clientcode, clientname, contractcode
order by 2, 4 desc;


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

-- GET PACKAGE FOR THAT CONTRACT
-- SELECT * FROM rcbill_my.customercontractactivity WHERE clientcode ='I.000003211' AND contractcode='I.000185982' AND period='2016-06-10';
/*

select a.*, b.package, b.region, b.servicesubcategory
from 
(
	select distinct clientcode, clientname, contractcode, date(sessionstart) as vod_date
	from rcbill.clientvodstats
	group by clientcode, clientname, contractcode, date(sessionstart)
	order by clientcode
) a 
inner join
rcbill_my.customercontractactivity b 
on 
a.clientcode=b.clientcode
and
a.contractcode=b.contractcode
and
a.vod_date=b.period
;
*/

/*
select c.clientcode, c.clientname, c.contractcode,c.mac, d.*
from 
rcbill.clientcontractdevices c 
left join
(
	select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_vodtelemetry a 
	inner join 
	rcbill.rcb_vodtitles b 
	on 
	a.resource=b.IMDBTITLEREF
	where 
	a.SessionStart>'2017-01-01'
	order by a.device
) d
on c.mac=d.device
;


select distinct d.device, d.originaltitle, date(d.SessionStart) as s_date, count(*) from 
(
select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_vodtelemetry a 
	inner join 
	rcbill.rcb_vodtitles b 
	on 
	a.resource=b.IMDBTITLEREF
	where 
	date(a.SessionStart)>'2017-01-01'
	order by a.device
) d
-- left join 
-- rcbill.clientcontractdevices u
-- on d.device=u.mac
-- order by 1
group by device, originaltitle
order by device, s_date
;


*/
/*
select c.clientcode, c.clientname, c.contractcode,c.mac,a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.originaltitle,b.imdbtitleref
from 
rcbill.rcb_vodtelemetry a 
inner join 
rcbill.rcb_vodtitles b 
on 
a.resource=b.IMDBTITLEREF

inner join
rcbill.clientcontractdevices c 
on 
a.device=c.mac

where a.SessionStart>'2017-09-05'
;
*/