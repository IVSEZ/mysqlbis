select concat('BA_',clientcode,'_',contractcode) as `BillingAccountNumber`
, clientcode, clientname, contractcode, currency, ratingplanname
, count(contractcode)
from 
(
select clientcode, clientname, contractcode, servicecategory, servicecategory2, service,package, network, currentstatus 
, (select currency from rcbill.rcb_contracts where kod=a.contractcode) as currency
, (select name from rcbill.rcb_ratingplans where ID=(select ratingplanid from rcbill.rcb_contracts where kod=a.contractcode)) as RatingPlanName
from rcbill_my.customercontractsnapshot a 
where a.clientcode in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
) a 
-- where a.currentstatus='Active'
group by 2,5,6
;


select 
a.kod
-- , a.*
, b.* 
, b.RatingPlanID AS RatingPlanID
, (select name from rcbill.rcb_ratingplans where ID=b.RatingPlanID) as RatingPlanName
, (select name from rcbill.rcb_creditpolicy where ID=b.creditpolicyid) as CreditPolicy
, (select MaxInvDate from rcbill.rcb_creditpolicy where ID=b.creditpolicyid) as MaxInvDate
, (select MinInvDate from rcbill.rcb_creditpolicy where ID=b.creditpolicyid) as MinInvDate
, c.*
, (select `Value` from rcbill.rcb_contractslastaction where id=b.LastActionID) as LASTACTION
from rcbill.rcb_tclients a 
inner join 
rcbill.rcb_contracts b
on a.ID=b.CLID

inner join rcbill_my.customercontractsnapshot c
on (a.kod=c.clientcode and b.kod=c.contractcode)

-- where a.kod in (select CLIENTCODE from rcbill_my.rep_custextract where ONE_YEAR='ONE YEAR')
where 0=0 
 and a.kod in ('I.000009787','I.000011750','I.000018187')
-- and c.currentstatus='Active'
;


select * from rcbill_my.customercontractsnapshot where clientcode='I.000018187';

select * from rcbill.rcb_contracts where kod='I.000326316';


/*
select kod, clid, currency
, b.RatingPlanID AS RatingPlanID
, (select name from rcbill.rcb_ratingplans where ID=b.RatingPlanID) as RatingPlanName
from rcbill.rcb_contracts b
where b.clid in (721746)
group by 1,2,3,4,5
; 
*/