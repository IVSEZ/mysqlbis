select distinct clientcode from rcbill_my.customercontractactivity where upper(package) like '%PRESTIGE%';

select 
-- a.*
a.reportdate
, a.clientcode
, a.currentdebt
, a.isaccountactive
, a.accountactivitystage
, a.clientname
, a.clientclass
, a.activenetwork
, a.activeservices
, a.activecontracts
, a.activesubscriptions
, a.clientlocation
, a.clientphone
, a.clientaddress


,b.contractpackage
from 
rcbill_my.rep_custconsolidated a 
left join
-- rcbill_my.customercontractsnapshot b
(
	select clientcode, group_concat( distinct package order by contractcode asc separator '|') as contractpackage
	from rcbill_my.customercontractsnapshot
	where servicecategory='TV'
	and CurrentStatus='Active'
	group by clientcode
) b
on
a.clientcode=b.clientcode
where a.clientcode in 
(
	select distinct clientcode from rcbill_my.customercontractactivity where upper(package) like '%PRESTIGE%'
)

;