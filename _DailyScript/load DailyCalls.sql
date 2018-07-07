use rcbill_my;

-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-082016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-092016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-102016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-112016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-122016.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-012017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-022017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-032017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-042017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-01052017-17052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-18052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-19052017-21052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-22052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-23052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-24052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-25052017.csv' 
SET @date1='2018-07-06';
SET @date2='2018-07-07';
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-26052017-29052017.csv'  
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-30052017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-02062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-03062017-04062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-07062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-08062017-13062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-14062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-15062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-16062017.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-11052018-12052018.csv' 
 LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-06072018.csv' 
-- LOAD DATA LOW_PRIORITY LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 5.7\\Uploads\\CC\\distribution_detail-CC-27062017.csv' 

REPLACE INTO TABLE `rcbill_my`.`dailycalls` CHARACTER SET UTF8 FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(
@CallDate ,
@CallQueue ,
@CallAgent ,
@CallNumber ,
@CallEvent ,
@WaitTime ,
@TalkTime ,
@uniqueid 
) 
set 
 CALLDATE=str_to_date(@CallDate,'%d-%m-%Y %H:%i:%s') ,
-- DATE_FORMAT(colName,'%H:%i:%s') TIMEONLY
-- CALLDATE=@CallDate,
CALLQUEUE=@CallQueue ,
CALLQUEUENAME = (select CCQUEUENAME from rcbill_my.lkpccqueues where CCQUEUECODE=@CallQueue),
CALLAGENT=@CallAgent ,
CALLNUMBER=@CallNumber ,
CALLEVENT=@CallEvent ,
CALLEVENTNAME= (select CCEVENTNAME from rcbill_my.lkpccevents where CCEVENTCODE=@CallEvent),

WAITTIME=@WaitTime ,
TALKTIME=@TalkTime ,
UNIQUEID=@uniqueid ,
INSERTEDON=now()
;

-- select * from rcbill_my.dailycalls where date(calldate)>='2018-05-13' order by calldate;
select * from rcbill_my.dailycalls order by calldate desc;

-- SET SQL_SAFE_UPDATES = 0;
-- delete from rcbill_my.dailycalls where date(insertedon)='2018-05-29'
-- select * from rcbill_my.dailycalls where date(insertedon)='2018-02-12' order by CALL_DATE, CALL_TIME;

-- drop table if exists rcbill_my.callingclients;
-- SET @date1='2016-08-27';
-- SET @date2='2017-11-22';
drop temporary table if exists a;
create temporary table a as
(
	select a.calldate, a.callnumber, a.callqueuename, a.calleventname, a.waittime, a.talktime from 
    -- select * from 
	rcbill_my.dailycalls a 
	where
	(a.calldate>@date1 and a.calldate<@date2)
	and
	(a.callnumber not in ('4414243','anonymous')) and (length(a.callnumber)>3)
)
;
drop temporary table if exists b;
create temporary table b as
(
select firm, kod, mphone from rcbill.rcb_clientphones a where (a.mphone not in ('4414243','anonymous')) and (length(a.mphone)>3)
)
;

-- create table rcbill_my.callingclients as
-- create statement on 22/11/2017 took time 4403.156 sec
insert into rcbill_my.callingclients
(
	select date(a.calldate) as CAll_DATE, time(a.calldate) as CAll_TIME, a.callnumber,a.callqueuename, a.calleventname, a.waittime, a.talktime 
	,
	b.firm, b.kod, b.mphone
	from 
	 a 
	left join
	 b 
	on
	b.mphone like concat('%', a.callnumber , '%')
	order by a.calldate
)
;




/*
SET @date1='2016-08-27';
SET @date2='2017-11-22';
 create table rcbill_my.callingclients as
 (
select date(a.calldate) as CAll_DATE, time(a.calldate) as CAll_TIME, a.callnumber, a.callevent, a.waittime, a.talktime 
,
b.firm, b.kod, b.mphone
from 
rcbill_my.dailycalls a 
left join
rcbill.rcb_clientphones b 
on
b.mphone like concat('%', a.callnumber , '%')
where
(a.calldate>@date1 and a.calldate<@date2)
and
(a.callnumber not in ('4414243','anonymous')) and (length(a.callnumber)>3)
order by a.calldate
 )
;*/

-- SET SQL_SAFE_UPDATES = 0;
-- delete from rcbill_my.callingclients where call_date in ('2018-05-28');
-- select * from rcbill_my.dailycalls where date(insertedon)='2018-02-12' order by CALL_DATE, CALL_TIME;
select * from rcbill_my.callingclients order by CALL_DATE, CALL_TIME;

select CALL_DATE, count(1) from rcbill_my.callingclients group by CALL_DATE order by CALL_DATE desc;

-- select * from rcbill_my.callingclients where call_date in ('2018-02-09');

-- select * from rcbill.rcb_tclients;
select *,date(calldate) as CALL_DATE, time(calldate) as CALL_TIME  from rcbill_my.dailycalls;



select distinct date(calldate) as CAll_DATE,
CALLEVENTNAME, count(1) as CALLCOUNT
from rcbill_my.dailycalls
group by 1, 
-- CALLEVENT, 
CALLEVENTNAME
order by 1 desc;



select distinct date(calldate) as CAll_DATE,CALLQUEUENAME, 
-- CALLEVENT, 
CALLEVENTNAME, count(1) as CALLCOUNT
from rcbill_my.dailycalls
group by 1, CALLQUEUENAME, 
-- CALLEVENT, 
CALLEVENTNAME
order by 1 desc;

select distinct date(calldate) as CAll_DATE
-- ,CALLQUEUENAME, 
-- CALLEVENT, 
, CALLEVENTNAME
, count(1) as CALLCOUNT
from rcbill_my.dailycalls
group by 1, CALLEVENTNAME
-- , 
-- CALLEVENT, 
, CALLEVENTNAME
order by 1 desc;

/*
select distinct callnumber, firm, kod, GetCallEventName(callevent) as CallEventName, count(1) as callcount from rcbill_my.callingclients where call_date=@date1
group by callnumber, firm, kod, CallEventName
;
*/


#Previous day unanswered call stats
drop table if exists callstats;
create temporary table callstats as
(

select distinct date(P.`calldate`) as  call_date, P.`callnumber`,   
count(
	CASE 
		WHEN GetCallEventName(P.`callevent`)='ANSWERED'
        THEN 1
        ELSE NULL
	END
    ) as 'ANSWERED',
count(
	CASE 
		WHEN GetCallEventName(P.`callevent`)='NOT ANSWERED'
        THEN 1
        ELSE NULL
	END
    ) as 'NOTANSWERED'


FROM
    rcbill_my.dailycalls P

WHERE 
	date(P.`calldate`)=@date1
GROUP BY call_date, P.`callnumber`

)
;

select * from callstats;


#Previous day unanswered call report
select distinct a.CAll_DATE, a.callnumber, a.answered, a.notanswered, b.firm as PossibleClientName, b.kod as PossibleClientCode 
from 
callstats a 
left join 
rcbill_my.callingclients b
on
a.callnumber=b.callnumber
where
b.call_date=@date1
and
a.answered=0
group by a.callnumber, a.answered, a.notanswered, PossibleClientName, PossibleClientCode 
order by a.notanswered desc, a.callnumber

;

SELECT date(calldate) as call_date, rcbill_my.GetWeekdayName(weekday(date(calldate))) as Weekday, hour(calldate) as call_hour, calleventname, CALLQUEUENAME, count(1) as callcount
-- , count(distinct CALLAGENT) as agentcount
FROM rcbill_my.dailycalls
GROUP BY date(calldate), hour( calldate ) , calleventname, CALLQUEUENAME
order by calldate desc, 3 asc
;


select 
rcbill_my.GetWeekdayName(weekday(date(call_date))) as Weekday, call_date, call_hour, ifnull(sum(`ANSWERED`),0) as `ANSWERED`, ifnull(sum(`NOTANSWERED`),0) as `NOTANSWERED` 
from 
(
	SELECT call_date, call_hour, 
	case when calleventname = 'ANSWERED' then callcount end as `ANSWERED`,
	case when calleventname = 'NOT ANSWERED' then callcount end as `NOTANSWERED`
	FROM 
	(
	SELECT date(calldate) as call_date, hour(calldate) as call_hour, calleventname, count(1) as callcount
	FROM rcbill_my.dailycalls
	GROUP BY date(calldate), hour( calldate ) , calleventname
	-- rcbill_my.dailycalls
	) a
	GROUP BY 1,2, 3
	order by call_date, 2
) a 
group by 1,2,3
order by 2 desc, 3 asc
;




SELECT call_date, call_hour, `SHIFT`, CALLAGENT, CALLEVENTNAME, count(1) as callcount
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



drop table if exists rcbill_my.callstats;
create table rcbill_my.callstats as 
(
	SELECT call_date as CALLDATE, `SHIFT`, CALLAGENT, CALLEVENTNAME, count(1) as CALLCOUNT
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
)
;

select * from rcbill_my.callstats;

select a.*, upper(b.CCAGENT) as CCAGENT
from 
rcbill_my.callstats a 
left join 
rcbill_my.ccrota b 
on 
a.calldate=b.ccdate
and
a.shift=b.ccshift
and 
a.callagent=b.ccnumber
order by a.calldate desc
;