SELECT DISTINCT o_service from rcbill_my.salestoactive;

select  o_ordermonth, o_orderday, o_region,  o_ordertype, o_service, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_network, ac_servicecategory, ac_package,  count(*) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
-- where 
-- ac_clientclass in ('Residential')
-- and 
-- firstactivedateforcontract is not null
group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_service, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_network, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;


select  o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package,  count(*) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where 
o_orderday='2018-12-17'
-- ac_clientclass in ('Residential')
-- and 
-- firstactivedateforcontract is not null
group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientclass, o_servicetype
;

##############################
### INTERNET ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription gNet','Subscription Internet','Subscription Capped Internet','Subscription Capped gNet')
and year(o_orderday)=2018
and inst_alldays is not null
and o_saleschannel in ('Sales')
order by o_clientcode
;


select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription gNet','Subscription Internet','Subscription Capped Internet','Subscription Capped gNet')
and year(o_orderday)=2018
and inst_alldays is not null
and o_saleschannel in ('Sales')
and year(FirstActiveDateForClient)=2018
order by o_clientcode
;


##############################
### TV ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription gTV','Subscription DTV')
and year(o_orderday)=2018
and inst_alldays is not null
and o_saleschannel in ('Sales')
;

##############################
### INTELENOVELA ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription Intelenovela')
and year(o_orderday)=2018
;

##############################
### INDIAN ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription Indian')
and year(o_orderday)=2018
;

##############################
### FRENCH ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription French')
and year(o_orderday)=2018
;

##############################
### NEXTTV ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription NextTV')
and year(o_orderday)=2018
;

##############################
### VOD ORDERS TO ACTIVE

select * from rcbill_my.salestoactive
where 
o_service IN ('Subscription VOD')
and year(o_orderday)=2018
;

##############################






select * from rcbill_my.customercontractactivity where clientcode='I.000016973';

select *
from rcbill_my.salestoactive 
where 
o_clientclass='Residential'
and
firstactivedateforcontract is not null
and 
o_servicetype='Extravagance'
order by o_orderday, o_clientcode, firstactivedateforcontract;


select *
 from rcbill_my.salestoactivejourney 
where o_clientcode in 
(
	select o_clientcode
	from rcbill_my.salestoactive 
	where 
	o_clientclass='Residential'
	and
	firstactivedateforcontract is not null
	and 
	o_servicetype='Extravagance'
)
order by o_clientcode, o_orderday,firstactivedateforclient, firstactivedateforcontract;


select *
from rcbill_my.salestoactive 
where 
-- o_clientclass='Residential'
-- and
firstactivedateforcontract is not null
and 
o_servicetype in ('Crimson','Crimson Corporate')
order by o_orderday, o_clientcode, firstactivedateforcontract;


select *
from rcbill_my.salestoactive 
where 
firstactivedateforcontract is not null
and inst_workdays<30
order by inst_workdays desc;

/*
select o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_clientclass, ac_package, o_region, max(inst_workdays) as maxworkdays
from rcbill_my.salestoactive 
where 
firstactivedate is not null
group by 
o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_clientclass, ac_package, o_region
order by o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_clientclass, o_region, 7 desc
;


select o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_clientclass, ac_package, o_region
, count(*) as sales, sum(inst_workdays) as inst_workdays
, sum(inst_workdays)/count(*) as avg_instdays
from rcbill_my.salestoactive 
where 
firstactivedate is not null
and 
inst_workdays<30
group by 
o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_clientclass, ac_package, o_region
;
*/

/*
select *
from rcbill_my.salestoactive 
where 
firstactivedate is not null
and
ac_package='20GB' and ac_servicesubcategory='GPON' and ac_clientclass='Corporate';
*/
/*
select a.*, b.LastActiveDateForClient
from
(
	select * from rcbill_my.salestoactive where o_clientclass in ('Residential')
	and FirstActiveDateForClient is not null
) a 
inner join
(
select clientcode, max(period) as LastActiveDateForClient
from 
rcbill_my.customercontractactivity 
group by clientcode
) b 
on a.o_clientcode=b.clientcode
;
*/
/*

select *
        from rcbill_my.sales
where orderday>='2017-01-01' and orderday<='2017-01-31' and salestype='New Sales' 
    and
    state in ('Completed')
;




select * from rcbill_my.salestoactive where o_clientclass in ('Corporate','Corporate Bundle','Corporate Bulk')
-- and firstactivedate is not null
order by  o_orderday, o_clientcode, firstactivedate
;

select * from rcbill_my.salestoactive where o_clientclass in ('Corporate','Corporate Bundle','Corporate Bulk')
and firstactivedate is not null
order by  o_orderday, o_clientcode, firstactivedate
;

select * from rcbill_my.salestoactivejourney where o_clientclass in ('Corporate','Corporate Bundle','Corporate Bulk')
order by  o_orderday, o_clientcode, firstactivedate
;



select clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
        , saleschannel,createdby, region 
        from rcbill_my.sales
where orderday>='2017-01-01' and orderday<='2017-01-31' and salestype='New Sales' 
    and
    state in ('Completed')
    group by clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
        , saleschannel,createdby, region 
;

		select clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
        , saleschannel,createdby, region 
		from rcbill_my.sales
		where 
		-- orderday='2017-01-04' 
		-- and 
		salestype='New Sales'
		and
		state in ('Open','Completed')
        
        */