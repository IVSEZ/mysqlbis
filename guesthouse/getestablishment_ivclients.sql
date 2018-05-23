/*
select * from 
rcbill_my.establishmentphones a
inner join
rcbill.rcb_clientphones b
on 
a.ESTPHONE=b.mphone
where a.estphone <>''
;


select * from rcbill.rcb_clientphones 
where
mphone in 
(
select estphone from rcbill_my.establishmentphones where estphone <> ''
)
;
*/
-- select * from rcbill_my.establishmentphones where estphone = '';

select * from rcbill_my.establishmentphones;
select * from rcbill.rcb_clientphones;
select * from rcbill.clientextendedreport;

use rcbill_my;


drop table if exists rcbill_my.establishmentclients;
create temporary table rcbill_my.establishmentclients as
(
select a.*,b.firm as POSSIBLE_CLIENTNAME, b.kod as POSSIBLE_CLIENTCODE, b.mphone as POSSIBLE_CLIENTPHONE

from 
rcbill_my.establishmentphones a
inner join
rcbill.rcb_clientphones b
on
b.mphone like concat('%', a.ESTPHONE , '%')
where
(a.ESTPHONE <> '')
)
;

select * from rcbill_my.establishmentclients;


SET @rundate='2017-09-11';

select distinct a.*
, c.ActiveContracts, c.TotalContractsWithDevices,c.LastPaymentDate,c.TotalPaymentAmount,c.ReportDate
, d.clientcode, d.contractcode, d.clientname, d.activecount,d.servicecategory, d.servicetype, d.price, d.reported
, e.ClientLocation
from
rcbill_my.establishmentclients a
left join 
rcbill.clientextendedreport c
on 
a.POSSIBLE_CLIENTCODE=c.CL_CLIENTCODE

inner join
rcbill_my.dailyactivenumber d
on
a.POSSIBLE_CLIENTCODE=d.CLIENTCODE

inner join
rcbill.rcb_clientaddress e
on
a.POSSIBLE_CLIENTCODE=e.ClientCode


where a.ESTID in 
(
select ESTID from rcbill_my.establishment where
(ESTROOMS>0 and ESTROOMS <=10)
and
(ESTISLAND='MAHE')
)
and 
d.period in (@rundate)
order by a.estphone, a.estname
;


-- =======================================================================

select distinct a.*
, c.ActiveContracts, c.TotalContractsWithDevices,c.LastPaymentDate,c.TotalPaymentAmount,c.ReportDate
, d.*
-- , d.clientcode, d.contractcode, d.clientname, d.activecount,d.servicecategory, d.servicetype, d.price, d.reported
, e.ClientLocation
from
rcbill_my.establishmentclients a
left join 
rcbill.clientextendedreport c
on 
a.POSSIBLE_CLIENTCODE=c.CL_CLIENTCODE

left join
rcbill_my.clientstats d
on
a.POSSIBLE_CLIENTCODE=d.CLIENTCODE

inner join
rcbill.rcb_clientaddress e
on
a.POSSIBLE_CLIENTCODE=e.ClientCode


where a.ESTID in 
(
select ESTID from rcbill_my.establishment where
(ESTROOMS>0 and ESTROOMS <=10)
and
(ESTISLAND='MAHE')
)
and 
d.period in (@rundate)
order by a.estphone, a.estname
;

-- =======================================================================




select * from rcbill_my.dailyactivenumber where period in (@rundate);

select ESTID from rcbill_my.establishment where
(ESTROOMS> 0 and ESTROOMS <=10)
and
(ESTISLAND='MAHE')
;

