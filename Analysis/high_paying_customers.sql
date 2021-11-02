select AccountActivityStage, count(*) from rcbill_my.rep_custconsolidated group by 1; 


select * from rcbill_my.rep_customers_collection 
where ClientClass in ('CORPORATE BULK','CORPORATE','CORPORATE BUNDLE', 'RESIDENTIAL') 
and ClientCode not in ('I.000015720')
and TotalPaymentAmount2021>0
;


select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass
, activenetwork, activeservices, activecontracts, activesubscriptions, clientaddress, clientlocation
, lastactivedate, dayssincelastactive
, lastinvoicedate, lastpaidamount, lastpaymentdate
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018
, clientarea, clientemail, clientnin, clientpassport, clientphone



from rcbill_my.rep_custconsolidated
where ClientClass in ('CORPORATE BULK','CORPORATE','CORPORATE BUNDLE', 'RESIDENTIAL') 
and ClientCode not in ('I.000015720')
and TotalPaymentAmount2021>0
and AccountActivityStage in ('2. Snoozing (1 to 7 days)','1. Alive')
order by AvgMonthlyPayment2021 desc
limit 5000
;

## lowest paying customers
select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass
, activenetwork, activeservices, activecontracts, activesubscriptions, clientaddress, clientlocation
, lastactivedate, dayssincelastactive
, lastinvoicedate, lastpaidamount, lastpaymentdate
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018
, clientarea, clientemail, clientnin, clientpassport, clientphone



from rcbill_my.rep_custconsolidated
where ClientClass in ('CORPORATE BULK','CORPORATE','CORPORATE BUNDLE', 'RESIDENTIAL') 
and ClientCode not in ('I.000015720')
and TotalPaymentAmount2021>0
and AccountActivityStage in ('2. Snoozing (1 to 7 days)','1. Alive')
order by AvgMonthlyPayment2021 asc
limit 5000
;


## residential customers for sales
select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass
, activenetwork, activeservices
, clientarea, clientlocation
, clientaddress
, clientemail, clientnin, clientpassport, clientphone
, activecontracts, activesubscriptions
, lastactivedate, dayssincelastactive
, lastinvoicedate, lastpaidamount, lastpaymentdate
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018



from rcbill_my.rep_custconsolidated
where ClientClass in ('RESIDENTIAL') 
and ClientCode not in ('I.000015720')
and TotalPaymentAmount2021>0
and AccountActivityStage in ('3. Asleep (8 to 30 days)','2. Snoozing (1 to 7 days)','1. Alive')
order by AvgMonthlyPayment2021 desc
-- limit 5000
;

select * from rcbill_my.rep_custconsolidated;