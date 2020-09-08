-- TICKETS

use rcbill_my;
use rcbill;

SET @rundate='2017-12-17';

select * from rcbill.rcb_casa limit 1000;
select * from rcbill.rcb_services limit 1000;
select * from rcbill.rcb_vpnrates limit 1000;


set @clientcode='I.000021520';
set @clientcode='I.000000612';
set @clientcode='I.000018919';


select * from rcbill.rcb_casa where CLID in  (select id from rcbill.rcb_tclients where kod=@clientcode) order by PAYDATE desc;
select * from rcbill.rcb_invoicesheader where CLID in (select id from rcbill.rcb_tclients where kod=@clientcode) order by DATA desc;
select * from rcbill.rcb_invoicescontents where CLID in (select id from rcbill.rcb_tclients where kod=@clientcode) order by UPDDATE desc;

-- ===================================================

select a.*, b.id, b.name, b.billingname, b.kod, c.Name, c.ServiceID, c.RatingPlanID, c.Price
-- , invh.*
-- , invh.id, invh.invoiceno, invh.hard, invh.type, invh.data, invh.suma, invh.dds, invh.total, invh.currency, invh.upddate
-- , invc.* 
from 
rcbill.rcb_casa a 

-- inner join 
-- rcbill.rcb_invoicesheader invh
-- on a.invid=invh.id
-- on a.id=invh.paymentid

-- inner join 
-- rcbill.rcb_invoicescontents invc
-- on invh.invoiceno=invc.invoiceno

inner join
rcbill.rcb_services b 
on 
(a.paytype=(b.id*-1))

inner join 
rcbill.rcb_vpnrates c 
on  
(a.RSID=c.ID)
where 
0=0

-- and a.clid in (select id from rcbill.rcb_tclients where kod=@clientcode) 

-- and b.BillingName in ('HARDWARE','MATERIALS')
and (b.BillingName like '%HARDWARE%' or b.BillingName like '%MATERIALS%')
order by a.paydate desc
;

-- ====================================================


select 
rcbill.GetClientCode(a.clid) as clientcode,
rcbill.GetClientNameFromID(a.clid) as clientname,
rcbill.GetContractCode(a.cid) as contractcode,
-- (SELECT `NAME` FROM rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) as EMPLOYEENAME,
(SELECT `NAME` FROM rcbill.rcb_users where ID=a.USERID LIMIT 1) as USERNAME
-- a.clid
, a.money, c.price
, a.enterdate, a.upddate -- , a.userid, a.cid, a.hard, a.rsid,a.invid, b.id, b.name
, b.billingname -- , b.kod
, c.Name -- , c.ServiceID, c.RatingPlanID, c.Price

-- , invh.*
-- , invh.id, invh.invoiceno, invh.hard, invh.type, invh.data, invh.suma, invh.dds, invh.total, invh.currency, invh.upddate
-- , invc.* 
from 
rcbill.rcb_casa a 

-- inner join 
-- rcbill.rcb_invoicesheader invh
-- on a.invid=invh.id
-- on a.id=invh.paymentid

-- inner join 
-- rcbill.rcb_invoicescontents invc
-- on invh.invoiceno=invc.invoiceno

inner join
rcbill.rcb_services b 
on 
(a.paytype=(b.id*-1))

inner join 
rcbill.rcb_vpnrates c 
on  
(a.RSID=c.ID)
where 
0=0

-- and a.clid in (select id from rcbill.rcb_tclients where kod=@clientcode) 

-- and b.BillingName in ('HARDWARE','MATERIALS')
and (b.BillingName like '%HARDWARE%' or b.BillingName like '%MATERIALS%')

-- and a.invid>=0
order by a.paydate desc
;

-- ====================================================

select 
rcbill.GetClientCode(a.clid) as clientcode,
rcbill.GetClientNameFromID(a.clid) as clientname,
rcbill.GetContractCode(a.cid) as contractcode,
-- (SELECT `NAME` FROM rcbill.rcb_tickettechusers where RCBUSERID=a.USERID LIMIT 1) as EMPLOYEENAME,
(SELECT `NAME` FROM rcbill.rcb_users where ID=a.USERID LIMIT 1) as USERNAME
-- a.clid
, a.money, c.price
, a.enterdate, a.upddate -- , a.userid, a.cid, a.hard, a.rsid,a.invid, b.id, b.name
, b.billingname -- , b.kod
, c.Name -- , c.ServiceID, c.RatingPlanID, c.Price

-- , invh.*
-- , invh.id, invh.invoiceno, invh.hard, invh.type, invh.data, invh.suma, invh.dds, invh.total, invh.currency, invh.upddate
-- , invc.* 
from 
rcbill.rcb_casa a 

-- inner join 
-- rcbill.rcb_invoicesheader invh
-- on a.invid=invh.id
-- on a.id=invh.paymentid

-- inner join 
-- rcbill.rcb_invoicescontents invc
-- on invh.invoiceno=invc.invoiceno

inner join
rcbill.rcb_services b 
on 
(a.paytype=(b.id*-1))

inner join 
rcbill.rcb_vpnrates c 
on  
(a.RSID=c.ID)
where 
0=0

-- and a.clid in (select id from rcbill.rcb_tclients where kod=@clientcode) 

-- and b.BillingName in ('HARDWARE','MATERIALS')
and (b.BillingName like '%HARDWARE%' or b.BillingName like '%MATERIALS%')

and a.invid>=0
order by a.paydate desc
;

