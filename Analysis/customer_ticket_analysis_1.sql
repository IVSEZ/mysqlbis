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

select * from rcbill.clientextendedreport where CL_CLIENTCODE in ('I.000015579');