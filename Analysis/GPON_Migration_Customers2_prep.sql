
set @clientcode='I.000000348';


select * from rcbill_my.customercontractsnapshot where clientcode=@clientcode;
	select clientcode, servicecategory, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
    where CLIENTCODE=@clientcode
	group by 1,2
	order by 1, 3
    ;

    select clientcode, network, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
    where CLIENTCODE=@clientcode
	group by 1,2
	order by 1, 3
    ;

select a.*,
b.currentstatus
from 
(
	select clientcode, servicecategory, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
	group by 1,2
	order by 1, 3
) a 
left join
rcbill_my.customercontractsnapshot b 
on 0=0
and a.clientcode=b.clientcode
and a.servicecategory=b.servicecategory
and a.lastcontractdate=b.lastcontractdate

where a.CLIENTCODE=@clientcode

;
    
    
select a.*,
b.currentstatus
from 
(
    select clientcode, network, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
	group by 1,2
	order by 1, 3
) a 
left join
rcbill_my.customercontractsnapshot b 
on 0=0
and a.clientcode=b.clientcode
and a.network=b.network
and a.lastcontractdate=b.lastcontractdate

where a.CLIENTCODE=@clientcode


;


select a.*,
b.currentstatus
from 
(
    select clientcode, network, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
	group by 1,2
	order by 1, 3
) a 
left join
rcbill_my.customercontractsnapshot b 
on 0=0
and a.clientcode=b.clientcode
and a.network=b.network
and a.lastcontractdate=b.lastcontractdate

where a.CLIENTCODE=@clientcode

group by 1,2,3,4,5
;