select a.contractcode, a.firstpaymentdate, a.lastpaymentdate
, year(a.lastpaymentdate) as paylyr, month(a.lastpaymentdate) as paylmt, day(a.lastpaymentdate) as payldy 
, year(a.firstpaymentdate) as payfyr, month(a.firstpaymentdate) as payfmt, day(a.firstpaymentdate) as payfdy 
, sum(a.totalpaymentamount) as totalpaymentamount, sum(a.totalpayments) as totalpayments 
from rcbill_my.customers_collection a
where 
-- a.PAYYEAR = year(now())
-- and 
a.clientcode in ('I.000009236')
group by 1,2,3,4,5,6,7,8,9
order by a.lastpaymentdate desc;

/*
select  from rcbill_my.customers_collection a
where 
-- a.PAYYEAR = year(now())
-- and 
a.clientcode in ('I21367')
order by LastPaymentDate desc
;
*/
select a.contractcode
-- , a.LastPaymentDate
, year(a.lastpaymentdate) as paylyr, month(a.lastpaymentdate) as paylmt
-- , a.lastpaymentdate
, sum(a.totalpaymentamount) as totalpaymentamount, sum(a.totalpayments) as totalpayments 
from rcbill_my.customers_collection a
where 
-- a.PAYYEAR = year(now())
-- and 
a.clientcode in ('I.000011750')
group by 1,2,3
order by a.lastpaymentdate desc;



select b.clientcode, b.datestart, b.dateend, b.category, b.traffictype, b.device
, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode, b.traffic_mb
, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

from rcbill_my.dailyusage b 	
where b.clientcode='I.000009236'
order by b.dateend desc
;
select * from rcbill.clientcontractip where CLIENTCODE='I.000009236' order by usagedate desc;


select a.*, b.processedclientip
from 
(
	select b.clientcode, b.datestart, b.dateend, b.category, b.traffictype, b.device
	, (select a.contractcode from rcbill.clientcontractdevices a where a.phoneno=b.device and a.clientcode=b.clientcode) as contractcode
    , b.traffic_mb
	, b.billable_duration_min, b.actual_duration_min, b.price, b.price_vat 

	from rcbill_my.dailyusage b 	
	order by b.dateend desc
) a 
inner join
rcbill.clientcontractip b 
on 
a.clientcode=b.clientcode
and 
a.contractcode=b.contractcode
/*
and
(
	(a.datestart=b.usagedate)
	or
	(a.dateend=b.usagedate)
)
*/
where a.clientcode='I.000009236'
;

select * from rcbill.clientcontractdevices where ClientCode='I.000009236';