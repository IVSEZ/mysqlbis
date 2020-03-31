#### VOUCHER customers

select * from  rcbill_my.clientticketjourney 
where 0=0 
-- and commentuser in ('Rahul Walavalkar') 
and (trim(upper(comment)) REGEXP 'VOUCHER')
order by commentdate desc
;


#### VOUCHER STATS FOR REPORT

select a.*
-- , b.*
, b.IsAccountActive, b.AccountActivityStage, b.activenetwork, b.activeservices, b.clientclass, b.clientaddress, b.clientarea
-- , b.TotalPayments2020, b.TotalPaymentAmount2020, b.TotalPayments2019, b.TotalPaymentAmount2019
from 
(

	select clientcode, clientname, contractcode, month(OPENDATE) as OPENMONTH, year(OPENDATE) as OPENYEAR,  ticketid, commentuser, commentdate, `comment` 
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
	and year(OPENDATE)>2018
	group by 1,2,3,4,5, 6
	order by commentdate desc
) a 
inner join 
rcbill_my.rep_custconsolidated b
on a.clientcode=b.clientcode
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
