use rcbill;

/*
select * 
from rcbill.rcb_tclients
where 
firm like '%retention%';

select * from rcbill.rcb_contracts where clid in (select id 
from rcbill.rcb_tclients
where 
firm like '%retention%'
)
;
*/

-- select * from rcbill_my.dailyactivenumber where period = @rundate;

-- select rcbill_my.GetIsContractActiveOnDate('I37042.1',@rundate); 

-- set @dynalias='IsContractActive'+@rundate;

select distinct
a.clientid,
a.clientcode,

b.firm as ClientName,
b.mphone as ClientPhone, 
b.memail as ClientEmail,
b.passno as PassportNo,
b.Danno as NIN,
b.moladdress as Address,
b.molregistrationaddress as RegistrationAddress,

a.contractid, 
a.contractcode,
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address as ContractAddress,
count(a.period) as daysactive,
max(a.period) as lastactivedate,
@rundate as ReportDate,
rcbill_my.GetIsContractActiveOnDate(a.CONTRACTCODE,@rundate) as IsContractActiveOnReportDate


from 
rcbill_my.dailyactivenumber a 

inner join

rcbill.rcb_tclients b

on a.clientid=b.id

where 
(
b.firm like '%retention%'
)
group by 
a.clientid,
a.clientcode,
a.contractid, 
a.contractcode,
a.activecount,
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address

order by a.clientcode, max(a.period) desc
;

select 
a.id as ClientId, 
a.firm as ClientName, 
a.KOD as ClientCode,
a.passno as PassportNo,
a.Danno as NIN,
a.moladdress as Address,
a.molregistrationaddress as RegistrationAddress

, b.id as ContractId
, b.kod as ContractCode
, b.contracttype as ContractType
, b.address as ContractAddress

,

from 
rcbill.rcb_tclients a
inner join
rcbill.rcb_contracts b 
on a.id=b.clid
where
a.firm like '%retention%';
 