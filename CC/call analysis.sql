select a.*, upper(b.CCAGENT) as CCAGENT from rcbill_my.callstats a left join rcbill_my.ccrota b on a.calldate=b.ccdate and a.shift=b.ccshift and upper(a.callagent)=upper(b.ccnumber) order by a.calldate desc;

show index from rcbill_my.callstats;
show index from rcbill_my.ccrota;




select a.*, b.mphone, b.firm as ClientName,  b.kod as ClientCode 
from rcbill_my.dailycalls a left join 
rcbill.rcb_tclients b 
ON b.mphone like CONCAT('%', a.callnumber, '%')
order by a.calldate;

select distinct callevent, count(*) from dailycalls
group by callevent;


select distinct a.callnumber, a.callevent, count(*),  
SEC_TO_TIME( SUM( TIME_TO_SEC( `waittime` ) ) ) AS sumwaittime,
SEC_TO_TIME( SUM( TIME_TO_SEC( `talktime` ) ) ) AS sumtalktime
-- sum(waittime), 
-- sum(talktime) 
,
b.firm
from rcbill_my.dailycalls a
inner join 
rcbill.rcb_tclients b
on
b.mphone like concat('%', a.callnumber , '%')
-- a.callnumber=b.mphone
group by a.callnumber,  a.callevent, b.firm
order by 3 desc, a.callnumber
;

select * from rcbill_my.dailycalls;
select * from rcbill.rcb_tclients;

select * from rcbill_my.dailycalls where calldate>@date1 and calldate<@date2;

/*
insert into rcbill_my.callingclients
-- create table rcbill_my.callingclients as
-- (
select date(a.calldate) as CAll_DATE, time(a.calldate) as CAll_TIME, a.callnumber, a.callevent, a.waittime, a.talktime 
,
b.firm, b.kod, b.mphone
from 
rcbill_my.dailycalls a 
left join
rcbill.rcb_tclients b 
on
b.mphone like concat('%', a.callnumber , '%')
where
-- (a.calldate>@date1 and a.calldate<@date2)
-- and
(a.callnumber not in ('4414243','anonymous')) and (length(a.callnumber)>3)
order by a.calldate
-- )
;

*/



select * from rcbill_my.callingclients;

select count(*) from rcbill_my.dailycalls;

select * from rcbill.rcb_clientphones order by firm;

select * from rcbill.rcb_clientphones where mphone like ('%2719841%');

select * from rcbill_my.dailycalls where callnumber like ('%2792624%');

select * from rcbill_my.dailycalls where calldate > '2017-05-28' and calldate < '2017-05-29';
select * from rcbill_my.dailycalls where (callnumber not in ('4414243','anonymous')) and (length(callnumber)>3);
select * from rcbill_my.dailycalls where length(callnumber) =3;
/*
select distinct callnumber, callevent, count(*), calldate, 
SEC_TO_TIME( SUM( TIME_TO_SEC( `waittime` ) ) ) AS sumwaittime,
SEC_TO_TIME( SUM( TIME_TO_SEC( `talktime` ) ) ) AS sumtalktime
-- sum(waittime), 
-- sum(talktime) 
from dailycalls
group by callnumber, calldate, callevent
order by 3 desc, callnumber
;
*/

/*
select a.clientcode, a.clientclass, a.contract, a.contracttype, a.servicetype, a.cost, a.price, a.orderdate, a.ordertype, a.state
from dailysales a
where 
state in ('Completed::10','Open::0')
order by orderdate, clientcode
;
*/


select *, date(calldate) as call_date, time(calldate) as call_time, hour(calldate) as call_hour, rcbill_my.GetWeekdayName(weekday(date(calldate))) as Weekday from rcbill_my.dailycalls
where date(CALLDATE)='2018-02-11'
;



SELECT date(calldate) as call_date, hour(calldate) as call_hour, CALLEVENTNAME, count(*)
FROM rcbill_my.dailycalls
GROUP BY date(calldate), hour( calldate ) , calleventname
order by calldate, 2
;



SELECT call_date, call_hour, 
case when calleventname = 'ANSWERED' then callcount end as `ANSWERED`,
case when calleventname = 'NOT ANSWERED' then callcount end as `NOTANSWERED`
FROM 
(
SELECT date(calldate) as call_date, hour(calldate) as call_hour, calleventname, count(*) as callcount
FROM rcbill_my.dailycalls
GROUP BY date(calldate), hour( calldate ) , calleventname
-- rcbill_my.dailycalls
) a
GROUP BY 1,2, 3
order by call_date, 2
;

select 
call_date, call_hour, ifnull(sum(`ANSWERED`),0) as `ANSWERED`, ifnull(sum(`NOTANSWERED`),0) as `NOTANSWERED` 
from 
(
	SELECT call_date, call_hour, 
	case when calleventname = 'ANSWERED' then callcount end as `ANSWERED`,
	case when calleventname = 'NOT ANSWERED' then callcount end as `NOTANSWERED`
	FROM 
	(
	SELECT date(calldate) as call_date, hour(calldate) as call_hour, calleventname, count(*) as callcount
	FROM rcbill_my.dailycalls
	GROUP BY date(calldate), hour( calldate ) , calleventname
	-- rcbill_my.dailycalls
	) a
	GROUP BY 1,2, 3
	order by call_date, 2
) a 
group by 1,2
order by 1 desc, 2 asc
;


SELECT date(calldate) as call_date, hour(calldate) as call_hour, CALLAGENT, CALLEVENTNAME, count(*) as callcount
FROM rcbill_my.dailycalls
where CALLEVENTNAME='ANSWERED'
GROUP BY date(calldate), hour( calldate ) , CALLAGENT, calleventname
order by calldate desc, 2 asc
;


SELECT call_date, call_hour, `SHIFT`, CALLAGENT, CALLEVENTNAME, count(*) as callcount
FROM 
(
-- rcbill_my.dailycalls
   select date(calldate) as call_date, hour(CALLDATE) as call_hour
   ,
	   case
		   when hour(calldate)>=0 and hour(calldate)<6 then 'NOC'
		   when hour(calldate)>=6 and hour(calldate)<8 then 'REMOTE'
		   when hour(calldate)>=8 and hour(calldate)<16 then 'DAY'
		   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SUNDAY' and rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SATURDAY') then 'DAY'
		   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))='SUNDAY' or rcbill_my.GetWeekdayName(weekday(date(calldate)))='SATURDAY') then 'EVENING'
		   when hour(CALLDATE)=17 then 'EVENING'
		   when hour(calldate)>=18 and hour(calldate)<23 then 'EVENING'
		   when hour(calldate)>=23 then 'NOC'
	   end as `SHIFT`
   , CALLAGENT
   , CALLEVENTNAME
   from 
   rcbill_my.dailycalls
   -- where date(CALLDATE)='2018-02-11'

) a
-- where CALLEVENTNAME='ANSWERED'
GROUP BY 1, 2, 3, 4, 5
order by 1 desc
;




SELECT call_date, `SHIFT`, CALLAGENT, CALLEVENTNAME, count(*) as callcount
FROM 
(
-- rcbill_my.dailycalls
   select date(calldate) as call_date, hour(CALLDATE) as call_hour
   ,
	   case
		   when hour(calldate)>=0 and hour(calldate)<6 then 'NOC'
		   when hour(calldate)>=6 and hour(calldate)<8 then 'REMOTE'
		   when hour(calldate)>=8 and hour(calldate)<16 then 'DAY'
		   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SUNDAY' and rcbill_my.GetWeekdayName(weekday(date(calldate)))<>'SATURDAY') then 'DAY'
		   when hour(CALLDATE)=16 and (rcbill_my.GetWeekdayName(weekday(date(calldate)))='SUNDAY' or rcbill_my.GetWeekdayName(weekday(date(calldate)))='SATURDAY') then 'EVENING'
		   when hour(CALLDATE)=17 then 'EVENING'
		   when hour(calldate)>=18 and hour(calldate)<23 then 'EVENING'
		   when hour(calldate)>=23 then 'NOC'
	   end as `SHIFT`
   , CALLAGENT
   , CALLEVENTNAME
   from 
   rcbill_my.dailycalls
   -- where date(CALLDATE)='2018-02-09'

) a
-- where CALLEVENTNAME='ANSWERED'
GROUP BY 1, 2, 3, 4
order by 1 desc
;


select * from rcbill_my.dailycalls where
date(calldate)>'2016-12-31';

#Hourly and Weekday Call Analysis
SELECT date(calldate) as call_date, hour(calldate) as call_hour, calleventname, rcbill_my.GetWeekdayName(weekday(date(calldate))) as Weekday, count(*)
FROM rcbill_my.dailycalls
GROUP BY date(calldate), hour( calldate ) , calleventname
order by calldate, 2
;

#Call stats per agent
select date(calldate) as call_date, hour(calldate) as call_hour, callagent, count(*) as call_count from rcbill_my.dailycalls
where date(calldate)>'2017-03-31'
group by 1, 2, callagent 
order by 1, 2, callagent
;