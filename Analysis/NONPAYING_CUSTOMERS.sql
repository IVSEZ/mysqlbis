select * from rcbill_my.rep_custconsolidated where (`201911`=0 or `201911` is null) and (`201910`=0 or `201910` is null) and (TotalPaymentAmount2019=0 or TotalPaymentAmount2019 is null)and dayssincelastactive<=65;

select * from rcbill_my.rep_customers_collection2019;


select * from rcbill.clientcontractdiscounts where 0=0;
select * from rcbill.clientcontractlastdiscount where 0=0;
select * from rcbill_my.customercontractsnapshot where 0=0;




select distinct clientcode from rcbill.clientcontractdiscounts where 0=0;
select distinct b_clientcode from rcbill.clientcontractlastdiscount where 0=0;


select a.clientcode, c.clientname
, c.IsAccountActive, c.AccountActivityStage
, a.CONTRACTCODE, a.servicename, a.percent, a.amount, a.upddate, a.approvalreason
, b.clientclass, b.clienttype, b.servicecategory, b.servicecategory2, b.package, b.network, b.region, b.firstcontractdate, b.lastcontractdate, b.DurationForContract, b.ActiveDaysForContract, b.CurrentStatus, b.InActiveDaysForContract, b.price
from 
rcbill.clientcontractdiscounts a 
left join 
rcbill_my.customercontractsnapshot b 
on a.clientcode=b.clientcode and a.CONTRACTCODE=b.contractcode and upper(a.servicename)=upper(b.service)

left join 
rcbill_my.rep_custconsolidated c 
on a.CLIENTCODE=c.clientcode
;
/*
set @clientcode='I.000020568';
select * from rcbill.clientcontractdiscounts where 0=0 and clientcode=@clientcode; -- where clientid=723711 order by clientcode, contractcode, upddate;
select * from rcbill.clientcontractlastdiscount where 0=0 and b_clientcode=@clientcode;
select * from rcbill_my.customercontractsnapshot where 0=0 and clientcode=@clientcode;

*/