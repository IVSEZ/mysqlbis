-- select * from rcbill_my.rep_custconsolidated ;


select 
REPORTDATE, CLIENTCODE, CLIENTNAME, ISACCOUNTACTIVE, ACCOUNTACTIVITYSTAGE, ACTIVESERVICES
-- , ACTIVECONTRACTS, ACTIVESUBSCRIPTIONS
, ACTIVENETWORK
, CLEAN_CONNECTION_TYPE AS LASTNETWORK
, DAYSSINCELASTACTIVE, LASTACTIVEDATE, FIRSTACTIVEDATE
, CURRENTDEBT
, CLIENTEMAIL, CLIENTPHONE, CLIENTNIN, CLIENTPASSPORT
, CLIENTCLASS, CLIENTADDRESS, clientarea as ISLAND, clientlocation as DISTRICT, SUBDISTRICT
, CLIENTPARCEL, LATITUDE, LONGITUDE
, case when clientparcel is null then 'Not Present'
		else 'Present' end as `PARCELSTATUS`
, rcbill_my.GetLastPackageFromSnapshot(clientcode, 'INTERNET') as LASTINTERNETPACKAGE
, rcbill_my.GetLastPackageFromSnapshot(clientcode, 'TV') as LASTTVPACKAGE
, FIRSTPAYMENTDATE, LASTPAYMENTDATE, LASTPAIDAMOUNT
, TOTALPAYMENTAMOUNT
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018

from rcbill_my.rep_custconsolidated 
where lastactivedate is not null

;

### saved as AllCustomersReport_20102021-1.csv