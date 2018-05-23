SELECT * FROM rcbill.rcb_vpnrates;

select a.id as ratingid, a.name as ratingname, a.rcurrency
,b.name as ratesname, b.price
,c.name as servicename, c.sysname, c.billingname
from 
rcbill.rcb_ratingplans a 
inner join 
rcbill.rcb_vpnrates b 
on 
a.id=b.ratingplanid

inner join 
rcbill.rcb_services c
on
b.ServiceID=c.id
;
