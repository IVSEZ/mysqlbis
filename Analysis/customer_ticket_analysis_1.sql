use rcbill;

/*
select * from  rcbill_my.clientticketjourney;
select * from  rcbill_my.clientticketsnapshot_irs ;
select * from rcbill_my.clientticketsnapshot_f;


	select clientcode, tickettype, openreason, count(1) as tickets, min(opendate) as firstticketdate, max(opendate) as lastticketdate 
	from rcbill_my.clientticketsnapshot_f
	group by clientcode, tickettype, openreason
	-- order by clientname, tickets desc
	order by tickets desc

*/

-- JOIN THE FAULT TICKETS SUMMARY WITH CLIENT REPORT
-- GET CUSTOMERS WITH MOST FAULT TICKETS
select a.*, b.* 
from 
(
	select clientcode, tickettype, openreason, count(1) as tickets, min(opendate) as firstticketdate, max(opendate) as lastticketdate  
	from rcbill_my.clientticketsnapshot_f
	group by clientcode, tickettype, openreason
	-- order by clientname, tickets desc
	order by tickets desc
) a 
inner join 
rcbill.clientextendedreport b
on 
a.clientcode=b.cl_clientcode
order by a.tickets desc
;


-- JOIN THE INSTALLATION, SURVEY, RELOCATION TICKETS SUMMARY WITH CLIENT REPORT
-- GET CUSTOMERS WITH MOST IRS TICKETS
select a.*, b.* 
from 
(
	select clientcode, tickettype, openreason, count(1) as tickets, min(opendate) as firstticketdate, max(opendate) as lastticketdate  
	from rcbill_my.clientticketsnapshot_irs
	group by clientcode, tickettype, openreason
	-- order by clientname, tickets desc
	order by tickets desc
) a 
inner join 
rcbill.clientextendedreport b
on 
a.clientcode=b.cl_clientcode
order by a.tickets desc
;

select a.*,b.* 
from 
rcbill.clientextendedreport a 
left join
rcbill_my.clientstats b 
on a.CL_CLIENTCODE=b.clientcode
where a.CL_CLIENTCODE in ('I.000015579');

select * from rcbill_my.clientticketjourney 
where ticketid in (select ticketid from rcbill_my.clientticketsnapshot_irs) 
and ((comment like '%done by%') or (comment like '%by%') or (comment like '%installation done%') or (comment like '%attended%' and comment not like '%not attended%'))
order by closedate
;