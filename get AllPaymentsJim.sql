select distinct
(select cl.kod from rcb_tCLIENTS cl where cl.ID = c.clid) as Subscriber,
cl.firm,
-- c.cid,
con.kod as contract_no,
s.Name as ServiceType,
v.name as Package,
-- clid,
c.ID as paymentid,
c.PAYDATE as paymentdate,
c.MONEY as PaymentAmt,
c.begdate as SubStart, 
c.EndDate as SubEnd
from rcb_casa c
left join rcb_services s on s.ID = - c.PAYTYPE and s.ServiceTypeID >=0
left join rcb_tclients cl ON cl.ID = C.CLID
left join rcb_contracts con ON con.ID = c.CID 
left JOIN rcb_contractservices cs ON cs.cid = con.id
left join rcb_vpnrates v ON v.id = cs.servicerateid
where 1=1
and cl.id=698681
and datediff(c.EndDate,c.begdate)>0
-- and DATEDIFF (d, c.begdate, c.EndDate)>0
and s.Name like '%Subscription%'
and cs.ServiceID in (2,20,77,84,85,86,91,103,107,108,118,119,127,129,132,136,138,145,146)
order by Subscriber, c.begdate
