select distinct
count(a.period) as daysactive,
max(a.period) as lastactivedate,
a.clientid,
a.clientcode,
a.clientclass, a.clienttype,
b.firm as ClientName,
b.mphone as ClientPhone, 
b.memail as ClientEmail,
b.passno as PassportNo,
b.Danno as NIN,
b.moladdress as Address,
b.molregistrationaddress as RegistrationAddress,
count(distinct a.contractcode) as ContractCount,
@rundate as ReportDate,
now() as InsertedOn
/*
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address as ContractAddress,

count(a.period) as daysactive,
max(a.period) as lastactivedate,
@rundate as ReportDate,
now() as InsertedOn,

rcbill_my.GetIsContractActiveOnDate(a.CONTRACTCODE,@rundate) as IsContractActiveOnReportDate
*/

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
a.clientclass, a.clienttype,
b.firm ,
b.mphone, 
b.memail,
b.passno ,
b.Danno ,
b.moladdress,
b.molregistrationaddress 
/*
a.contractid, 
a.contractcode,
a.activecount,
a.devicescount,
a.servicecategory,
a.servicesubcategory,
a.servicetype,
a.region,
a.address
*/
order by max(a.period) asc
;