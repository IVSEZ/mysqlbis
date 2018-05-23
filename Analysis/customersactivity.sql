#CLIENT SCRIPT
-- use rcbill;

#SET DATE
SET @REPORTDATE=str_to_date('2017-12-31','%Y-%m-%d');
SET @rundate='2017-12-31';


drop table if exists rcbill_my.customersactivity_all;

create table rcbill_my.customersactivity_all as 
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
			where reported='Y' and decommissioned='N' 
            -- and clientclass in ('Residential','Corporate Bundle','Corporate Bulk')
			group by period, periodday, periodmth, periodyear, 5, service, servicecategory, servicecategory2, servicesubcategory
			, package, clientclass, region
			

		) a
	) a

)
;

select * from rcbill_my.customersactivity_all;

/*
select distinct region from rcbill_my.customersactivity_all;
select distinct clientclass from rcbill_my.customersactivity_all;

select distinct servicecategory, service, package from rcbill_my.customersactivity_all where clientclass='Residential' group by servicecategory, service, package;
select distinct servicecategory, package from rcbill_my.customersactivity_all where clientclass='Residential' group by servicecategory, package;

*/

/*
select period as ds, sum(activenos) as y 
     from rcbill_my.customersactivity_all 
     where 
     clientclass in ("Residential") 
     and servicecategory in ("TV") 
     and region in ("Praslin")
     and (package in ("French") or service in ("Subscription French")) 
     group by period;
     
     select period as ds, sum(activenos) as y 
     from rcbill_my.customersactivity_all 
     where 
     clientclass in ("Residential") 
     and servicecategory in ("Internet") 
          and region in ("Mahe")
     and (package in ("Performance Plus")) 
    -- and period > '2017-03-24'
     group by period;
*/

/*
set @cc='Residential';
set @sc='Internet';

-- actives nos
select newperiod, sum(activenos) as activenos
from 
rcbill_my.customersactivity_all
where
clientclass in (@cc)
and 
servicecategory in (@sc)
group by newperiod; 

-- opened nos
select newperiod, sum(openednos) as openednos
from 
rcbill_my.customersactivity_all
where
clientclass=@cc
group by newperiod; 

-- closed nos
select newperiod, sum(closednos) as closednos
from 
rcbill_my.customersactivity_all
where
clientclass=@cc
group by newperiod; 

select * from rcbill_my.customersactivity_all where package='Corporate';
*/