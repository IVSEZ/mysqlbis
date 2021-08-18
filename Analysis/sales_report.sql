-- select * from rcbill_my.customercontractsnapshot where clientcode='I21461';

## SALES REPORTS
select * from rcbill_my.sales order by orderday desc;

select distinct salestype, count(*) from rcbill_my.sales group by salestype;
select distinct orderstatus, count(*) from rcbill_my.sales group by orderstatus;
select distinct orderstatus, state, count(*) from rcbill_my.sales group by orderstatus, state;


SELECT orderday, weekday, orderdate, orderid, salescenter, createdby, region, ordertype, salestype, state, orderstatus
, clientcode, clientclass, contractcode, contracttype, service, servicetype, cost, price, num, originalcontract, originalservice, originalservicetype
-- , originalprice
, cleanorigcost as origcost, cleanorigprice as origprice
from rcbill_my.sales
where year(orderday)>2018
order by orderdate desc;


select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;

/*
select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, ordercount from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='New Sales' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, `Mahe`, `Praslin`, `Unknown` from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='New Sales' order by orderday desc;

-- select * from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday, ordercount from rcbill_my.rep_dailysales where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='Renewals' order by orderday desc;
select year(orderday) as ordersyear, month(orderday) as ordersmonth, day(orderday) as ordersday,weekday,monthname(orderday) as monthname, `Mahe`, `Praslin`, `Unknown` from rcbill_my.rep_dailysalesreg where salescenter='Sales' and salestype='Renewals' order by orderday desc;
*/
#######################################

select clientcode, month(orderdate) as order_month, year(orderdate) as order_year, orderday
, salestype , region , orderstatus, weekday, ordermonth
, count(contractcode) as contracts

from rcbill_my.sales
where 
length(clientcode)>0 
and 
salestype='New Sales'
and 
orderstatus='Processed'
group by 1, 2, 3, 4, 5, 6, 7, 8, 9
;


set @orderyear=2017;
set @orderyear=2018;
set @orderyear=2019;

set @orderyear=2021;

select a.*
-- , b.*
, b.clientname, b.currentdebt, b.IsAccountActive, b.AccountActivityStage, b.clientclass, b.activenetwork, b.activeservices
, b.clientaddress, b.clientlocation, b.clean_mxk_name, b.clean_mxk_interface, b.clean_hfc_nodename, b.clean_hfc_node
, b.firstactivedate, b.lastactivedate, b.dayssincelastactive, b.TotalPaymentAmount2019, b.AvgMonthlyPayment2019, b.TotalPaymentAmount2018, b.AvgMonthlyPayment2018 
, b.clientarea, b.clientemail
from 
(
	select clientcode, month(orderdate) as order_month, year(orderdate) as order_year, orderday
	, salestype , region , orderstatus, weekday, ordermonth
	, count(contractcode) as contracts

	from rcbill_my.sales
	where 
	length(clientcode)>0 
	and 
	salestype='New Sales'
	and 
	orderstatus='Processed'
	group by 1, 2, 3, 4, 5, 6, 7, 8, 9
) a 
left join 
rcbill_my.rep_custconsolidated b
on 
a.clientcode=b.clientcode
;


