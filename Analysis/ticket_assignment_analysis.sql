select *, `name` from rcbill.rcb_tickettechregions where TECHDEPTID is not null order by 1;

select * from rcbill.rcb_tickettechusers;

select * from rcbill_my.holidays order by HOLIDAY_DATE desc;

 set @dept = 'Approvals';
-- set @dept = 'Technical - New Installations';
-- set @dept = 'Tech Support';
-- set @dept = 'Call Center';
-- set @dept = 'NOC';
-- set @dept = 'Praslin - Installations';
-- set @dept = 'Technical - New Service';
-- set @dept = 'Accounts & Finance';
set @mth = 05;
set @yr = 2022;
set @workinghours = 8;

select * 
from rcbill_my.clientticket_assgnjourney
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr
;

select 
assgntechregion as ASSGN_DEPT, assgnclosereason as CLOSE_REASON, month(ASSGN_OPENDATE) as ASSGN_MTH, year(ASSGN_OPENDATE) as ASSGN_YR

, count(ticketid) as ASSIGNMENTS
, count(distinct ticketid) as D_TICKETS

, round(avg(working_minutes),2) as `AVG_WORKINGMINS`
, sec_to_time(round(avg(working_minutes))*60) as `AVG_TIME`
, (round(avg(working_minutes)/60)/@workinghours) as `AVG_DAYS`
, max(working_minutes) as `MAX_WORKINGMINS`
, min(working_minutes) as `MIN_WORKINGMINS`


/*
, round(avg(tkt_workdays),2) as `5DayWeek_AVGDAYS`
, (round(avg(tkt_workdays),2)*@workinghours) as `5DayWeek_AVGHRS`

, max(tkt_workdays) as `5DayWeek_MAXDAYS`
-- , (max(tkt_workdays)*@workinghours) as `5DayWeek_MAXHRS`

, min(tkt_workdays) as `5DayWeek_MINDAYS`
-- , (min(tkt_workdays)*@workinghours) as `5DayWeek_MINHRS`

, round(avg(tkt_workdays2),2) as `6DayWeek_AVGDAYS`
, (round(avg(tkt_workdays2),2)*@workinghours) as `6DayWeek_AVGHRS`

, max(tkt_workdays2) as `6DayWeek_MAXDAYS`
-- , (max(tkt_workdays2)*@workinghours) as `6DayWeek_MAXHRS`

, min(tkt_workdays2) as `6DayWeek_MINDAYS`
-- , (min(tkt_workdays2)*@workinghours) as `6DayWeek_MINHRS`

, round(avg(tkt_alldays),2) as `7DayWeek_AVGDAYS`
, (round(avg(tkt_alldays),2)*@workinghours) as `7DayWeek_AVGHRS`

, max(tkt_alldays) as `7DayWeek_MAXDAYS`
-- , (max(tkt_alldays)*@workinghours) as `7DayWeek_MAXHRS`

, min(tkt_alldays) as `7DayWeek_MINDAYS`
-- , (min(tkt_alldays)*@workinghours) as `7DayWeek_MINHRS`

*/
from rcbill_my.clientticket_assgnjourney
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr
 
group by 1,2,3,4
order by 4 desc, 3 desc


;



select 
assgntechregion as ASSGN_DEPT
, month(ASSGN_OPENDATE) as ASSGN_MTH, year(ASSGN_OPENDATE) as ASSGN_YR

, count(ticketid) as ASSIGNMENTS
, count(distinct ticketid) as D_TICKETS

, round(avg(working_minutes),2) as `AVG_WORKINGMINS`
, sec_to_time(round(avg(working_minutes))*60) as `AVG_TIME`
, (round(avg(working_minutes)/60)/@workinghours) as `AVG_DAYS`
, max(working_minutes) as `MAX_WORKINGMINS`
, min(working_minutes) as `MIN_WORKINGMINS`


from rcbill_my.clientticket_assgnjourney
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr
 
group by 1,2,3
order by 3 desc, 2 desc


;



select 
ticketid, OPENDATE, openuser, openreason, CLOSEDATE, closeuser, closereason, clientname, clientcode, contractcode, service, tickettype, ticketstate, assgntechregion, assgntechuser, ASSGN_OPENDATE, ASSGN_CLOSEDATE, tkt_alldays, tkt_workdays, tkt_workdays2, assgnclosereason, assgnuser, ASSGN_UPDDATE
-- , rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,'08:00','17:00') AS working_minutes
-- , (rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,'08:00','17:00')/60) AS working_hours
, rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)) as shift_timings
, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1) as start_time
, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2) as end_time
, rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3) as dept_flag

, rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)) AS working_minutes
-- , (rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours
, sec_to_time((rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)))*60) AS working_hours

, rcbill_my.workday_time_diff_holidays2(rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3), 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)) AS working_minutes2
-- , (rcbill_my.workday_time_diff_holidays2(rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3), 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours2
, sec_to_time((rcbill_my.workday_time_diff_holidays2(rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3), 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)))*60) AS working_hours2


, dayname(ASSGN_OPENDATE) as OPEN_DAY
, dayname(ASSGN_CLOSEDATE) as CLOSE_DAY
, (select HOLIDAY_NAME from rcbill_my.holidays where COUNTRY_CODE='SC' and (HOLIDAY_DATE)=date(ASSGN_OPENDATE) ) as OPEN_HOLIDAY
, (select HOLIDAY_NAME from rcbill_my.holidays where COUNTRY_CODE='SC' and (HOLIDAY_DATE)=date(ASSGN_CLOSEDATE) ) as CLOSE_HOLIDAY

from 
rcbill_my.clientticket_assgnjourney 
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr

order by ASSGN_OPENDATE desc
;



-- Select rcbill_my.workday_time_diff_holidays('SC','2021-06-10 12:00:00','2021-06-10 14:00:00','09:00','16:00');


-- set @dept = 'Approvals';
-- set @dept = 'Technical - New Installations';
-- set @dept = 'Tech Support';
-- set @dept = 'Call Center';
-- set @dept = 'NOC';
-- set @dept = 'Praslin - Installations';
-- set @dept = 'Technical - InHouse Service';
-- set @dept = 'Accounts & Finance';
-- set @dept = 'Technical - Work Order Management';
-- set @dept  = 'PO-Migration';
/*
Praslin - Installations
Technical - Corporate
PO-Relocation
Technical - New Installations
Tech Support - Usage
Retention
PO-Installations
Praslin Tech - Service
Praslin - Sales 
Call Center - On Hold
Technical - Pending Service
Call Center
Technical - Pending Installations
Technical - Work Order Management
Technical - Additional Service Installations
NOC
Technical - InHouse Service

Hardware Testing
Accounts & Finance
Sales & Marketing
Praslin - Maintenance
PO-Migration
Rcboss
Technical - Relocation
Technical - Maintenance
Corporate Sales
Approvals
Tech Support
Technical - Audit
Technical - Survey
*/


set @mth = 06;
set @yr = 2022;
set @workinghours = 8;


select * 
-- , ceiling( TIMESTAMPDIFF(MINUTE, ASSGN_OPENDATE, ASSGN_CLOSEDATE)) as MINS
-- , ceiling( TIMESTAMPDIFF(SECOND, ASSGN_OPENDATE, ASSGN_CLOSEDATE)/60) as MINS2

from rcbill_my.clientticket_assgnjourney
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr
;



select 
assgntechregion as ASSIGNED_DEPT
, month(ASSGN_OPENDATE) as ASSGN_MTH, year(ASSGN_OPENDATE) as ASSGN_YR


, count(ticketid) as ASSIGNMENTS
, count(distinct ticketid) as D_TICKETS

, min(actual_minutes) as `MIN_ACTUALMINS`
, max(actual_minutes) as `MAX_ACTUALMINS`
, round(AVG(NULLIF(actual_minutes,0)),2) as  `AVG_ACTUALMINS`
,  sec_to_time(round(AVG(NULLIF(actual_minutes,0)))*60) as `AVG_ACTUALTIME`
, (round(AVG(NULLIF(actual_minutes,0))/60)/24) as `AVG_ACTUALDAYS`



, SHIFT_TIMINGS
, WORK_START
, WORK_END
, IF(DEPT_FLAG=0,'NO','YES') as WORK_WEEKENDS

-- , rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)) as shift_timings
-- , rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1) as WORK_START
-- , rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2) as WORK_END
-- , IF((rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3))=0,'NO','YES') as WORK_WEEKENDS


, min(working_minutes) as `MIN_WORKINGMINS`
, max(working_minutes) as `MAX_WORKINGMINS`
-- , round(avg(working_minutes),2) as `AVG_WORKINGMINS1`
, round(AVG(NULLIF(working_minutes,0)),2) as  `AVG_WORKINGMINS`

-- , sec_to_time(round(avg(working_minutes))*60) as `AVG_WORKINGTIME1`
, sec_to_time(round(AVG(NULLIF(working_minutes,0)))*60) as `AVG_WORKINGTIME`

-- , (round(avg(working_minutes)/60)/@workinghours) as `AVG_WORKINGDAYS1`
, (round(AVG(NULLIF(working_minutes,0))/60)/@workinghours) as `AVG_WORKINGDAYS`



from rcbill_my.clientticket_assgnjourney
where 0=0
-- and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
-- and month(ASSGN_OPENDATE)=@mth
-- and year(ASSGN_OPENDATE)=@yr
 
group by 1,2,3
order by 3 desc, 2 desc
;

show index from rcbill_my.rep_servicetickets_2022;
select * from rcbill_my.rep_servicetickets_2022 where assgntechregion='Approvals' and month(assgnopendate)=7;

select * from rcbill_my.rep_clientticket_assgnjourney;

select ASSIGNED_DEPT, ASSGN_MTH, ASSGN_YR, D_TICKETS,AVG_ACTUALTIME, AVG_ACTUALMINS,AVG_WORKINGTIME, AVG_WORKINGMINS, AVG_WORKINGDAYS, WORK_START, WORK_END, WORK_BREAKS, WORK_WEEKENDS 
,round((TIME_TO_SEC(TIMEDIFF(WORK_END,WORK_START) - INTERVAL WORK_BREAKS HOUR)/3600),1) as DAILY_WORKING_HOURS
from rcbill_my.rep_clientticket_assgnjourney order by ASSGN_YR ASC , ASSGN_MTH ASC;


SELECT ASSIGNED_DEPT, ASSGN_MTH, ASSGN_YR, ASSIGNMENTS, D_TICKETS,AVG_ACTUALTIME, AVG_ACTUALMINS,AVG_WORKINGTIME, AVG_WORKINGMINS, AVG_WORKINGDAYS, WORK_START, WORK_END, WORK_BREAKS, WORK_WEEKENDS 
,round((TIME_TO_SEC(TIMEDIFF(WORK_END,WORK_START) - INTERVAL WORK_BREAKS HOUR)/3600),1) as DAILY_WORKING_HOURS 
from rcbill_my.rep_clientticket_assgnjourney where ASSGN_YR>=2020 and ASSIGNED_DEPT='Approvals' order by ASSGN_YR asc, ASSGN_MTH asc;

select 
ticketid AS TKT_ID, OPENDATE AS TKT_OPEN_DATE, openuser AS TKT_OPEN_BY, openreason AS TKT_OPEN_REASON, CLOSEDATE AS TKT_CLOSE_DATE, closeuser AS TKT_CLOSE_BY, closereason AS TKT_CLOSE_REASON
, tickettype AS TKT_TYPE, ticketstate AS TKT_STATE
, service AS SERVICE

, clientname AS CLIENT_NAME, clientcode AS CLIENT_CODE, contractcode AS CONTRACT_CODE
, assgntechregion AS ASSIGNED_DEPT

-- , rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,'08:00','17:00') AS working_minutes
-- , (rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,'08:00','17:00')/60) AS working_hours
, SHIFT_TIMINGS

, WORK_START
, WORK_END
, IF(DEPT_FLAG=0,'NO','YES') as WORK_WEEKENDS

-- , rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1) as start_time
-- , rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2) as end_time
-- , rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3) as dept_flag



, ASSGN_OPENDATE
, OPEN_DAY
, OPEN_HOLIDAY

, ASSGN_CLOSEDATE
, CLOSE_DAY
, CLOSE_HOLIDAY


, assgntechuser AS ASSGN_CLOSED_BY

, ASSGN_STATE
-- , tkt_alldays, tkt_workdays, tkt_workdays2
, assgnclosereason AS ASSGN_CLOSE_REASON
, assgnuser AS LAST_UPDATE_BY
, ASSGN_UPDDATE AS LAST_UPDATE


-- COMMENTED ON 22/7/22 , rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)) AS working_minutes1


-- , (rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours
-- COMMENTED ON 22/7/22 , sec_to_time((rcbill_my.workday_time_diff_holidays('SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2)))*60) AS working_hours1

, WORKING_MINUTES
-- , (rcbill_my.workday_time_diff_holidays2(rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',3), 'SC',ASSGN_OPENDATE,ASSGN_CLOSEDATE,rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',1),rcbill_my.SPLIT_STR(rcbill_my.GetShiftTimingsForDept(upper(assgntechregion)),'|',2))/60) AS working_hours2
, WORKING_HOURS
, ACTUAL_MINUTES
, ACTUAL_HOURS


from 
rcbill_my.clientticket_assgnjourney 
where 0=0
 and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
 and month(ASSGN_OPENDATE)=@mth
 and year(ASSGN_OPENDATE)=@yr

order by ASSGN_OPENDATE desc
;


