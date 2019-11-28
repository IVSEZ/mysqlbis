/*
select * from rcbill_my.customercontractsnapshot where clientcode='I.000018355';


select * from rcbill_my.clientstats;

select services, count(distinct clientcode), sum(contractcount) from rcbill_my.clientstats
where clientclass in ('Residential','Corporate Bundle','Corporate Bulk') 

group by services

;

select clientclass,  from rcbill_my.rep_custconsolidated where clientcode in 
(
select * from rcbill_my.clientstats where `VOD`>0
)
;
*/

#OPTION 1

select 
reportdate, clientcode, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork
-- , activeservices, activecontracts, activesubscriptions, clientaddress
, clientlocation
-- , clean_connection_type
, clean_mxk_name
-- , clean_mxk_interface, clean_hfc_node
, clean_hfc_nodename, hfc_district, hfc_subdistrict, firstactivedate, lastactivedate, dayssincelastactive
-- , firstcontractdate, firstinvoicedate, firstpaymentdate, lastinvoicedate
, lastpaidamount, lastpaymentdate, totalpayments, totalpaymentamount
, `201901`, `201902`, `201903`, `201904`, `201905`, `201906`, `201907`, `201908`, `201909`, `201910`, `201911`, `201912`, TotalPayments2019, TotalPaymentAmount2019, AvgMonthlyPayment2019
, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018, AvgMonthlyPayment2018
, clientarea, clientemail
-- , clientnin, clientpassport
, clientphone
-- , combined_clientcode, cl_clientcode, bc_clientcode, connection_type, mxk_name, mxk_interface, hfc_node, nodename, contractinfo, packageinfo
from rcbill_my.rep_custconsolidated where clientclass in ('Residential','Corporate Bundle','Corporate Bulk') ;


select * from rcbill_my.customers_cmts_mxk_cont_coll;

select * from rcbill_my.customers_collection;



#OPTION 2


select a.*, b.*
from 
(
	select 
	reportdate, clientcode, IsAccountActive, AccountActivityStage, clientname, clientclass, activenetwork
	-- , activeservices, activecontracts, activesubscriptions, clientaddress
	, clientlocation
	-- , clean_connection_type
	, clean_mxk_name
	-- , clean_mxk_interface, clean_hfc_node
	, clean_hfc_nodename, hfc_district, hfc_subdistrict, firstactivedate, lastactivedate, dayssincelastactive
	-- , firstcontractdate, firstinvoicedate, firstpaymentdate, lastinvoicedate
	-- , lastpaidamount, lastpaymentdate, totalpayments, totalpaymentamount
	-- , `201901`, `201902`, `201903`, `201904`, `201905`, `201906`, `201907`, `201908`, `201909`, `201910`, `201911`, `201912`, TotalPayments2019, TotalPaymentAmount2019, AvgMonthlyPayment2019
	-- , `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018, AvgMonthlyPayment2018
	, clientarea, clientemail
	-- , clientnin, clientpassport
	, clientphone
	-- , combined_clientcode, cl_clientcode, bc_clientcode, connection_type, mxk_name, mxk_interface, hfc_node, nodename, contractinfo, packageinfo
	from rcbill_my.rep_custconsolidated where clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
    and 
	clientcode not in ('I.000004181','I.000007264','I.000015720','I.000004181','0010')
/*
Dont include these customer accounts
I.000004181 - Prepaid Sales
I.000007264 - 2013 Prepaid Card Sales
I.000015720 - HIKVISION
I.000004181 - Prepaid Card Sales
0010 - Online Prepaid Cards

*/

) a 
-- left join
inner join
(

/*
-- cannot use this as it messes up the average payment amounts
 select clientcode, paymonth, payyear, totalpaymentamount
 from  rcbill_my.customers_collection where PAYYEAR>2016
*/

select a.*,
case 
when a.TotalPaymentAmount > 0 and a.TotalPaymentAmount <=500 then 'Bucket 01: 0 to 500'
when a.TotalPaymentAmount > 500 and a.TotalPaymentAmount <=1000 then 'Bucket 02: 501 to 1000'
when a.TotalPaymentAmount > 1000 and a.TotalPaymentAmount <=1500 then 'Bucket 03: 1001 to 1500'
when a.TotalPaymentAmount > 1500 and a.TotalPaymentAmount <=2000 then 'Bucket 04: 1501 to 2000'
when a.TotalPaymentAmount > 2000 and a.TotalPaymentAmount <=2500 then 'Bucket 05: 2001 to 2500'
when a.TotalPaymentAmount > 2500 and a.TotalPaymentAmount <=3000 then 'Bucket 06: 2501 to 3000'
when a.TotalPaymentAmount > 3000 and a.TotalPaymentAmount <=5000 then 'Bucket 07: 3001 to 5000'
when a.TotalPaymentAmount > 5000 and a.TotalPaymentAmount <=10000 then 'Bucket 08: 5001 to 10000'
when a.TotalPaymentAmount > 10000 and a.TotalPaymentAmount <=15000 then 'Bucket 09: 10001 to 15000'
when a.TotalPaymentAmount > 15000 and a.TotalPaymentAmount <=20000 then 'Bucket 10: 15001 to 20000'
when a.TotalPaymentAmount > 20000 then 'Bucket 11: 20001 and higher'
else 'Bucket 0: Nothing' end as `SPEND_BUCKET`
from 
(

 select clientcode, paymonth, payyear, sum(totalpaymentamount) as totalpaymentamount, count(*) as totalpayments
 from  rcbill_my.customers_collection where PAYYEAR>2016
 group by 1,2,3
) a 

) b
on 
a.clientcode=b.clientcode
;

 select clientcode, paymonth, payyear, totalpaymentamount
 from  rcbill_my.customers_collection where PAYYEAR>2016
;

 select clientcode, paymonth, payyear, sum(totalpaymentamount) as totalpaymentamount, count(*) as totalpayments
 from  rcbill_my.customers_collection where PAYYEAR>2016
 group by 1,2,3
 ;