/*
set @rundate = (select max(month_all_date) from rcbill_my.month_all_date);

	select a.period, a.clientname, a.clientcode, a.clientclass, a.clienttype, a.region, a.service
	, a.network, a.package, a.servicecategory
	,a.contractcode
	, count(distinct a.period) as ServiceCount
    -- , sum(distinct a.ACTIVECOUNT) as ActiveCount
    , sum(a.ACTIVECOUNT) as ActiveCount
	from rcbill_my.customercontractactivity a
	where a.period=@rundate and a.reported='Y'
	group by 1,2,3,4,5,6,7,8,9,10,11
	order by a.clientname
    ;
    
    
select * from rcbill_my.rep_anreport_all;

select * from rcbill_my.rep_anreport_i;
*/

select  
reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork, activeservices
, activecontracts, activesubscriptions, clientaddress
, clientarea, clientlocation
, subdistrict, clientparcel, coord_x, coord_y, latitude, longitude, clientemail, clientnin, clientpassport, clientphone
, firstactivedate, lastactivedate, dayssincelastactive, firstcontractdate, firstinvoicedate, firstpaymentdate, lastinvoicedate, lastpaidamount, lastpaymentdate, totalpayments, totalpaymentamount
, TotalPayments2021, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPayments2020, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPayments2019, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPayments2018, TotalPaymentAmount2018, AvgMonthlyPayment2018

from rcbill_my.rep_custconsolidated where clientcode in 
( select clientcode from rcbill_my.clientstats where vod>0)
and clientclass not in ('INTELVISION OFFICE','EMPLOYEE','VIP','CORPORATE LARGE')
and activeservices in ('TV & OTT','TV & Voice & OTT','Internet & OTT')
;    


select clientclass, activeservices, count(clientcode) from rcbill_my.rep_custconsolidated where clientcode in 
( select clientcode from rcbill_my.clientstats where vod>0)
-- and clientclass not in ('INTELVISION OFFICE','EMPLOYEE','VIP')
group by 1,2
; 