use rcbill_my;
-- SET @rundate='2018-01-10';
-- select * from rcbill_my.clientstats where clientcode in ('I.000008110');
/*

select * from rcbill_my.clientticketsnapshot_irs where clien

select * from rcbill_my.sales
where orderday>='2017-10-01' and orderday<='2017-10-25' and salestype='New Sales' 
    and
    state in ('Completed')
;
*/
-- select * from rcbill_my.customercontractactivity limit 100;
/*
select clientcode, clientname, contractcode, package, min(period) as firstactivedate  from rcbill_my.customercontractactivity
group by 1,2,3
;

select clientcode, clientname, contractcode,min(period) as firstactivedate from rcbill_my.customercontractactivity
where clientname like '%rahul walavalkar%'
group by 1,2,3
;



*/

-- duration: 631.640 sec, 636.218 sec, 653.016 sec 742.890 sec

select now() as currenttime;

drop table if exists rcbill_my.salestoactive;
create table rcbill_my.salestoactive as
(

	select a.*
    , rcbill_my.GetActiveDaysForContract(a.o_clientcode,a.o_contractcode,a.ac_package) as ActiveDaysForContract 
    , b.FirstActiveDateForClient, b.LastActiveDateForClient
    -- , b.ActiveDaysForClient
    , rcbill_my.GetActiveDaysForClient(a.o_clientcode) as ActiveDaysForClient
    , b.DurationForClient
	from 
	(	
		
		select 
		-- a.*, 
		@rundate as ReportDate,
		a.clientcode as o_clientcode, a.contract as o_contractcode, a.clientclass as o_clientclass, a.contracttype as o_contracttype, a.service as o_service, a.servicetype as o_servicetype
		, a.ordertype as o_ordertype, a.cost as o_cost, a.price as o_price, a.num as o_num
		, a.saleschannel as o_saleschannel, a.createdby as o_createdby, a.region as o_region 
        , b.clientcode as ac_clientcode, b.contractcode as ac_contractcode
		, b.clientname as ac_clientname, b.clientclass as ac_clientclass, b.clienttype as ac_clienttype, b.servicecategory as ac_servicecategory
		, b.servicecategory2 as ac_servicecategory2, b.servicesubcategory as ac_servicesubcategory, b.package as ac_package, b.price as ac_price, b.ACTIVECOUNT as ac_activecount
        , b.network as ac_network
		, a.orderday as o_orderday, a.ordermonth as o_ordermonth, a.orderdate as o_orderdate, a.weekday as o_weekday    
		, datediff(b.firstactivedate,a.orderday) as inst_alldays
		, (5 * (DATEDIFF(firstactivedate, orderday) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(orderday) + WEEKDAY(firstactivedate) + 1, 1)) as inst_workdays
		, b.firstactivedate as FirstActiveDateForContract
		, b.lastactivedate as LastActiveDateForContract 
		-- , (datediff(b.lastactivedate,b.firstactivedate)+1) as ActiveDaysForContract 
		-- , rcbill_my.GetActiveDaysForContract(b.clientcode,b.contractcode,b.package) as ActiveDaysForContract 
        -- , b.ActiveDaysForContract
		, (datediff(b.lastactivedate,b.firstactivedate)+1) as DurationForContract 
		from 
		(
			select distinct clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num
            , orderday, ordermonth, orderdate, weekday, saleschannel,createdby, region 
			from rcbill_my.sales
			where 
			-- clientcode='I.000016973' and
			-- orderday='2017-01-04' 
			-- and 
			salestype='New Sales'
			and
			state in ('Open','Completed')
			and clientcode <> '' and contract <>''
				group by clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
			, saleschannel,createdby, region 
		) a
		left join
		(
			
			select distinct clientcode, clientname, contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package
            , price, ACTIVECOUNT, network
            -- , min(period) as firstactivedate, max(period) as lastactivedate  
			, min(period) as firstactivedate, max(period) as lastactivedate 
            -- , rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract 
			from rcbill_my.customercontractactivity
			-- where clientname like '%rahul walavalkar%'
			-- where clientcode = 'I.000016973'
            group by clientcode
			-- , clientname
			, contractcode
            , package
			-- , clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price

		) b
		on a.clientcode=b.clientcode and a.contract=b.contractcode and a.servicetype=b.package
	) a 
	left join
	(
			select 
			clientcode, min(period) as FirstActiveDateForClient, max(period) as LastActiveDateForClient
			-- , (datediff(max(period),min(period))+1) as ActiveDaysForClient 
			-- , count(distinct period) as ActiveDaysForClient
            , (datediff(max(period),min(period))+1) as DurationForClient 
			from rcbill_my.customercontractactivity
			where clientcode in 
			(
				select distinct clientcode
				from rcbill_my.sales
				where 
				-- orderday='2017-01-04' 
				-- and 
				salestype='New Sales'
				and
				state in ('Open','Completed')
				and clientcode <> '' and contract <>''
					group by clientcode 
			)
			group by clientcode
	) b 
	on a.o_clientcode=b.clientcode

/*
	select 
	-- a.*, 
    date(now()) as ReportDate,
    a.clientcode as o_clientcode, a.contract as o_contractcode, a.clientclass as o_clientclass, a.contracttype as o_contracttype, a.service as o_service, a.servicetype as o_servicetype
    , a.ordertype as o_ordertype, a.cost as o_cost, a.price as o_price, a.num as o_num, a.orderday as o_orderday, a.ordermonth as o_ordermonth, a.orderdate as o_orderdate, a.weekday as o_weekday
    , a.saleschannel as o_saleschannel, a.createdby as o_createdby, a.region as o_region 
    ,b.clientname as ac_clientname, b.clientclass as ac_clientclass, b.clienttype as ac_clienttype, b.servicecategory as ac_servicecategory
    , b.servicecategory2 as ac_servicecategory2, b.servicesubcategory as ac_servicesubcategory, b.package as ac_package, b.price as ac_price, b.ACTIVECOUNT as ac_activecount
    , b.firstactivedate, b.lastactivedate 
    -- , max(b.lastactivedate) as LastActiveDateForClient
    , (datediff(b.lastactivedate,b.firstactivedate)+1) as activedays 
    , datediff(b.firstactivedate,a.orderday) as inst_alldays
    , (5 * (DATEDIFF(firstactivedate, orderday) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(orderday) + WEEKDAY(firstactivedate) + 1, 1)) as inst_workdays
	from 
	(
		select clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday, saleschannel,createdby, region 
		from rcbill_my.sales
		where 
		-- orderday='2017-01-04' 
		-- and 
		salestype='New Sales'
		and
		state in ('Open','Completed')
            group by clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
        , saleschannel,createdby, region 
	) a
	left join
	(
		
		select distinct clientcode, clientname, contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price, ACTIVECOUNT, min(period) as firstactivedate, max(period) as lastactivedate  
		from rcbill_my.customercontractactivity
		-- where clientname like '%rahul walavalkar%'
		group by clientcode
        -- , clientname
        , contractcode
        -- , clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price

	) b
	on a.clientcode=b.clientcode and a.contract=b.contractcode and a.servicetype=b.package
	-- group by 1,2,3
*/    
)
;

select now() as currenttime;

#JOURNEY TABLE
drop table if exists rcbill_my.salestoactivejourney;
-- duration 482.687 sec 490.609 sec 581.922 sec


create table rcbill_my.salestoactivejourney as
(

    select a.*
    -- , b.FirstActiveDateForClient, b.LastActiveDateForClient
    -- , b.ActiveDaysForClient
    -- , b.DurationForClient
    
    , rcbill_my.GetActiveDaysForContract(a.o_clientcode,a.ac_contractcode,a.ac_package) as ActiveDaysForContract 
    , b.FirstActiveDateForClient, b.LastActiveDateForClient
    -- , b.ActiveDaysForClient
    , rcbill_my.GetActiveDaysForClient(a.o_clientcode) as ActiveDaysForClient
    , b.DurationForClient    
	from 
	(	
		
		select 
		-- a.*, 
		@rundate as ReportDate,
		a.clientcode as o_clientcode, a.contract as o_contractcode, a.clientclass as o_clientclass, a.contracttype as o_contracttype
        , a.service as o_service, a.servicetype as o_servicetype
		, a.ordertype as o_ordertype, a.cost as o_cost, a.price as o_price, a.num as o_num
		, a.saleschannel as o_saleschannel, a.createdby as o_createdby, a.region as o_region 
		, b.contractcode as ac_contractcode, b.clientname as ac_clientname, b.clientclass as ac_clientclass, b.clienttype as ac_clienttype
        , b.servicecategory as ac_servicecategory
		, b.servicecategory2 as ac_servicecategory2, b.servicesubcategory as ac_servicesubcategory, b.package as ac_package, b.price as ac_price
        , b.ACTIVECOUNT as ac_activecount
        , b.network as ac_network
		, a.orderday as o_orderday, a.ordermonth as o_ordermonth, a.orderdate as o_orderdate, a.weekday as o_weekday    
		, datediff(b.firstactivedate,a.orderday) as inst_alldays
		, (5 * (DATEDIFF(b.firstactivedate, a.orderday) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(a.orderday) + WEEKDAY(b.firstactivedate) + 1, 1)) as inst_workdays
		-- , b.firstactivedate as FirstActiveDateForContract
		-- , b.lastactivedate as LastActiveDateForContract 
        -- , b.ActiveDaysForContract
		-- , (datediff(b.lastactivedate,b.firstactivedate)+1) as DurationForContract 
        
		, b.firstactivedate as FirstActiveDateForContract
		, b.lastactivedate as LastActiveDateForContract 
		-- , (datediff(b.lastactivedate,b.firstactivedate)+1) as ActiveDaysForContract 
		-- , rcbill_my.GetActiveDaysForContract(b.clientcode,b.contractcode,b.package) as ActiveDaysForContract 
        -- , b.ActiveDaysForContract
		, (datediff(b.lastactivedate,b.firstactivedate)+1) as DurationForContract         
        
		from 
		(
			select distinct clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday, saleschannel,createdby, region 
			from rcbill_my.sales
			where 
			-- orderday='2017-01-04' 
			-- and 
			salestype='New Sales'
			and
			state in ('Open','Completed')
            and clientcode <> '' and contract <>''
				group by clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
			, saleschannel,createdby, region 
		) a
		left join
		(
			
			select distinct clientcode, clientname, contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price, ACTIVECOUNT, network
			, min(period) as firstactivedate, max(period) as lastactivedate 
            -- , rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract 
			from rcbill_my.customercontractactivity
			-- where clientname like '%rahul walavalkar%'			
            
            group by clientcode
            -- , clientname
            , contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price, ACTIVECOUNT, network
			-- , clientname
			-- , contractcode
			-- , clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price

		) b
		on a.clientcode=b.clientcode and rcbill_my.GetServiceCategory2(a.service)=b.servicecategory2
        -- and a.contract=b.contractcode and a.servicetype=b.package
	) a 
	left join
	(
			select 
			clientcode, min(period) as FirstActiveDateForClient, max(period) as LastActiveDateForClient
			-- , (datediff(max(period),min(period))+1) as ActiveDaysForClient 
			-- , count(distinct period) as ActiveDaysForClient
            , (datediff(max(period),min(period))+1) as DurationForClient 
            
			from rcbill_my.customercontractactivity
			where clientcode in 
			(
				select distinct clientcode
				from rcbill_my.sales
				where 
				-- orderday='2017-01-04' 
				-- and 
				salestype='New Sales'
				and
				state in ('Open','Completed')
				and clientcode <> '' and contract <>''
				group by clientcode 
			)
			group by clientcode
	) b 
	on a.o_clientcode=b.clientcode
/*
	select 
	-- a.*, 
    date(now()) as ReportDate,
    a.clientcode as o_clientcode, a.contract as o_contractcode, a.clientclass as o_clientclass, a.contracttype as o_contracttype, a.service as o_service, a.servicetype as o_servicetype
    , a.ordertype as o_ordertype, a.cost as o_cost, a.price as o_price, a.num as o_num, a.orderday as o_orderday, a.ordermonth as o_ordermonth, a.orderdate as o_orderdate, a.weekday as o_weekday
    , a.saleschannel as o_saleschannel, a.createdby as o_createdby, a.region as o_region 
    
    , b.clientname as ac_clientname, b.clientclass as ac_clientclass, b.clienttype as ac_clienttype, b.servicecategory as ac_servicecategory
    , b.servicecategory2 as ac_servicecategory2, b.servicesubcategory as ac_servicesubcategory, b.package as ac_package, b.price as ac_price, b.ACTIVECOUNT as ac_activecount
    , b.firstactivedate, b.lastactivedate , (datediff(b.lastactivedate,b.firstactivedate)+1) as activedays 
    , datediff(b.firstactivedate,a.orderday) as inst_alldays
    , (5 * (DATEDIFF(firstactivedate, orderday) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(orderday) + WEEKDAY(firstactivedate) + 1, 1)) as inst_workdays
    

    from 
	(
		select clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday, saleschannel,createdby, region 
		from rcbill_my.sales
		where 
		-- orderday='2017-01-04' 
		-- and 
		salestype='New Sales'
		and
		state in ('Open','Completed')
		group by clientcode, contract, clientclass, contracttype, service, servicetype, ordertype, cost, price, num, orderday, ordermonth, orderdate, weekday
        , saleschannel,createdby, region 
	) a
	left join
	(
		
		select clientcode, clientname, contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price, ACTIVECOUNT, min(period) as firstactivedate, max(period) as lastactivedate  
		from rcbill_my.customercontractactivity
		-- where clientname like '%rahul walavalkar%'
		group by clientcode
        -- , clientname
        , contractcode
        , clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price
        -- , price

	) b
	on a.clientcode=b.clientcode and a.contract=b.contractcode and a.servicetype=b.package
	-- group by 1,2,3

*/
)
;


/*
select *
 from rcbill_my.salestoactive 
 where date(o_orderdate) = '2017-11-08'
order by o_orderday, o_clientcode, firstactivedateforcontract;
*/

-- SALES TO ACTIVE JOINED WITH TICKET SNAPSHOT
/*
select 
a.*,
b.*

from 
rcbill_my.salestoactive a 
inner join
rcbill_my.clientticketsnapshot_irs b
on 
a.o_clientcode=b.clientcode
and 
a.o_contractcode=b.contractcode
order by o_orderdate desc
;

*/

/*
select *
 from rcbill_my.salestoactive 
-- where firstactivedateforcontract is not null
order by o_orderday, o_clientcode, firstactivedateforcontract;


select *
 from rcbill_my.salestoactive 
where firstactivedateforcontract is not null
order by o_orderday, o_clientcode, firstactivedateforcontract;
*/

/*
select a.*, b.* from 
rcbill_my.salestoactive a 
inner join 
rcbill.rcb_clientaddress  b
on a.o_clientcode=b.ClientCode
where 
(o_orderdate>'2017-10-24')
and
(
(b.clientaddress like '%gond%')
or 
(b.clientaddress like '%francois%')
)
order by a.o_orderdate
;
*/

/*
select *
-- datediff(firstactivedate,orderday) as diffalldays,
-- (5 * (DATEDIFF(firstactivedate, orderday) DIV 7) + MID('0123444401233334012222340111123400001234000123440', 7 * WEEKDAY(orderday) + WEEKDAY(firstactivedate) + 1, 1)) as diffworkdays
 from rcbill_my.salestoactivejourney 

order by o_clientcode, o_orderday,firstactivedateforclient, firstactivedateforcontract;



select  o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package,  count(1) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
-- where 
-- ac_clientclass in ('Residential')
-- and 
-- firstactivedateforcontract is not null
group by o_ordermonth, o_orderday, o_region,  o_ordertype, o_servicetype, o_clientclass, ac_clientclass, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;


select  o_ordermonth, o_orderday, ac_clientclass, o_region,  o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_package,  count(1) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where 
ac_clientclass in ('Residential')
 and 
firstactivedateforcontract is not null
group by o_ordermonth, o_orderday, ac_clientclass, o_region,  o_ordertype, ac_servicesubcategory, ac_servicecategory, ac_package
order by  o_orderday desc, o_clientcode, firstactivedateforcontract
;


select o_region, month(o_orderdate) as o_month, year(o_orderdate) as o_year, ac_package
,  count(1) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where 
ac_clientclass in ('Residential')
 and 
firstactivedateforcontract is not null
group by 1,2, 3,4
order by  3 desc, 2 desc,4,1
;
*/

/*
select o_region, month(o_orderdate) as o_month, year(o_orderdate) as o_year, ac_package,  count(1) as allcount, count(distinct o_clientcode) as distclient, sum(ac_activecount) as activenos 
from rcbill_my.salestoactive 
where 
ac_clientclass in ('Residential')
-- and 
-- firstactivedateforcontract is not null
group by 1,2, 3,4
order by  2, 3,4,1
;
*/

/*
select *
 from rcbill_my.salestoactive 
where
o_ordermonth='November' and year(o_orderdate)=2017
-- firstactivedateforcontract is not null
order by o_orderday, o_clientcode, firstactivedateforcontract;


select *
 from rcbill_my.salestoactive 
 where 
ac_clientclass in ('Residential')
and 
ac_package in ('Basic')
 and 
firstactivedateforcontract is not null
and month(o_orderdate)=1
and year(o_orderdate)=2017
order by o_orderday, o_clientcode, firstactivedateforcontract;

*/