#SET DATE
SET @REPORTDATE=str_to_date('2017-11-13','%Y-%m-%d');
SET @rundate='2017-11-13';

use rcbill_my;

/*
select period, periodday, periodmth, periodyear,clientcode,clientname,clientclass, servicecategory, servicecategory2, package from rcbill_my.customercontractactivity 
where 
reported='Y' and
clientclass in ('Corporate Bundle','Corporate Bulk')
and period='2017-08-01';
-- and period>='2017-08-01' and period<='2017-08-31';
*/
select distinct clientclass from rcbill_my.clientstats;

## GET BULK BUNDLE CUSTOMERS
select * from rcbill_my.clientstats where 
(
clientclass in ('Corporate Bulk','Corporate Bundle','Corporate')
or
 `Extravagance Corporate` >0
or
 `Crimson Corporate` >0 
 or
 `Amber Corporate` >0 
 or
 `Indian Corporate` >0 
or clientname like '%staff%'
)    
and clientclass not in ('Employee') and clientclass not in ('Intelvision Office')
;

select a.*,b.services,b.Intelenovela from rcbill_my.customercontractactivity a 
inner join 
rcbill_my.clientstats b
on 
a.clientcode=b.clientcode
where a.clientcode in 
(
	select clientcode from rcbill_my.clientstats where 
    (
	clientclass in ('Corporate Bulk','Corporate Bundle')
	or
	 `Extravagance Corporate` >0
	or
	 `Crimson Corporate` >0 
	or clientname like '%staff%'
    )
--     and clientclass not in ('Employee')
)
and a.period=@rundate;


######################################################

## GET BULK BUNDLE CUSTOMERS
select * from rcbill_my.clientstats where 
(
	(
	clientclass in ('Corporate Bulk','Corporate Bundle','Corporate')
	or clientname like '%staff%'
	)
	and
	(`Extravagance Corporate` >1 or `Extravagance` >1)

)    
and clientclass not in ('Employee','Intelvision Office')
;


select 
*
from rcbill_my.clientstats where 
(
	(
	clientclass in ('Corporate Bulk','Corporate Bundle','Corporate')
	or clientname like '%staff%'
	)
	-- and
	-- (`Extravagance Corporate` >1 or `Extravagance` >1)

)    
and clientclass not in ('Employee','Intelvision Office')
;


#############################################################

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
where clientcode in 
(

	select clientcode from rcbill_my.clientstats where 
	(
		(
		clientclass in ('Corporate Bulk','Corporate Bundle','Corporate')
		or clientname like '%staff%'
		)
		and
		(`Extravagance Corporate` >1 or `Extravagance` >1)

	)    
	and clientclass not in ('Employee') and clientclass not in ('Intelvision Office')


)
;