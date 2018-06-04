#CLIENT SCRIPT
-- use rcbill;

#SET DATE
-- SET @REPORTDATE=str_to_date('2018-04-11','%Y-%m-%d');

-- SET @rundate='2018-04-11';

-- SET @COLNAME1='CLIENTDEBT_REPORTDATE';


use rcbill_my;



drop table if exists rcbill_my.salestoactive_DV;
create table rcbill_my.salestoactive_DV as
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
		,b.clientname as ac_clientname, b.clientclass as ac_clientclass, b.clienttype as ac_clienttype, b.servicecategory as ac_servicecategory
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
			-- orderday='2017-01-04' 
			-- and 
			-- salestype='New Sales'
			servicetype='DualView'
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
				-- salestype='New Sales'
				servicetype='DualView'
                and
				state in ('Open','Completed')
				and clientcode <> '' and contract <>''
					group by clientcode 
			)
			group by clientcode
	) b 
	on a.o_clientcode=b.clientcode


)
;


/*
select *
 from rcbill_my.salestoactive 
 where date(o_orderdate) = '2017-11-08'
order by o_orderday, o_clientcode, firstactivedateforcontract;
*/


select * from rcbill_my.clientstats where dualview>0;


select * from rcbill_my.salestoactive_DV order by o_orderdate ;
 
-- SALES TO ACTIVE JOINED WITH TICKET SNAPSHOT
select 
a.*,
b.*

from 
rcbill_my.salestoactive_DV a 
left join
rcbill_my.clientticketsnapshot_irs b
on 
a.o_clientcode=b.clientcode
and 
a.o_contractcode=b.contractcode
order by o_orderdate desc
;


select a.period
, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.services, a.activecount, a.contractcount, a.region, a.network
, a.`DualView`
, b.o_orderdate, b.o_orderday, b.o_clientcode,b.o_contractcode,b.o_ordertype,b.o_saleschannel, b.o_createdby
, b.ac_clientname, b.ac_clientclass, b.ac_clienttype, b.ac_servicecategory, b.ac_servicesubcategory, b.ac_package, b.ac_price, b.ac_activecount, b.ac_network
, b.inst_alldays, b.inst_workdays, b.firstactivedateforcontract, b.lastactivedateforcontract, b.durationforcontract, b.activedaysforcontract
, b.firstactivedateforclient, b.lastactivedateforclient, b.activedaysforclient,b.durationforclient
, b.ticketid, b.tickettype,b.OpenReason, b.CloseReason, b.opendate, b.closedate, b.firstcommentdate, b.lastcommentdate, b.firstcomment, b.lastcomment, b.tkt_alldays, b.tkt_workdays

from 
( select * from rcbill_my.clientstats where dualview>0 ) a
-- rcbill_my.clientstats a 
left join 
( 
	select 
	a.*,
	b.ticketid, b.clientcode, b.contractcode, b.TicketType, b.OpenReason, b.CloseReason, b.OpenRegion, b.StageRegion, b.CloseRegion, b.opendate, b.closedate, b.firstcommentdate, b.lastcommentdate
    , b.firstcomment, b.lastcomment, b.tkt_alldays, b.tkt_workdays

	from 
	rcbill_my.salestoactive_DV a 
	left join
	rcbill_my.clientticketsnapshot_irs b
	on 
	a.o_clientcode=b.clientcode
	and 
	a.o_contractcode=b.contractcode
	order by o_orderdate desc
) b
on 
a.clientcode=b.clientcode;




select a.clientcode, a.clientname, b.*
from 
(

	select a.period
	, a.clientcode, a.clientname, a.clientclass, a.clienttype, a.services, a.activecount, a.contractcount, a.region, a.network
	, a.`DualView`
	, b.o_orderdate, b.o_orderday, b.o_clientcode,b.o_contractcode,b.o_ordertype,b.o_saleschannel, b.o_createdby
	, b.ac_clientname, b.ac_clientclass, b.ac_clienttype, b.ac_servicecategory, b.ac_servicesubcategory, b.ac_package, b.ac_price, b.ac_activecount, b.ac_network
	, b.inst_alldays, b.inst_workdays, b.firstactivedateforcontract, b.lastactivedateforcontract, b.durationforcontract, b.activedaysforcontract
	, b.firstactivedateforclient, b.lastactivedateforclient, b.activedaysforclient,b.durationforclient
	, b.ticketid, b.tickettype,b.OpenReason, b.CloseReason, b.opendate, b.closedate, b.firstcommentdate, b.lastcommentdate, b.firstcomment, b.lastcomment, b.tkt_alldays, b.tkt_workdays

	from 
	( select * from rcbill_my.clientstats where dualview>0 ) a
	-- rcbill_my.clientstats a 
	left join 
	( 
		select 
		a.*,
		b.ticketid, b.clientcode, b.contractcode, b.TicketType, b.OpenReason, b.CloseReason, b.OpenRegion, b.StageRegion, b.CloseRegion, b.opendate, b.closedate, b.firstcommentdate, b.lastcommentdate
		, b.firstcomment, b.lastcomment, b.tkt_alldays, b.tkt_workdays

		from 
		rcbill_my.salestoactive_DV a 
		left join
		rcbill_my.clientticketsnapshot_irs b
		on 
		a.o_clientcode=b.clientcode
		and 
		a.o_contractcode=b.contractcode
		order by o_orderdate desc
	) b
	on 
	a.clientcode=b.clientcode



) a 
left join
rcbill_my.sales b
on a.clientcode=b.clientcode
where b.orderday>'2018-04-01'
and b.state in ('Completed','Open')
and b.service in ('Subscription Capped gNet','Subscription Capped Internet','Subscription Internet','Subscription gNet')
order by b.orderdate
;


select distinct a.cl_clientcode, a.cl_clientname, a.cl_clclassname, a.con_contractcode,a.CON_STARTDATE, a.CON_ENDDATE, a.s_servicename, a.vpnr_servicetype, a.vpnr_serviceprice,a.contractcurrentstatus from 
rcbill.clientcontracts a
inner join 
(
select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE')
) b 
on 
a.con_contractcode=b.con_contractcode
and 
a.s_servicename=b.s_servicename
and 
a.vpnr_servicetype=b.vpnr_servicetype
order by cl_clclassname, CL_CLIENTNAME
;


select * from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE');

-- set @rundate='2018-05-16';
select *, rcbill_my.GetNetwork(rcbill_my.GetLastActiveDateForClient(cl_clientcode), CON_CONTRACTCODE) as Network
,upper(rcbill_my.GetServiceCategory2(S_SERVICENAME)) as CATEGORY

 from rcbill.clientcontractssubs where cl_clientid 
in (select cl_clientid from rcbill.clientcontractssubs where VPNR_SERVICETYPE='DUALVIEW' and cl_clclassname not in ('INTELVISION OFFICE'))
-- and VPNR_SERVICETYPE='DUALVIEW'
;

-- select rcbill_my.GetLastActiveDateForClient('I22164');
-- select rcbill_my.GetNetwork(rcbill_my.GetLastActiveDateForClient('I22164'), 'I.000317449');


/* TESTING */
/*
			select distinct clientcode, clientname, contractcode, clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package
            , price, ACTIVECOUNT, network
            -- , min(period) as firstactivedate, max(period) as lastactivedate  
			, min(period) as firstactivedate, max(period) as lastactivedate 
            -- , rcbill_my.GetActiveDaysForContract(clientcode,contractcode,package) as ActiveDaysForContract 
			from rcbill_my.customercontractactivity
			-- where clientname like '%rahul walavalkar%'
            where package='DualView'
			group by clientcode
			-- , clientname
			, contractcode
            , package
			-- , clientclass, clienttype, servicecategory, servicecategory2, servicesubcategory, package, price
			;
            
            select distinct package from rcbill_my.customercontractactivity;
            
            select * from rcbill_my.customercontractactivity where clientcode='I.000008586';
            
            select * from rcbill_my.dailyactivenumber where clientcode='I.000008586' period=@rundate and reported='Y';
            
*/
