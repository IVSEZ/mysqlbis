select *, `name` from rcbill.rcb_tickettechregions where TECHDEPTID is not null order by 1;

select * from rcbill.rcb_tickettechusers;

set @dept = 'Approvals';
-- set @dept = 'Technical - New Installations';
set @mth = 11;
set @yr = 2021;
set @workinghours = 8;


select 
assgntechregion as ASSGN_DEPT, assgnclosereason as CLOSE_REASON, month(ASSGN_OPENDATE) as ASSGN_MTH, year(ASSGN_OPENDATE) as ASSGN_YR
, count(ticketid) as ASSIGNMENTS
, count(distinct ticketid) as D_TICKETS

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


from rcbill_my.clientticket_assgnjourney
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr
 
group by 1,2,3,4
order by 4 desc, 3 desc


;

select *
, TIMESTAMPDIFF(SECOND, ASSGN_OPENDATE, ASSGN_CLOSEDATE) as SECONDS_OPEN
, TIMESTAMPDIFF(MINUTE, ASSGN_OPENDATE, ASSGN_CLOSEDATE) as MINUTES_OPEN


from rcbill_my.clientticket_assgnjourney 
where 0=0
and assgntechregion in (@dept)
-- and date(OPENDATE)='2022-01-05'
and month(ASSGN_OPENDATE)=@mth
and year(ASSGN_OPENDATE)=@yr

order by ASSGN_OPENDATE desc

;
 
 
 -- limit 10000;
-- select * from rcbill_my.clientticket_cmmtjourney order by OPENDATE desc limit 10000;

/*
select 
assgntechregion, date(ASSGN_OPENDATE), count(ticketid)

from rcbill_my.clientticket_assgnjourney
group by 1,2
order by 2 desc;
*/


