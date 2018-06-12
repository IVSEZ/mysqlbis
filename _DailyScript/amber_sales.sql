  
-- TO AMBER
select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;

-- FROM AMBER
select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;





select distinct a.cl_clientcode, a.cl_clientname, a.cl_clclassname, a.con_contractcode,a.CON_STARTDATE, a.CON_ENDDATE, a.s_servicename, a.vpnr_servicetype, a.vpnr_serviceprice,a.contractcurrentstatus from 
rcbill.clientcontracts a
inner join 
(
select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE='AMBER' and cl_clclassname not in ('INTELVISION OFFICE')
) b 
on 
a.con_contractcode=b.con_contractcode
and 
a.s_servicename=b.s_servicename
and 
a.vpnr_servicetype=b.vpnr_servicetype
order by CL_CLIENTNAME
;

/*
select clientcode, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Amber')

and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
group by clientcode
order by clientcode
;
*/
-- AMBER TO CRIMSON CONVERSION
select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Amber')
and servicetype in ('Crimson')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
-- group by clientcode
order by clientcode
;



-- AMBER SALES
select  *
from rcbill_my.salestoactive 
where o_servicetype='Amber'
-- where 
and o_clientclass not in ('Employee','Intelvision Office')
and o_saleschannel in ('Sales')
-- and 
-- firstactivedateforcontract is not null
-- group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;
-- ======================================================

/*

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Amber')
-- and clientclass in ('corporate','Corporate Large','USD_standard')
;


select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Amber')
-- and clientclass in ('corporate','Corporate Large','USD_standard')
;

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
;

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;


select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;




select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
;




select  o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package,  count(*) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where o_servicetype='Amber'
-- where 
and o_clientclass not in ('Employee','Intelvision Office')
and o_saleschannel in ('Sales')
-- and 
-- firstactivedateforcontract is not null
group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;






select  *
from rcbill_my.salestoactive 
where o_contractcode in (

select contract from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
)
;

select  *
from rcbill_my.salestoactive 
where o_servicetype='DualView'
-- where 
and o_clientclass not in ('Employee','Intelvision Office')
and o_saleschannel in ('Sales')
-- and 
-- firstactivedateforcontract is not null
-- group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;


select * from rcbill_my.sales where 
-- ordermonth='January' and 
-- salestype='Renewals' 
-- and 
state in ('Completed','Open')
and servicetype in ('DualView')
and clientclass not in ('Employee','Intelvision Office')
order by servicetype
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;



select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
order by servicetype
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;


select -- CLIENTCLASS, 
ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
group by 
-- CLIENTCLASS, 
ORIGINALSERVICETYPE, servicetype
-- with rollup
;

select -- CLIENTCLASS, 
ORIGINALSERVICETYPE, servicetype, sum(originalprice) as origprice, sum(price) as newprice, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Amber')
and clientclass not in ('Employee','Intelvision Office')
group by 
-- CLIENTCLASS, 
ORIGINALSERVICETYPE, servicetype
-- with rollup
;


select * from rcbill_my.dailysales where date(insertedon)='2018-02-04' order by orderdate;

select * from rcbill_my.dailysinglesales where date(insertedon)='2018-02-04' order by entrydate;

select * from rcbill_my.dailyaddonsales where date(insertedon)='2018-02-04' order by salesid;

select * from rcbill_my.onlinepayments  where date(insertedon)='2018-02-04' order by paymentid;


select * from rcbill_my.sales where insertedon>'2018-02-04 11:02' and INSERTEDON<'2018-02-05 00:00';
select * from rcbill_my.onlinepayments  where insertedon>'2018-02-04 11:02' and INSERTEDON<'2018-02-05 00:00';

set SQL_SAFE_UPDATES=0;
delete from rcbill_my.dailysales where date(insertedon)='2018-02-05';
delete from rcbill_my.dailysinglesales where date(insertedon)='2018-02-05';
delete from rcbill_my.dailyaddonsales where date(insertedon)='2018-02-05';
delete from rcbill_my.onlinepayments  where date(insertedon)='2018-02-05';



select * from rcbill_my.dailysales where date(orderdate)='2018-02-02' order by orderdate;
select * from rcbill_my.dailysales where date(orderdate)='2018-02-03' order by orderdate;
select * from rcbill_my.dailysales where date(orderdate)='2018-02-04' order by orderdate;

select * from rcbill_my.dailysinglesales where date(entrydate)='2018-02-02' order by entrydate;
select * from rcbill_my.dailysinglesales where date(entrydate)='2018-02-03' order by entrydate;
select * from rcbill_my.dailysinglesales where date(entrydate)='2018-02-04' order by entrydate;

select * from rcbill_my.dailyaddonsales where date(paymentdate)='2018-02-02' order by salesid;
select * from rcbill_my.dailyaddonsales where date(paymentdate)='2018-02-03' order by salesid;
select * from rcbill_my.dailyaddonsales where date(paymentdate)='2018-02-04' order by salesid;


select * from rcbill_my.onlinepayments  where date(paymentdate)='2018-02-02' order by paymentid;
select * from rcbill_my.onlinepayments  where date(paymentdate)='2018-02-03' order by paymentid;
select * from rcbill_my.onlinepayments  where date(paymentdate)='2018-02-04' order by paymentid;

select * from rcbill_my.dailysinglesales where date(insertedon)='2018-02-04' order by entrydate;
select * from rcbill_my.dailyaddonsales where date(insertedon)='2018-02-04' order by salesid;
select * from rcbill_my.onlinepayments  where date(insertedon)='2018-02-04' order by paymentid;


select distinct servicecategory
, GetServiceCategory2(service) as servicecategory2
, service
, getcleanstring(servicetypeold) as package
, servicetype
,  servicesubcategory
, rcbill.GetServicePrice(service,getcleanstring(servicetypeold)) as packageprice
from rcbill_my.activenumber
where reported='Y' and decommissioned='N'
and period=@rundate
group by 
servicecategory, GetServiceCategory2(servicecategory), service, package, servicetype,  servicesubcategory
order by 
servicecategory;

use rcbill_my;

select * from rcbill_my.packagelist;

select * from rcbill_my.sales;
*/
/*
drop table if exists rcbill_my.saleslist;

create table rcbill_my.saleslist as
(
select distinct
salescenter, region, salestype, state, clientclass, contracttype, servicetype
from rcbill_my.sales
group by salescenter, region, salestype, state, clientclass, contracttype, servicetype
order by salescenter, region, salestype, state, clientclass, contracttype, servicetype
);
*/
/*

select * from rcbill_my.saleslist;

select distinct 
 
case when salescenter='' then 'BLANK'
else salescenter
end as salescenter 
from rcbill_my.saleslist
;

select distinct 
case when region='' then 'BLANK'
else region
end as region 
from rcbill_my.saleslist where salescenter in (select distinct salescenter from rcbill_my.saleslist)
;

select distinct salestype from rcbill_my.saleslist 
where 
region in (select distinct 
case when region='' then 'BLANK'
else region
end as region 
from rcbill_my.saleslist where salescenter in (select distinct salescenter from rcbill_my.saleslist))
;

select distinct state from rcbill_my.saleslist
where salestype in 
(
select distinct salestype from rcbill_my.saleslist 
where 
region in (select distinct 
case when region='' then 'BLANK'
else region
end as region 
from rcbill_my.saleslist where salescenter in (select distinct salescenter from rcbill_my.saleslist))
)
;

select distinct clientclass from rcbill_my.sales where 
-- ordermonth='January' and 
 salestype='New Sales' 
 ;

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and clientclass in ('corporate','Corporate Large','USD_standard')
;
 
select distinct servicetype, count(*) from rcbill_my.sales where 
salestype='New Sales' 
and state in ('Completed','Open')
-- and clientclass in ('corporate','Corporate Large','USD_standard')
group by servicetype
;
  */
