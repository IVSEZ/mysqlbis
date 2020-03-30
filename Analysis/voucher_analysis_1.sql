#### VOUCHER customers

select * from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')
order by commentdate desc
;

select clientcode, clientname, contractcode, month(OPENDATE) as OPENMONTH, year(OPENDATE) as OPENYEAR,  ticketid, commentuser, `comment` 
from  rcbill_my.clientticketjourney a
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and ticketid in 
(
select ticketid from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')
)

group by 1,2,3,4,5, 6
order by commentdate asc
;

select * from rcbill.rcb_casa where CLID in (select id from rcbill.rcb_tclients where kod='I.000005861') order by ID desc;
select * from rcbill.rcb_invoicesheader where CLID in (select id from rcbill.rcb_tclients where kod='I.000005861') order by ID desc;
select * from rcbill.rcb_invoicescontents where CLID in (select id from rcbill.rcb_tclients where kod='I.000005861') order by ID desc;



select clientcode, clientname, contractcode, month(OPENDATE) as OPENMONTH, year(OPENDATE) as OPENYEAR,  count(distinct ticketid) as d_tickets from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')

group by 1,2,3,4,5
order by 6 desc
;

select clientcode, clientname, contractcode, month(OPENDATE) as OPENMONTH, year(OPENDATE) as OPENYEAR, count(distinct ticketid) as d_tickets from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')

group by 1,2,3,4,5
order by 6 desc
;

select clientcode, clientname, contractcode, year(OPENDATE) as OPENYEAR, count(distinct ticketid) as d_tickets from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')

group by 1,2,3,4
order by 5 desc
;

select clientcode, clientname, year(OPENDATE) as OPENYEAR, count(distinct ticketid) as d_tickets from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')

group by 1,2,3
order by 4 desc
;

select * from rcbill_my.customers_contracts_collection_pivot where clientcode ='I.000005861';
