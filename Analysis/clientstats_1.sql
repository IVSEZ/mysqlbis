select * from rcbill_my.clientstats 
where
(
`Amber`>0
or
`Amber Corporate`>0
)
and
(
`Extravagance`>0
or
`Extravagance Corporate`>0
) 
and
clienttype	
not in 
	(
		'Intelvision Office',
        'Employee'
    )
;

select * from rcbill_my.clientstats 
where
(
`Crimson`>0
or
`Crimson Corporate`>0
)
and
(
`Extravagance`>0
or
`Extravagance Corporate`>0
) 
and
clienttype	
not in 
	(
		'Intelvision Office',
        'Employee'
    )
;


select a.*, b.* 
from 
rcbill_my.clientstats a
left join
rcbill.clientextendedreport b
on a.clientcode=b.cl_clientcode
where
(
a.`DualView`>0
or
a.`MultiView`>0
)
and 
(
a.clienttype	
not in 
	(
		'Intelvision Office',
        'Employee'
    )
)
;


select a.*, b.* 
from 
rcbill_my.clientstats a
left join
rcbill.clientextendedreport b
on a.clientcode=b.cl_clientcode
where
(
a.`Turquoise Low Tide`>0
or
a.`Turquoise High Tide`>0
)
and 
(
a.clienttype	
not in 
	(
		'Intelvision Office',
        'Employee'
    )
)
;




select a.*, b.* 
from 
rcbill_my.clientstats a
left join
rcbill.clientextendedreport b
on a.clientcode=b.cl_clientcode
where
(
a.clientclass	
in 
	(
		'Corporate Bulk',
        'Corporate Bundle'
    )
)
;

select distinct clientclass from rcbill_my.clientstats;

select * from rcbill_my.rep_housingestates where HOUSING_ESTATE in ('EDEN ISLAND');

select * from rcbill_my.customers_collection where clientcode in (select client_code from rcbill_my.rep_housingestates where HOUSING_ESTATE in ('EDEN ISLAND'));


select clientcode, sum(TotalPaymentAmount) as TotalPaymentAmount
, avg(TotalPaymentAmount) as AveragePayment
, (sum(TotalPaymentAmount)/sum(TotalPayments)) as AmountPerPayment
, sum(TotalPayments) as TotalPayments, count(*) as CountOfPayments
, min(FirstPaymentDate) as FirstPaymentDate 
, max(LastPaymentDate) as LastPaymentDate 
from rcbill_my.customers_collection 
where clientcode in (select client_code from rcbill_my.rep_housingestates where HOUSING_ESTATE in ('EDEN ISLAND'))
and year(LastPaymentDate)=2018
group by clientcode
order by 8 desc
;


select a.*, b.*
from 
rcbill_my.rep_housingestates a 
left join
rcbill_my.customers_collection_pivot2018 b
on 
a.CLIENT_CODE=b.clientcode
where a.HOUSING_ESTATE in ('EDEN ISLAND')
;


