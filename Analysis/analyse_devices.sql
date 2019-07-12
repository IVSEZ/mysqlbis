select 
a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, a.NATIP
, a.UserName
, b.id as ContractId,b.kod as ContractCode, b.ContractType
, cs.ID as CSID
 , d.ID as ServiceId, d.Name as ServiceType
, b.clid
, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from
rcbill.rcb_tclients c
-- inner join 
left join 
rcbill.rcb_contracts b 
on c.id=b.clid
left join 
rcbill.rcb_contractservices cs
on b.id=cs.cid

left join
rcbill.rcb_devices a 
-- on a.contractid=b.id
on cs.id=a.CSID

left join 
rcbill.rcb_services d
on cs.ServiceId=d.Id

where c.kod='I.000009236'
;

select 
a.id as DeviceId, a.contractid as CONID, a.phoneno, a.mac, a.address, a.NATIP
, a.UserName
, b.id as ContractId,b.kod as ContractCode, b.ContractType
, cs.ID as CSID
 , d.ID as ServiceId, d.Name as ServiceType
, b.clid
, c.id as ClientId, c.kod as ClientCode, c.firm as ClientName, c.address as ClientAddress
from
rcbill.rcb_tclients c
-- inner join 
left join 
rcbill.rcb_contracts b 
on b.clid=c.id
left join 
rcbill.rcb_contractservices cs
on b.id=cs.cid

left join
rcbill.rcb_devices a 
-- on a.contractid=b.id
on cs.id=a.CSID

left join 
rcbill.rcb_services d
on cs.ServiceId=d.Id
where c.kod='I.000003635'
;

select * from rcbill.rcb_tclients where kod='I.000009236';
select * from rcbill.rcb_contracts where clid=721195;
select * from rcbill.rcb_contractservices where cid in (select id from rcbill.rcb_contracts where clid=721195);
select * from rcbill.rcb_devices where mac='00.1d.d1.9e.c9.42';
select * from rcbill.rcb_services where id=19;
-- select * from rcbill.rcb_services;
select * from rcbill.rcb_contractservices where id=4237394;