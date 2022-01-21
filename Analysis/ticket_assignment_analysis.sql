select *, `name` from rcbill.rcb_tickettechregions where TECHDEPTID is not null order by 1;

select * from rcbill.rcb_tickettechusers;

select * from rcbill_my.holidays order by HOLIDAY_DATE desc;

-- set @dept = 'Approvals';
-- set @dept = 'Technical - New Installations';
-- set @dept = 'Tech Support';
-- set @dept = 'Call Center';
-- set @dept = 'NOC';
-- set @dept = 'Praslin - Installations';
-- set @dept = 'Technical - New Service';
-- set @dept = 'Accounts & Finance';
set @mth = 12;
set @yr = 2021;
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




