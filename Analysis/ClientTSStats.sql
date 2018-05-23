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
order by 2,1;

-- MOST TS LOYAL CUSTOMERS
select distinct clientcode, clientname, contractcode, sum(duration) as TimeSpent, count(*) as TimesWatched, count(distinct resource) as UniqueChannels, min(date(sessionstart)) as fromdate, max(date(sessionstart)) as todate

from rcbill.clienttsstats
group by clientcode, clientname, contractcode
order by 2, 4 desc;


-- MOST WATCHED TS CHANNELS PER DAY
select day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, resource, count(*)
from rcbill.clienttsstats
group by 1,2,3,4
order by 3,2,1,5 desc
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

/*
-- GET DISTINCT CLIENT CONTRACT DATE
select distinct clientcode, clientname, contractcode, date(sessionstart) as ts_date
from rcbill.clienttsstats
group by clientcode, clientname, contractcode, date(sessionstart)
order by clientcode
;

-- GET PACKAGE FOR THAT CONTRACT
-- SELECT * FROM rcbill_my.customercontractactivity WHERE clientcode ='I.000003211' AND contractcode='I.000185982' AND period='2016-06-10';
select a.*, b.package, b.region, b.servicesubcategory
from 
(
	select distinct clientcode, clientname, contractcode, date(sessionstart) as ts_date
	from rcbill.clienttsstats
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
a.ts_date=b.period
;
*/
