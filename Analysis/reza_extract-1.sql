select * from rcbill_my.clientstats where `Business Unlimited-1`>0;

select * from rcbill_my.clientstats where `Business Unlimited-2`>0;

select * from rcbill_my.clientstats where `Business Unlimited-6`>0;

select * from rcbill_my.clientstats where `Business Unlimited-8`>0;

select * from rcbill_my.clientstats where `Business Unlimited-8-daytime`>0;

select period, clientcode, clientname, clientclass, clienttype, services, activecount, contractcount, region, network
, `Business Unlimited-1`, `Business Unlimited-2`
, `Business Unlimited-6`, `Business Unlimited-8`
, `Business Unlimited-8-daytime`
from rcbill_my.clientstats
where 
(
`Business Unlimited-1`>0
or
`Business Unlimited-2`>0
or
`Business Unlimited-6`>0
or
`Business Unlimited-8`>0
or
`Business Unlimited-8-daytime`>0
)
order by 
`Business Unlimited-1` desc
, `Business Unlimited-2` desc
, `Business Unlimited-6` desc
, `Business Unlimited-8` desc
, `Business Unlimited-8-daytime` desc
;


select 
-- * 
-- , 
reportdate, clientcode, clientname, currentdebt, clientclass, IsAccountActive, AccountActivityStage, activenetwork
, activeservices, activecontracts, activesubscriptions, clientlocation, firstactivedate, lastactivedate, dayssincelastactive, firstcontractdate
, totalpaymentamount, TotalPaymentAmount2020, AvgMonthlyPayment2020, TotalPaymentAmount2019,AvgMonthlyPayment2019, TotalPaymentAmount2018, AvgMonthlyPayment2018
, clientarea, clientemail, clientphone
, packageinfo
from rcbill_my.rep_custconsolidated
where 
dayssincelastactive is not null 
and IsAccountActive in ('InActive')
and packageinfo like '%Extravagance%'
and AccountActivityStage in ('2. Snoozing (1 to 7 days)','3. Asleep (8 to 30 days)')
;

select * from rcbill_my.matched_clients;