
-- TO Crimson
select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;

-- FROM Crimson
select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;

select  *
from rcbill_my.salestoactive 
where o_servicetype in ('Crimson','Crimson Corporate')
-- where 
and o_clientclass not in ('Employee','Intelvision Office')
and o_saleschannel in ('Sales')
-- and 
-- firstactivedateforcontract is not null
-- group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;



select distinct a.cl_clientcode, a.cl_clientname, a.cl_clclassname, a.con_contractcode,a.CON_STARTDATE, a.CON_ENDDATE, a.s_servicename, a.vpnr_servicetype, a.vpnr_serviceprice,a.contractcurrentstatus from 
rcbill.clientcontracts a
inner join 
(
select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE in ('Crimson','Crimson Corporate') and cl_clclassname not in ('INTELVISION OFFICE')
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
and ORIGINALSERVICETYPE in ('Crimson')

and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
group by clientcode
order by clientcode
;
*/
-- Crimson TO CRIMSON CONVERSION
select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Crimson','Crimson Corporate')
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
-- group by clientcode
order by clientcode
;

-- ======================================================


/*
select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
-- and clientclass in ('corporate','Corporate Large','USD_standard')
;


select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
-- and clientclass in ('corporate','Corporate Large','USD_standard')
;

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
;

select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;


select ORIGINALSERVICETYPE, servicetype, count(*) from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='New Sales' 
and state in ('Completed','Open')
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
group by ORIGINALSERVICETYPE, servicetype
-- with rollup
;




select * from rcbill_my.sales where 
-- ordermonth='January' and 
salestype='Renewals' 
and state in ('Completed','Open')
and ORIGINALSERVICETYPE in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
;




select  o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package,  count(*) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where o_servicetype in ('Crimson','Crimson Corporate')
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
and servicetype in ('Crimson','Crimson Corporate')
and clientclass not in ('Employee','Intelvision Office')
-- group by ORIGINALSERVICETYPE, servicetype
-- with rollup
)
;

*/
