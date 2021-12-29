/*
select * from rcbill_my.customercontractsnapshot where clientcode='I14834';
select * from rcbill_my.customercontractsnapshot where clientcode='I21945';
select * from rcbill_my.customercontractsnapshot where clientcode='I.000000071';


select * from rcbill_my.customercontractsnapshot where servicecategory='OTT' and firstcontractdate>='2021-08-01';

select clientcode, clientname, network, min(firstcontractdate)
from rcbill_my.customercontractsnapshot
group by 1,2,3
order by 1, 4
;
*/


#### first contract date for each network
select a.*
, b.clientname, b.IsAccountActive as AccountStatus, b.AccountActivityStage
, b.dayssincelastactive, b.lastactivedate, b.firstactivedate
, b.currentdebt
, b.clientemail, b.clientphone
, b.clientclass, b.clientaddress, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, longitude
, case when clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`
, b.clean_connection_type
, b.TotalPaymentAmount
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018

from 
(
	/*
	select clientcode, network, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
	group by 1,2
	order by 1, 3
    */
    
	select a.*,
	b.currentstatus as ServiceStatus
	from 
	(
		select clientcode, network, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
		from rcbill_my.customercontractsnapshot
		group by 1,2
		-- order by 1, 3
	) a 
	left join
	rcbill_my.customercontractsnapshot b 
	on 0=0
	and a.clientcode=b.clientcode
	and a.network=b.network
	and a.lastcontractdate=b.lastcontractdate    
    
    group by 1,2,3,4,5
    
    
) a
left join 
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode
;


#### first contract date for each servicecategory

select a.*
, b.clientname, b.IsAccountActive as AccountStatus, b.AccountActivityStage
, b.dayssincelastactive, b.lastactivedate, b.firstactivedate
, b.currentdebt
, b.clientemail, b.clientphone
, b.clientclass, b.clientaddress, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, longitude
, case when clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`
, b.clean_connection_type
, b.TotalPaymentAmount
, b.TotalPaymentAmount2021, b.AvgMonthlyPayment2021
, b.TotalPaymentAmount2020, b.AvgMonthlyPayment2020
, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019
, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018
from 
(
	/*

	select clientcode, servicecategory, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
	from rcbill_my.customercontractsnapshot
	group by 1,2
	order by 1, 3
    */
    
	select a.*,
	b.currentstatus as ServiceStatus
	from 
	(
		select clientcode, servicecategory, min(firstcontractdate) as firstcontractdate, max(lastcontractdate) as lastcontractdate
		from rcbill_my.customercontractsnapshot
		group by 1,2
		-- order by 1, 3
	) a 
	left join
	rcbill_my.customercontractsnapshot b 
	on 0=0
	and a.clientcode=b.clientcode
	and a.servicecategory=b.servicecategory
	and a.lastcontractdate=b.lastcontractdate 
    
    group by 1,2,3,4,5
    
) a 
left join 
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode

;



