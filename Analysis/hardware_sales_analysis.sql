-- TICKETS

use rcbill_my;
use rcbill;

SET @rundate='2017-12-17';

select * from rcbill.rcb_casa limit 1000;
select * from rcbill.rcb_services limit 1000;
select * from rcbill.rcb_vpnrates limit 1000;





select a.*, b.id, b.name, b.billingname, b.kod, c.Name, c.ServiceID, c.RatingPlanID, c.Price 
from 
rcbill.rcb_casa a 
inner join 
rcbill.rcb_services b 
on 
(a.paytype=(b.id*-1))

inner join 
rcbill.rcb_vpnrates c 
on  
(a.RSID=c.ID)
where 
clid in (select id from rcbill.rcb_tclients where kod='I.000012658') 
-- b.BillingName='HARDWARE'
order by a.paydate;
