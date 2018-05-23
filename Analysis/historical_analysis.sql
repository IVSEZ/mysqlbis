#CLIENT SCRIPT
-- use rcbill;

#SET DATE
SET @REPORTDATE=str_to_date('2017-12-31','%Y-%m-%d');
SET @rundate='2017-12-31';

/*
select * from rcbill_my.dailyactivenumber
where period=@rundate and reported='Y';

select * from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y';

select * from rcbill_my.activediscounts2;
select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;
*/

/*
select 
period, periodday, periodmth, periodyear, rcbill_my.GetWeekdayName(weekday(period)) as wday, service, servicecategory, servicecategory2, servicesubcategory
, package, clientclass, region
, sum(open_s) as activenos, sum(totopn_s) as openednos, sum(totcld_s) as closednos 
, sum(new_s) as newnos
, sum(newc_s) as newconnos
, sum(renew_s) as renewnos
, sum(closed_s) as clnos
, sum(closednon_s) as clnpnos
, sum(suspended_s) as suspnos
, sum(closedcon_s) as clconnos
, sum(closedoth_s) as clothnos 

from rcbill_my.anreport
where reported='Y' and decommissioned='N' and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
group by period, periodday, periodmth, periodyear, 5, service, servicecategory, servicecategory2, servicesubcategory
, package, clientclass, region
with rollup
;
*/
-- drop table if exists rcbill_my.rescustomersactivity;
drop table if exists rcbill_my.customersactivity_res;

create table rcbill_my.customersactivity_res as 
(

	select a.*, day(a.newperiod) as newperiodday, month(a.newperiod) as newperiodmth, year(a.newperiod) as newperiodyear
	from 
	(
		select a.*, 
			case 
				when a.periodyear=2016 then date_sub(period,INTERVAL 1 DAY) 
				when a.periodyear=2017 then period
				end as newperiod
			
		from 
		(
			select 
			period, periodday, periodmth, periodyear, rcbill_my.GetWeekdayName(weekday(period)) as wday, service, servicecategory, servicecategory2, servicesubcategory
			, package, clientclass, region
			, sum(open_s) as activenos, sum(totopn_s) as openednos, sum(totcld_s) as closednos 
			, sum(new_s) as newnos
			, sum(newc_s) as newconnos
			, sum(renew_s) as renewnos
			, sum(closed_s) as clnos
			, sum(closednon_s) as clnpnos
			, sum(suspended_s) as suspnos
			, sum(closedcon_s) as clconnos
			, sum(closedoth_s) as clothnos 
            , sum(diff_s) as diffnos
			from rcbill_my.anreport
			where reported='Y' and decommissioned='N' and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
			group by period, periodday, periodmth, periodyear, 5, service, servicecategory, servicecategory2, servicesubcategory
			, package, clientclass, region
			

		) a
	) a

)
;

select * from rcbill_my.customersactivity_res;

#GET PER PACKAGES

SELECT 
date(newperiod) as ds
, sum(activenos) as y
from 
rcbill_my.customersactivity_res
where 
clientclass in ('Residential')
-- and 
-- package in ('Basic')
group by newperiod
order by newperiod
;

SELECT 
wday, newperiod, newperiodday, newperiodmth, newperiodyear
, sum(activenos) as activenos, sum(openednos) as openednos, sum(closednos) as closednos, sum(clnpnos) as clnpos, sum(diffnos) as diffnos
from 
rcbill_my.customersactivity_res
where 
clientclass in ('Residential')
and 
package in ('Basic')
group by wday, newperiod, newperiodday, newperiodmth, newperiodyear
order by newperiod

;


SELECT 
-- period, periodday, periodmth, periodyear, 
wday, newperiod, newperiodday, newperiodmth, newperiodyear
-- , region, package, clientclass
, sum(activenos) as activenos, sum(openednos) as openednos, sum(closednos) as closednos, sum(clnpnos) as clnpos, sum(diffnos) as diffnos
from 
rcbill_my.customersactivity_res
where 
 clientclass in ('Corporate Bulk','Corporate Bundle')
 and 
 package in ('Extravagance Corporate')
group by wday, newperiod, newperiodday, newperiodmth, newperiodyear
order by newperiod
-- , region, package, clientclass
-- with rollup
;

SELECT period, periodday, periodmth, periodyear, wday, newperiod, newperiodday, newperiodmth, newperiodyear, region, package, clientclass, activenos, openednos,closednos
from 
rcbill_my.customersactivity_res
where 
-- clientclass in ('Corporate Bulk','Corporate Bundle')
-- and 
package in ('10GB','20GB','40GB','Crimson Corporate')
;



/*
	select a.period, a.periodday, a.periodmth, a.periodyear, a.clientcode 
, a.clientclass, a.clienttype
, a.cl_location, a.cl_area
, a.contractcode
, a.con_location, a.con_area
, a.servicecategory, a.servicecategory2, a.servicesubcategory, a.package, a.price, a.region, a.activecount, a.devicescount, a.reported, a.network
    
    
    , b.service
	from 
	rcbill_my.customercontractactivity a 
	inner join 
	rcbill_my.dailyactivenumber b 
	on 
	a.period=b.period and a.contractcode=b.contractcode and a.clientcode=b.clientcode and a.servicesubcategory=b.servicesubcategory and a.package=b.servicetype
	and a.servicecategory=b.servicecategory
    ;

*/
/*
select a.period, a.periodday, a.periodmth, a.periodyear, a.clientcode 
, a.clientclass, a.clienttype
, a.cl_location, a.cl_area
, a.contractcode, 
, a.con_location, a.con_area
, a.servicecategory, a.servicecategory2, a.servicesubcategory, a.package, a.price, a.region, a.activecount, a.devicescount, a.reported, a.network
, 
from 
rcbill_my.customercontractactivity a 
left join 
rcbill.clientcontractdiscounts b
on 
;
*/



/*
select * from rcbill.rcb_services where id in (118,127,77);
select * from rcbill.rcb_contractservices;

select * from rcbill_my.dailyactivenumber
where period=@rundate and reported='Y';

select * from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y';

select * from rcbill_my.customercontractactivity 
where period=@rundate and reported='Y' and price=0;

select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;

select * from rcbill.clientcontractdiscounts where servicename not like '%subscription%';

select a.*,b.*
from 
rcbill.clientcontractdiscounts a
inner join 
rcbill.clientcontractlastdiscount b 
on 
a.clientcode=b.b_clientcode and a.contractcode=b.b_contractcode and a.upddate=b.b_upddate;

*/

/*
select * from rcbill.clientcontractdiscounts;
select * from rcbill.clientcontractlastdiscount;

select a.*,b.percent,b.amount,b.servicename,b.upddate 
from 
(
select a.*, b.service
from 
rcbill_my.customercontractactivity a 
inner join 
rcbill_my.dailyactivenumber b 
on 
a.period=b.period and a.contractcode=b.contractcode and a.clientcode=b.clientcode and a.servicesubcategory=b.servicesubcategory and a.package=b.servicetype
and a.servicecategory=b.servicecategory

) a
inner join
( 
-- rcbill.clientcontractdiscounts b 
select a.*,b.*
from 
rcbill.clientcontractdiscounts a
inner join 
rcbill.clientcontractlastdiscount b 
on 
a.clientcode=b.b_clientcode and a.contractcode=b.b_contractcode and a.upddate=b.b_upddate

) b
on 
a.clientcode=b.clientcode 
and a.contractcode=b.contractcode
and upper(trim(a.service))=upper(trim(b.servicename))
where a.period=@rundate and a.reported='Y' 
;


*/


