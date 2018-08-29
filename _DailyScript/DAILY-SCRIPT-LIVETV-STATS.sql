-- mysqlcheck -o rcbill;
use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 

-- set @rundate = '2018-07-21';

-- select distinct date(sessionstart) from rcbill.rcb_livetvtelemetry;
-- select distinct date(sessionstart), count(*) from rcbill.templivetv group by 1 order by 1 desc;
-- select max(date(sessionstart)) from rcbill.rcb_livetvtelemetry;
-- select max(date(sessionstart)) from rcbill.clientlivetvstats;


-- FIRST TIME


drop table if exists rcbill.templivetv;
CREATE TABLE rcbill.templivetv 
(INDEX idxtv1 (device)) as 
(
	select a.device,a.duration,trim(upper(a.resource)) as resource,a.sessionstart,a.subscriber
	-- ,b.originaltitle,b.imdbtitleref
	from
	rcbill.rcb_livetvtelemetry a 
	-- inner join 
	-- rcbill.rcb_vodtitles b 
	-- on 
	-- a.resource=b.IMDBTITLEREF
	where 
 	-- date(a.SessionStart)='2018-08-28'
	-- date(a.SessionStart)>=@rundate
    date(a.SessionStart)> (select max(date(sessionstart)) from rcbill.clientlivetvstats)
	order by a.device
)
;

-- show index from rcbill.rcb_livetvtelemetry;
show index from rcbill.templivetv;

-- select * from rcbill.templivetv limit 100;



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
drop table if exists rcbill.clientlivetvstats;

create table rcbill.clientlivetvstats
(INDEX idxcvs1 (clientcode), INDEX idxcvs2(contractcode)) as
(
select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
from 
rcbill.templivetv a 
inner join 
rcbill.clientcontractdevices b 
on a.device=b.mac and a.device=b.phoneno
)
;

-- show index from rcbill.clientlivetvstats;
CREATE INDEX IDXclts1
ON rcbill.clientlivetvstats(clientcode);
CREATE INDEX IDXclts2
ON rcbill.clientlivetvstats (opendate);
CREATE INDEX IDXclts3
ON rcbill.clientlivetvstats (ticketid);

*/

insert into rcbill.clientlivetvstats
(
	select a.*, b.clientcode, b.clientname, b.contractcode, b.mac , b.phoneno
	from 
	rcbill.templivetv a 
	inner join 
	rcbill.clientcontractdevices b 
	on a.device=b.mac and a.device=b.phoneno
	where 
	-- date(a.SessionStart)='2018-08-28'
	date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clientlivetvstats)
);

-- select * from rcbill.clientlivetvstats where date(sessionstart)='2018-08-28'

## FIRST TIME
/*
drop table if exists rcbill_my.rep_livetvhourlystats;
create table rcbill_my.rep_livetvhourlystats
(INDEX idxlths1 (resource), INDEX idxlths2 (sessiondate)) as
(
	select upper(trim(RESOURCE)) as RESOURCE, date(SESSIONSTART) as SESSIONDATE
	, HOUR(SESSIONSTART) as SESSIONHOUR
	, count(DISTINCT DEVICE) as SUBSCRIBERS
	from rcbill.rcb_livetvtelemetry
	GROUP BY 1, 2, 3
	order by 1, 2
)
;

select * from rcbill_my.rep_livetvhourlystats where resource='SBC';

drop table if exists rcbill_my.rep_livetvhourlypivot;

create table rcbill_my.rep_livetvhourlypivot 
(INDEX idxlthp1 (resource), INDEX idxlthp2 (sessiondate)) as
(
		select RESOURCE, SESSIONDATE
		,ifnull(sum(`0`),0) as `0`
		,ifnull(sum(`1`),0) as `1`
		,ifnull(sum(`2`),0) as `2`
		,ifnull(sum(`3`),0) as `3`
		,ifnull(sum(`4`),0) as `4`
		,ifnull(sum(`5`),0) as `5`
		,ifnull(sum(`6`),0) as `6`
		,ifnull(sum(`7`),0) as `7`
		,ifnull(sum(`8`),0) as `8`
		,ifnull(sum(`9`),0) as `9`
		,ifnull(sum(`10`),0) as `10`
		,ifnull(sum(`11`),0) as `11`
		,ifnull(sum(`12`),0) as `12`
		,ifnull(sum(`13`),0) as `13`
		,ifnull(sum(`14`),0) as `14`
		,ifnull(sum(`15`),0) as `15`
		,ifnull(sum(`16`),0) as `16`
		,ifnull(sum(`17`),0) as `17`
		,ifnull(sum(`18`),0) as `18`
		,ifnull(sum(`19`),0) as `19`
		,ifnull(sum(`20`),0) as `20`
		,ifnull(sum(`21`),0) as `21`
		,ifnull(sum(`22`),0) as `22`
		,ifnull(sum(`23`),0) as `23`

		from
		(
			select resource, sessiondate 
			, case sessionhour when 0 then subscribers end as '0'
			, case sessionhour when 1 then subscribers end as '1'
			, case sessionhour when 2 then subscribers end as '2'
			, case sessionhour when 3 then subscribers end as '3'
			, case sessionhour when 4 then subscribers end as '4'
			, case sessionhour when 5 then subscribers end as '5'
			, case sessionhour when 6 then subscribers end as '6'
			, case sessionhour when 7 then subscribers end as '7'
			, case sessionhour when 8 then subscribers end as '8'
			, case sessionhour when 9 then subscribers end as '9'
			, case sessionhour when 10 then subscribers end as '10'
			, case sessionhour when 11 then subscribers end as '11'
			, case sessionhour when 12 then subscribers end as '12'
			, case sessionhour when 13 then subscribers end as '13'
			, case sessionhour when 14 then subscribers end as '14'
			, case sessionhour when 15 then subscribers end as '15'
			, case sessionhour when 16 then subscribers end as '16'
			, case sessionhour when 17 then subscribers end as '17'
			, case sessionhour when 18 then subscribers end as '18'
			, case sessionhour when 19 then subscribers end as '19'
			, case sessionhour when 20 then subscribers end as '20'
			, case sessionhour when 21 then subscribers end as '21'
			, case sessionhour when 22 then subscribers end as '22'
			, case sessionhour when 23 then subscribers end as '23'

			from rcbill_my.rep_livetvhourlystats

			group by resource, sessiondate,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
		) a
		group by resource, sessiondate
)
;


*/

insert into rcbill_my.rep_livetvhourlystats
(
   select  upper(trim(RESOURCE)) as RESOURCE, date(SESSIONSTART) as SESSIONDATE
	, HOUR(SESSIONSTART) as SESSIONHOUR
	-- , count(DEVICE) as SUBSCRIBERS
	, count(DISTINCT DEVICE) as SUBSCRIBERS
    from rcbill.templivetv
    where 
    (date(SESSIONSTART) > (select max(SESSIONDATE) from rcbill_my.rep_livetvhourlystats))
    and (date(SESSIONSTART) is not null)
    group by 1,2,3
);

set sql_safe_updates=0;
delete from rcbill_my.rep_livetvhourlystats where SESSIONDATE is null;
-- select * from rcbill_my.rep_livetvhourlystats where sessiondate='2018-08-28'
-- delete from rcbill_my.rep_livetvhourlystats where sessiondate='2018-08-28'


insert into rcbill_my.rep_livetvhourlypivot
(
		select RESOURCE, SESSIONDATE
		,ifnull(sum(`0`),0) as `0`
		,ifnull(sum(`1`),0) as `1`
		,ifnull(sum(`2`),0) as `2`
		,ifnull(sum(`3`),0) as `3`
		,ifnull(sum(`4`),0) as `4`
		,ifnull(sum(`5`),0) as `5`
		,ifnull(sum(`6`),0) as `6`
		,ifnull(sum(`7`),0) as `7`
		,ifnull(sum(`8`),0) as `8`
		,ifnull(sum(`9`),0) as `9`
		,ifnull(sum(`10`),0) as `10`
		,ifnull(sum(`11`),0) as `11`
		,ifnull(sum(`12`),0) as `12`
		,ifnull(sum(`13`),0) as `13`
		,ifnull(sum(`14`),0) as `14`
		,ifnull(sum(`15`),0) as `15`
		,ifnull(sum(`16`),0) as `16`
		,ifnull(sum(`17`),0) as `17`
		,ifnull(sum(`18`),0) as `18`
		,ifnull(sum(`19`),0) as `19`
		,ifnull(sum(`20`),0) as `20`
		,ifnull(sum(`21`),0) as `21`
		,ifnull(sum(`22`),0) as `22`
		,ifnull(sum(`23`),0) as `23`

		from
		(
			select resource, sessiondate 
			, case sessionhour when 0 then subscribers end as '0'
			, case sessionhour when 1 then subscribers end as '1'
			, case sessionhour when 2 then subscribers end as '2'
			, case sessionhour when 3 then subscribers end as '3'
			, case sessionhour when 4 then subscribers end as '4'
			, case sessionhour when 5 then subscribers end as '5'
			, case sessionhour when 6 then subscribers end as '6'
			, case sessionhour when 7 then subscribers end as '7'
			, case sessionhour when 8 then subscribers end as '8'
			, case sessionhour when 9 then subscribers end as '9'
			, case sessionhour when 10 then subscribers end as '10'
			, case sessionhour when 11 then subscribers end as '11'
			, case sessionhour when 12 then subscribers end as '12'
			, case sessionhour when 13 then subscribers end as '13'
			, case sessionhour when 14 then subscribers end as '14'
			, case sessionhour when 15 then subscribers end as '15'
			, case sessionhour when 16 then subscribers end as '16'
			, case sessionhour when 17 then subscribers end as '17'
			, case sessionhour when 18 then subscribers end as '18'
			, case sessionhour when 19 then subscribers end as '19'
			, case sessionhour when 20 then subscribers end as '20'
			, case sessionhour when 21 then subscribers end as '21'
			, case sessionhour when 22 then subscribers end as '22'
			, case sessionhour when 23 then subscribers end as '23'

			from rcbill_my.rep_livetvhourlystats
			where sessiondate > (select max(SESSIONDATE) as MAXSESSIONDATE from rcbill_my.rep_livetvhourlypivot)
			group by resource, sessiondate,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25
		) a
		group by resource, sessiondate
)
;

-- select *, DAYNAME(SESSIONDATE) as SESSIONDAY from rcbill_my.rep_livetvhourlypivot where DAYNAME(sessiondate)='SUNDAY'
-- select * from rcbill_my.rep_livetvhourlypivot where sessiondate='2018-08-28';
-- select * from rcbill_my.rep_livetvhourlystats where resource='SBC';
/*
 select * from rcbill_my.rep_livetvhourlypivot;
 select * from rcbill_my.rep_livetvhourlystats where resource='SBC';
*/

-- show index from rcbill.clientlivetvstats;
-- select * from rcbill.clientlivetvstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientlivetvstats group by 1;

-- select * from rcbill.clientlivetvstats limit 1000;
-- select * from rcbill.clientlivetvstats where clientcode in ('I.000011750') order by sessionstart desc;
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

-- MOST WATCHED TS CHANNELS PER DAY
drop table if exists rcbill_my.rep_livetvstats;

create table rcbill_my.rep_livetvstats as
(
	select date(sessionstart) as view_date, day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year
    , upper(trim(resource)) as resource, count(*) as sessions
	, sum(duration) as duration_sec
	-- , (sum(duration))/60 as duration_min, (sum(duration))/120 as duration_hour  
	-- , TIME_FORMAT(SEC_TO_TIME(sum(duration)),'%Hh %im') as timespent
	from rcbill.clientlivetvstats
	group by 1,2,3,4,5
	-- order by 3 desc,2 desc,1 desc,5 desc
    order by 1 asc
)
;

select count(*) as rep_livetvstats from rcbill_my.rep_livetvstats;
-- select * from rcbill_my.rep_livetvstats where view_month=7 and view_year=2018;
-- select * from rcbill_my.rep_livetvstats;

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