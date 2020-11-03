select count(*) as callstats from rcbill_my.callstats;

select * from rcbill_my.callstats; 

select max(CALLDATE) as LASTCALLDATE from rcbill_my.callstats;

select CALLDATE, SHIFT, CALLEVENTNAME , sum(CALLCOUNT) as CALLCOUNT from rcbill_my.callstats
group by 
CALLDATE, SHIFT, CALLEVENTNAME
order by CALLDATE desc
;

select SHIFT, sum(CALLCOUNT)

from rcbill_my.callstats
group by SHIFT
;


select CALLDATE, sum(CALLCOUNT) as `TOTAL CALLS` from rcbill_my.callstats
group by 
CALLDATE

order by CALLDATE desc
;

select year(CALLDATE) as CALLYEAR, month(CALLDATE) as CALLMONTH, day(CALLDATE) as CALLDAY, monthname(CALLDATE) as monthname, CALLDATE, sum(CALLCOUNT) as `TOTALCALLS` from rcbill_my.callstats group by CALLDATE order by CALLDATE desc
;

select year(CALLDATE) as CALLYEAR, month(CALLDATE) as CALLMONTH, day(CALLDATE) as CALLDAY, monthname(CALLDATE) as monthname, CALLDATE
, ifnull(sum(CALLCOUNT),0) as `TOTAL CALLS`
, ifnull(sum(ANSWERED),0) as `ANSWERED`, ifnull(sum(`NOT ANSWERED`),0) as `NOT ANSWERED`
from 
(

select CALLDATE, CALLEVENTNAME
, case when CALLEVENTNAME='ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `ANSWERED`
, case when CALLEVENTNAME='NOT ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `NOT ANSWERED`


, sum(CALLCOUNT) as CALLCOUNT 

from rcbill_my.callstats
group by 
CALLDATE, CALLEVENTNAME

order by CALLDATE desc
) a 
group by CALLDATE
order by CALLDATE desc
;



select year(CALLDATE) as CALLYEAR, month(CALLDATE) as CALLMONTH, day(CALLDATE) as CALLDAY, monthname(CALLDATE) as monthname, CALLDATE
, ifnull(sum(CALLCOUNT),0) as `TOTAL CALLS`
, ifnull(sum(`DAY - ANSWERED`),0) as `DAY - ANSWERED`
, ifnull(sum(`DAY - NOT ANSWERED`),0) as `DAY - NOT ANSWERED`
, ifnull(sum(`EVE - ANSWERED`),0) as `EVE - ANSWERED`
, ifnull(sum(`EVE - NOT ANSWERED`),0) as `EVE - NOT ANSWERED`
, ifnull(sum(`NOC - ANSWERED`),0) as `NOC - ANSWERED`
, ifnull(sum(`NOC - NOT ANSWERED`),0) as `NOC - NOT ANSWERED`
, ifnull(sum(`REMOTE - ANSWERED`),0) as `REMOTE - ANSWERED`
, ifnull(sum(`REMOTE - NOT ANSWERED`),0) as `REMOTE - NOT ANSWERED`
from 
(

select CALLDATE, SHIFT, CALLEVENTNAME
, case when SHIFT='DAY' and CALLEVENTNAME='ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `DAY - ANSWERED`
, case when SHIFT='DAY' and CALLEVENTNAME='NOT ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `DAY - NOT ANSWERED`
, case when SHIFT='EVENING' and CALLEVENTNAME='ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `EVE - ANSWERED`
, case when SHIFT='EVENING' and CALLEVENTNAME='NOT ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `EVE - NOT ANSWERED`
, case when SHIFT='NOC' and CALLEVENTNAME='ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `NOC - ANSWERED`
, case when SHIFT='NOC' and CALLEVENTNAME='NOT ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `NOC - NOT ANSWERED`
, case when SHIFT='REMOTE' and CALLEVENTNAME='ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `REMOTE - ANSWERED`
, case when SHIFT='REMOTE' and CALLEVENTNAME='NOT ANSWERED' then ifnull(sum(CALLCOUNT),0) end as `REMOTE - NOT ANSWERED`


, sum(CALLCOUNT) as CALLCOUNT 

from rcbill_my.callstats
group by 
CALLDATE, SHIFT, CALLEVENTNAME

order by CALLDATE desc
) a 
group by CALLDATE
order by CALLDATE desc
;


