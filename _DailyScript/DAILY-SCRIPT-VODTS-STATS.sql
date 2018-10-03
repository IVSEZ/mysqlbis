-- mysqlcheck -o rcbill;
use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 

set @rundate = '2018-07-21';

-- select max(date(sessionstart)) from rcbill.clientvodstats;

-- select * from rcbill.clientcontractdevices;
-- select * from rcbill.rcb_vodtelemetry where type='vod';

-- create temporary table vodstats as 


drop table if exists rcbill.tempvod;
CREATE TABLE rcbill.tempvod 
(INDEX idxtvod1 (device), index idxtvod2(sessionstart)) as 
(
	select a.device,a.duration,a.resource,a.sessionstart,a.subscriber,b.TITLE,b.imdbtitleref
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
    date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clientvodstats)
	order by a.sessionstart desc, a.device
)
;

show index from rcbill.tempvod;

-- select * from tempvod;

/*
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
*/


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

-- show index from rcbill.clientvodstats;
CREATE INDEX IDXclts1
ON rcbill.clientvodstats(clientcode);
CREATE INDEX IDXclts2
ON rcbill.clientvodstats (opendate);
CREATE INDEX IDXclts3
ON rcbill.clientvodstats (ticketid);


create index IDXclts4 on rcbill.clientvodstats(sessionstart);

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
	-- date(a.SessionStart)>=@rundate
	date(a.SessionStart)> (select max(date(sessionstart)) from rcbill.clientvodstats)
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
-- select * from rcbill_my.rep_vodstats;

#####################################################################################################



use rcbill;

-- ENSURE THAT CLIENTSTATS TABLE IS READY 
-- (select max(date(sessionstart)) from rcbill.clienttsstats);
-- first time

drop table if exists rcbill.tempts;
CREATE TABLE rcbill.tempts 
(INDEX idxtts1 (device), index idxtts2(sessionstart)) as 
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
	-- date(a.SessionStart)>=@rundate
    date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clienttsstats)
	order by a.device
)
;

show index from rcbill.tempts;

-- select * from rcbill.tempts;

/*
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
*/

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


create index IDXcts4 on rcbill.clienttsstats(sessionstart);
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
-- date(a.SessionStart)>=@rundate
date(a.SessionStart)>(select max(date(sessionstart)) from rcbill.clienttsstats)
)
;


-- MOST WATCHED TS CHANNELS PER DAY

drop table if exists rcbill_my.rep_tsstats;

create table rcbill_my.rep_tsstats as
(
	select date(sessionstart) as view_date, day(sessionstart) as view_day, month(sessionstart) as view_month, year(sessionstart) as view_year, upper(trim(resource)) as resource, count(*) as sessions
	from rcbill.clienttsstats
	group by 1,2,3,4,5
	order by 1 asc
)
;

select count(*) as rep_tsstats from rcbill_my.rep_tsstats;
-- select * from rcbill_my.rep_tsstats;


-- select * from rcbill.clienttsstats where date(SessionStart)>=@rundate
-- delete from rcbill.clienttsstats where date(SessionStart)>=@rundate

-- select * from rcbill.clientvodstats ;
-- select distinct date(sessionstart), count(distinct clientcode) from rcbill.clientvodstats group by 1;


-- select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart;

