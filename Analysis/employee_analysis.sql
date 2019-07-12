###employees_report_

select a.*, b.*
from 
(
select reportdate, clientcode, IsAccountActive
, AccountActivityStage, clientname, activenetwork, activeservices
, activecontracts, activesubscriptions, clientaddress
, lastpaidamount, lastpaymentdate, totalpaymentamount, totalpayments

, `201901`, `201902`, `201903`, `201904`, `201905`, `201906`, `201907`, `201908`, `201909`, `201910`, `201911`, `201912`, TotalPayments2019, TotalPaymentAmount2019, AvgMonthlyPayment2019
, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018, AvgMonthlyPayment2018
, clientnin, clientpassport, clientphone
, contractinfo, packageinfo

from rcbill_my.rep_custconsolidated 
where clientclass='EMPLOYEE' and AccountActivityStage<>'5. Dormant (more than 90 days)'

) a 
left join
(
select clientcode as b_clientcode, services, ActiveCount, contractcount, region, network
, `10GB`, `20GB`, `40GB`, `Amber`, `Amber Corporate`, `Basic`, `Business Unlimited-1`, `Business Unlimited-2`
, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
, `Crimson`, `Crimson Corporate`, `Dedicated Custom`, `Dedicated Plus`, `DualView`, `MultiView`
, `VOD`, `IGO`, `Mobile Indian`, `Elite`, `Executive`, `Extravagance`, `Extravagance Corporate`
, `Extreme`, `Extreme Plus`, `French`, `Hotels/Channels`, `Hotels/Decoder`, `Indian`, `Indian Corporate`
, `Intel Data 10`, `Intel Voice 10`, `Intel Voice 20`, `Intelenovela`, `PBX`, `Performance`, `Performance Plus`
, `Prepaid`, `Prepaid Data`, `Prestige`, `Starter`, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
, `Value`, `Voice Plus`, `VPN`
from rcbill_my.clientstats
) b 
on a.clientcode=b.b_clientcode
order by a.clientname
;


###employees_contractdiscount_

select a.clientcode, a.clientname, a.contractcode, a.package, a.packagetype, a.currentstatus, a.price, a.network
-- , a.service, b.servicename, b.serviceid
, b.percent, b.amount
from 
(
select clientcode,clientname, contractcode, service, package, packagetype, currentstatus, price, network 
from rcbill_my.customercontractsnapshot where clienttype='Employee' and CurrentStatus='Active'
) a 
left join
(
select clientcode, contractcode, servicename, serviceid, percent, amount from rcbill.clientcontractdiscounts
) b 
on a.clientcode=b.clientcode
and a.contractcode=b.contractcode
and upper(a.service)=upper(b.servicename)
order by a.clientname, a.contractcode
;


/*

select a.*, b.*
from 
(
	select a.*, b.*
	from 
	(
	select reportdate, clientcode, IsAccountActive
	, AccountActivityStage, clientname, activenetwork, activeservices
	, activecontracts, activesubscriptions, clientaddress
	, lastpaidamount, lastpaymentdate, totalpaymentamount, totalpayments

	, `201901`, `201902`, `201903`, `201904`, `201905`, `201906`, `201907`, `201908`, `201909`, `201910`, `201911`, `201912`, TotalPayments2019, TotalPaymentAmount2019, AvgMonthlyPayment2019
	, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018, AvgMonthlyPayment2018
	, clientnin, clientpassport, clientphone
	, contractinfo, packageinfo

	from rcbill_my.rep_custconsolidated 
	where clientclass='EMPLOYEE' and AccountActivityStage<>'5. Dormant (more than 90 days)'
	) a 
	left join
	(
	select clientcode as b_clientcode, services, ActiveCount, contractcount, region, network
	, `10GB`, `20GB`, `40GB`, `Amber`, `Amber Corporate`, `Basic`, `Business Unlimited-1`, `Business Unlimited-2`
	, `Business Unlimited-6`, `Business Unlimited-8`, `Business Unlimited-8-daytime`
	, `Crimson`, `Crimson Corporate`, `Dedicated Custom`, `Dedicated Plus`, `DualView`, `MultiView`
	, `VOD`, `IGO`, `Mobile Indian`, `Elite`, `Executive`, `Extravagance`, `Extravagance Corporate`
	, `Extreme`, `Extreme Plus`, `French`, `Hotels/Channels`, `Hotels/Decoder`, `Indian`, `Indian Corporate`
	, `Intel Data 10`, `Intel Voice 10`, `Intel Voice 20`, `Intelenovela`, `PBX`, `Performance`, `Performance Plus`
	, `Prepaid`, `Prepaid Data`, `Prestige`, `Starter`, `Turquoise High Tide`, `Turquoise Low Tide`, `TurquoiseTV`
	, `Value`, `Voice Plus`, `VPN`
	from rcbill_my.clientstats
	) b 
	on a.clientcode=b.b_clientcode
) a 
left join 
(
	select a.clientcode, a.clientname, a.contractcode, a.package, a.packagetype, a.currentstatus, a.price, a.network
	-- , a.service, b.servicename, b.serviceid
	, b.percent, b.amount
	from 
	(
	select clientcode,clientname, contractcode, service, package, packagetype, currentstatus, price, network from rcbill_my.customercontractsnapshot where clienttype='Employee' and CurrentStatus='Active'
	) a 
	left join
	(
	select clientcode, contractcode, servicename, serviceid, percent, amount from rcbill.clientcontractdiscounts
	) b 
	on a.clientcode=b.clientcode
	and a.contractcode=b.contractcode
	and upper(a.service)=upper(b.servicename)

) b

on a.clientcode=b.clientcode
;




select distinct clientnin from rcbill_my.rep_custconsolidated where clientclass='EMPLOYEE' and AccountActivityStage<>'5. Dormant (more than 90 days)';


select count(*) as contractdiscounts from rcbill.rcb_contractdiscounts;
select count(*) as clientcontractdiscounts from rcbill.clientcontractdiscounts;
select count(*) as clientcontractlastdiscount from rcbill.clientcontractlastdiscount;

select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;

*/

