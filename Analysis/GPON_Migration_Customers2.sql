select * from rcbill_my.customercontractsnapshot where clientcode='I14834';


select * from rcbill_my.customercontractsnapshot where servicecategory='OTT' and firstcontractdate>='2021-08-01';

select clientcode, clientname, network, min(firstcontractdate)
from rcbill_my.customercontractsnapshot
group by 1,2,3
order by 1, 4
;



#### first contract date for each network
select clientcode, network, min(firstcontractdate), max(lastcontractdate)
from rcbill_my.customercontractsnapshot
group by 1,2
order by 1, 3
;


#### first contract date for each servicecategory
select clientcode, servicecategory, min(firstcontractdate), max(lastcontractdate)
from rcbill_my.customercontractsnapshot
group by 1,2
order by 1, 3
;