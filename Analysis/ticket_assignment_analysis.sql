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

/*

## https://stackoverflow.com/questions/35760696/mysql-average-difference-between-timestamps-excluding-weekends-and-out-of-bus

SELECT 
  clients.name
, AVG(45 * (DATEDIFF(jobs.time_updated, jobs.time_created) DIV 7) + 
          9 * MID('0123455501234445012333450122234501101234000123450', 
                  7 * WEEKDAY(jobs.time_created) + WEEKDAY(jobs.time_updated) + 1, 1) + 
          TIMESTAMPDIFF(HOUR, DATE(jobs.time_updated), jobs.time_updated) - 
          TIMESTAMPDIFF(HOUR, DATE(jobs.time_created), jobs.time_created)) AS average_response
, AVG(45 * (DATEDIFF(jobs.time_closed, jobs.time_created) DIV 7) + 
          9 * MID('0123455501234445012333450122234501101234000123450', 
                  7 * WEEKDAY(jobs.time_created) + WEEKDAY(jobs.time_closed) + 1, 1) + 
          TIMESTAMPDIFF(HOUR, DATE(jobs.time_closed), jobs.time_closed) - 
          TIMESTAMPDIFF(HOUR, DATE(jobs.time_created), jobs.time_created)) AS average_closure
, COUNT(jobs.id) AS ticket_count 
, SUM(time_total) AS time_spent 
FROM jobs
LEFT JOIN clients ON jobs.client = clients.id 
WHERE jobs.status = 'closed' 
GROUP BY jobs.client

*/

/*
## code in ticket analysis
			, (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays
			-- , (5 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2

			## commented on 11/01/2022 and updated with new code
			-- , (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345011234560', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2
            , (6 * (DATEDIFF(a.closedate,a.opendate) DIV 7) + MID('0123455501234445012333450122234501112345000123450', 7 * WEEKDAY(a.opendate) + WEEKDAY(a.closedate) + 1, 1)) as tkt_workdays2



*/

, AVG(45 * (DATEDIFF(ASSGN_CLOSEDATE, ASSGN_OPENDATE) DIV 7) + 
          9 * MID('0123444401233334012222340111123400001234000123440', 
                  7 * WEEKDAY(ASSGN_OPENDATE) + WEEKDAY(ASSGN_CLOSEDATE) + 1, 1) + 
          TIMESTAMPDIFF(HOUR, DATE(ASSGN_CLOSEDATE), ASSGN_CLOSEDATE) - 
          TIMESTAMPDIFF(HOUR, DATE(ASSGN_OPENDATE), ASSGN_OPENDATE)) AS average_response5DayWeek
, AVG(45 * (DATEDIFF(ASSGN_CLOSEDATE, ASSGN_OPENDATE) DIV 7) + 
          9 * MID('0123455501234445012333450122234501112345000123450', 
                  7 * WEEKDAY(ASSGN_OPENDATE) + WEEKDAY(ASSGN_CLOSEDATE) + 1, 1) + 
          TIMESTAMPDIFF(HOUR, DATE(ASSGN_CLOSEDATE), ASSGN_CLOSEDATE) - 
          TIMESTAMPDIFF(HOUR, DATE(ASSGN_OPENDATE), ASSGN_OPENDATE)) AS average_response6DayWeek



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


