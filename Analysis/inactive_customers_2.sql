select 
reportdate, clientcode, clientname, IsAccountActive, AccountActivityStage
, dayssincelastactive, lastactivedate, firstactivedate
, currentdebt
, clientemail, clientphone
, clientclass, clientaddress, clientarea as island, clientlocation as district, subdistrict
, clientparcel, latitude, longitude
, case when clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`
, clean_connection_type
, TotalPaymentAmount
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018
from rcbill_my.rep_custconsolidated 
where 0=0
and IsAccountActive='InActive' 
and AccountActivityStage not in ('2. Snoozing (1 to 7 days)')
and lastactivedate>='2020-03-31'
and clientarea='PRASLIN'
;