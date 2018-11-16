select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%approved%' or comment like 'approved%' or comment like '%approved') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%reject%' or comment like 'reject%' or comment like '%reject') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%unable%' or comment like 'unable%' or comment like '%unable') order by commentdate desc;

select * from  rcbill_my.clientticketjourney where commentuser in ('Rahul Walavalkar') and (comment like '%quantify%' or comment like 'quantify%' or comment like '%quantify') order by commentdate desc;

############################################################################
## OTHER USERS
select distinct commentuser, comment, count(*) as cmmt_count
from 
rcbill_my.clientticket_cmmtjourney
where commentuser in ('Rahul Walavalkar') 
group by commentuser, comment
order by 3 desc
;

select commentuser, date(commentdate) as commentdate, rcbill_my.GetWeekdayName(weekday(commentdate)) as commentday, count(comment) as comments, count(distinct ticketid) as d_tickets
from 
rcbill_my.clientticket_cmmtjourney
group by commentuser, 2, 3
order by 4 desc;




select commentuser,  count(comment) as comments, count(distinct ticketid) as d_tickets
, min(date(commentdate)) as mindate, max(date(commentdate)) as maxdate, count(distinct date(commentdate)) as cmmtdays
, datediff(max(date(commentdate)), min(date(commentdate))) as totaldays
, count(comment)/count(distinct date(commentdate)) as avgcmtday
from 
rcbill_my.clientticket_cmmtjourney
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

select * from  rcbill_my.clientticket_cmmtjourney where commentuser in ('Rahul Walavalkar') ;
set @ticketid=888003;

select * from rcbill_my.clientticketjourney where ticketid=@ticketid; -- limit 10;
select * from rcbill_my.clientticket_assgnjourney where ticketid=@ticketid; -- limit 10;
select * from rcbill_my.clientticket_cmmtjourney where ticketid=@ticketid; -- limit 10;


select COUNT(*) as clientticketjourney  from rcbill_my.clientticketjourney;
select COUNT(*) as clientticket_assgnjourney from rcbill_my.clientticket_assgnjourney;
select COUNT(*) as clientticket_cmmtjourney  from rcbill_my.clientticket_cmmtjourney;
