select * from rcbill.clientvodstats where clientname like '%rahul%' order by sessionstart;
select * from rcbill.clientvodstats where clientname like '%bridget%' order by sessionstart;
select * from rcbill.clientvodstats where clientcode = 'I.000013575' order by sessionstart;
-- NADIA CAMILLE


select * from rcbill.rcb_vodtelemetry where device in ('68.db.67.59.9b.37') order by sessionstart;

select * from rcbill.clientcontractdevices where mac in ('68.db.67.59.9b.37');


select * from rcbill.clientvodstats where clientcode = 'I.000009221' order by sessionstart;

select * from rcbill.rcb_vodtelemetry where device in ('84.62.23.19.a6.50') order by sessionstart;
select * from rcbill.clientcontractdevices where mac in ('84.62.23.19.a6.50');

select * from rcbill.rcb_vodtelemetry where device in ('84.62.23.19.a7.95') order by sessionstart;
select * from rcbill.clientcontractdevices where mac in ('84.62.23.19.a7.95');


-- RONDY MICHEL RENAUD
select * from rcbill.clientvodstats where clientcode = 'I.000009435' order by sessionstart;

select * from rcbill.rcb_vodtelemetry where resource = 'TT1570728' and date(SESSIONSTART)='2017-09-06';


select * from rcbill.clientcontractdevices 
where mac = '0c.56.5c.65.c8.20'
order by mac;

select mac, contractcode, clientcode, clientname, count(*)
from rcbill.clientcontractdevices
 where mac = '00.18.9B.64.23.09'
-- where clientname like '%test%'
group by mac, contractcode, clientcode, clientname
order by mac
;


select a.mac, a.phoneno, a.contractcode,a.contracttype, a.clientcode, a.clientname, b.*

from rcbill.clientcontractdevices a
inner join
rcbill_my.clientstats b
on a.clientcode = b.clientcode
where a.mac!='' 
and
(a.phoneno=a.mac)
order by 
b.clientcode,a.mac
;


-- all devices which are currently active on prepaid or prepaid data
select distinct contracttype from rcbill.clientcontractdevices;


select a.mac, a.phoneno, a.contractcode,a.contracttype,a.clientcode, a.clientname, a.address,
b.*

from rcbill.clientcontractdevices a
inner join
rcbill_my.clientstats b
on a.clientcode = b.clientcode
where a.mac in ('00.26.24.b6.d9.20',
'00.1d.d2.96.37.72',
'00.1d.d2.96.36.32',
'58.23.8c.9f.41.5c')
and
(a.phoneno=a.mac)
-- and 
-- (b.`Prepaid Data`>0)
order by a.clientname
;



select a.mac, a.phoneno, a.contractcode,a.contracttype,a.clientcode, a.clientname, a.address,
b.*

from rcbill.clientcontractdevices a
inner join
rcbill_my.clientstats b
on a.clientcode = b.clientcode
where a.mac!=''
and
(a.phoneno=a.mac)
and 
(b.`Prepaid Data`>0)
order by a.clientname
;


select * from rcbill_my.clientstats where `Prepaid Data`>0;

-- select * from rcbill_my.anreport;

-- GET ALL PREPAID DATA CUSTOMERS FROM CLIENTSTATS
select a.period,a.clientcode,a.clientname,a.clientclass,a.clienttype,a.services,a.`Prepaid Data`
, b.contractcode, b.package
from 
rcbill_my.clientstats a
inner join 
rcbill_my.activeccl b
on a.clientcode=b.clientcode
where 
a.`Prepaid Data`>0
and b.package='Prepaid Data'
;


-- GET ALL DEVICES FOR ALL CLIENTS WHOSE PREPAID DATA CONTRACTS ARE ACTIVE 
select a.mac, a.phoneno, a.contractcode,a.contracttype,a.clientcode, a.clientname, a.address,
b.*

from rcbill.clientcontractdevices a
inner join
(
select a.period,a.clientcode,a.clientname,a.clientclass,a.clienttype,a.services,a.`Prepaid Data`
, b.contractcode, b.package
from 
rcbill_my.clientstats a
left join 
rcbill_my.activeccl b
on a.clientcode=b.clientcode
where 
a.`Prepaid Data`>0
and b.package='Prepaid Data'
) b
on a.clientcode=b.clientcode 
and 
a.contractcode=b.contractcode

where a.mac!=''
and
(a.phoneno=a.mac)
order by a.clientcode
;




-- GET ALL DEVICES FOR ALL CLIENTS WHOSE PREPAID DATA CONTRACTS ARE ACTIVE 
select a.mac, a.phoneno, a.contractcode,a.contracttype,a.clientcode, a.clientname, a.address,
b.*

from rcbill.clientcontractdevices a
inner join
(
select a.period,a.clientcode,a.clientname,a.clientclass,a.clienttype,a.services
, b.contractcode, b.package
from 
rcbill_my.clientstats a
left join 
rcbill_my.activeccl b
on a.clientcode=b.clientcode
where 
a.clientname like '%test%'

-- a.`Prepaid Data`>0
-- and b.package='Prepaid Data'
) b
on a.clientcode=b.clientcode 
and 
a.contractcode=b.contractcode

where a.mac!=''
and
(a.phoneno=a.mac)
order by a.clientcode
;


select * from rcbill.rcb_devicesold limit 1000 where natip like '%3494a12%';

select * from rcbill.rcb_devicesold where mac in ('0c.56.5c.65.c8.20','0c.56.5c.65.c6.d8','0c.56.5c.73.60.b8','0c.56.5c.73.62.09');

select * from rcbill.rcb_devices where mac in ('0c.56.5c.65.c8.20','0c.56.5c.65.c6.d8','0c.56.5c.73.60.b8','0c.56.5c.73.62.09');


/*
select a.period,a.clientcode,a.clientname,a.clientclass,a.clienttype,a.services,a.`Prepaid`
from 
rcbill_my.clientstats a
where 
a.`Prepaid`>0;

*/
-- select * from rcbill.rcb_vpnrates;