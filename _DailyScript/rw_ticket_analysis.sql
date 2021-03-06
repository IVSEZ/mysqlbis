select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%approved%' or comment like 'approved%' or comment like '%approved') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%reject%' or comment like 'reject%' or comment like '%reject') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%unable%' or comment like 'unable%' or comment like '%unable') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%quantify%' or comment like 'quantify%' or comment like '%quantify') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%Payment Gateway%') order by commentdate desc;


select * from  rcbill_my.clientticketjourney where 
-- commentuser in ('Rahul Walavalkar') and 
(comment like '%deposit%') order by commentdate desc;

############################################################################
## OTHER USERS
select distinct commentuser, comment, count(*) as cmmt_count
from 
rcbill_my.clientticket_cmmtjourney
where commentuser in ('Rahul Walavalkar','Administrator') 
group by commentuser, comment
order by 3 desc
;

select commentuser, date(commentdate) as commentdate, rcbill_my.GetWeekdayName(weekday(commentdate)) as commentday, count(comment) as comments, count(distinct ticketid) as d_tickets
from 
rcbill_my.clientticket_cmmtjourney
group by commentuser, 2, 3
order by 4 desc;



### tickets by user for this year
select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
, count(comment)/count(distinct date(commentdate)) as avgcmtday
, (count(distinct date(commentdate))/datediff(max(date(commentdate)), min(date(commentdate)))) as consistency
from 
rcbill_my.clientticket_cmmtjourney
where year(commentdate)=year(now())
group by commentuser
order by 2 desc;

### tickets by user for 2018
select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as firstdate, max(date(commentdate)) as lastdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
, count(comment)/count(distinct date(commentdate)) as avgcmtday
, (count(distinct date(commentdate))/datediff(max(date(commentdate)), min(date(commentdate)))) as consistency
from 
rcbill_my.clientticket_cmmtjourney
where year(commentdate)=2018
group by commentuser
order by 2 desc;





select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as mindate, max(date(commentdate)) as maxdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
from 
rcbill_my.clientticket_cmmtjourney
where commentuser in ('Rency Morel','')
group by commentuser
order by 2 desc;

############################################################################


select distinct commentuser from rcbill_my.clientticketjourney;
select distinct commentuser from rcbill_my.clientticket_cmmtjourney;


select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and opendate>='2018-01-01';

select assgntechregion, year(ASSGN_OPENDATE) as year, count(ticketid) as tickets, count(distinct ticketid) as d_tickets
from rcbill_my.clientticket_assgnjourney
-- where assgntechregion='Approvals'
-- and year(ASSGN_OPENDATE)=year(now())
-- and ASSGN_CLOSEDATE is not null
-- and CLOSEDATE is not null
group by assgntechregion, 2
order by 2
;


select * from  rcbill_my.clientticket_cmmtjourney where commentuser in ('Rahul Walavalkar') ;
set @ticketid=888003;

select * from rcbill_my.clientticketjourney where ticketid=@ticketid; -- limit 10;
select * from rcbill_my.clientticket_assgnjourney where ticketid=@ticketid; -- limit 10;
select * from rcbill_my.clientticket_cmmtjourney where ticketid=@ticketid; -- limit 10;


select COUNT(*) as clientticketjourney  from rcbill_my.clientticketjourney;
select COUNT(*) as clientticket_assgnjourney from rcbill_my.clientticket_assgnjourney;
select COUNT(*) as clientticket_cmmtjourney  from rcbill_my.clientticket_cmmtjourney;



select count(distinct ticketid) as clientticket_assgnjourney from rcbill_my.clientticket_assgnjourney
where assgntechregion='Approvals'
and CLOSEDATE is not null
;