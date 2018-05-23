use rcbill_my;

/*
select * from rcbill_my.dailyusage;
select * from rcbill_my.dailyusage where category='PREPAID';
-- select * from rcbill_my.dailyusage where category='PREPAID' and clientname
 
select distinct clientname, clientcode from rcbill_my.dailyusage where category='PREPAID';


select * from rcbill_my.dailyusage where clientname like '%rahul walavalkar%';

select * from rcbill_my.dailyusage where clientcode ='I.000009779';


select * from rcbill_my.dailyusage where clientname like '%INTELVISION TECH SUPPORT JIM TEST%';

select * from rcbill_my.dailyusage where clientname like '%Dominique%';

select * from rcbill_my.dailyusage where category in ('PREPAID');

select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientname like '%INTELVISION TECH SUPPORT JIM TEST%'
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by clientname, category, datestart
;

select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where category = 'PREPAID'
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;
*/

select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;


select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where traffic_mb>0
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

# PREPAID
select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where category='PREPAID'
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where category='PREPAID'
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

# UNCAPPED
select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where category='UNCAPPED'
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where category='UNCAPPED'
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;




select * from rcbill_my.clientstats where `Prepaid Data`>0;


select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientcode in 
(
select clientcode from rcbill_my.clientstats where `Prepaid Data`>0
)
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientcode in 
(
select clientcode from rcbill_my.clientstats where `Prepaid Data`>0
)
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;



#INTEL DATA 10
select * from rcbill_my.clientstats where `Intel Data 10`>0;

select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientcode in 
(
select clientcode from rcbill_my.clientstats where `Intel Data 10`>0
)
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;

select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientcode in 
(
select clientcode from rcbill_my.clientstats where `Intel Data 10`>0
)
group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;


#Crimson

use rcbill_my;
drop temporary table if exists temp1;
create temporary table temp1
as 
(
			select a.*, b.ContractCode, b.ContractType
			from 
			(
				select datestart, dateend, category, clientname, clientcode, device, traffictype
                , timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION
                , sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
				from rcbill_my.dailyusage
				where clientcode in 
				(
					SELECT distinct b.clientcode
					from rcbill_my.customercontractactivity b where b.period>='2017-04-01' and b.package in ('Crimson','Crimson Corporate')
				)
				and category='UNCAPPED'
				group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
				order by DATESTART
			) a 
			inner join 
			(
			select clientcode, phoneno, mac, contractcode, contracttype 
			from rcbill.clientcontractdevices
			) b
			on 
			a.device=b.phoneno and a.clientcode=b.clientcode
            order by a.clientcode
)
;
select * from temp1;
select * from temp1 where clientname like 'adrien%';

	select a.*, b.period, b.clientclass, b.clienttype, b.servicesubcategory, b.package, b.activecount, b.network
	from 
	temp1 a 
	left join
    -- (
		 rcbill_my.customercontractactivity b
		/*
        SELECT b.period, b.clientcode, b.contractcode, b.clientclass, b.clienttype, b.servicesubcategory, b.package, b.activecount, b.network 
		from rcbill_my.customercontractactivity b where b.period>='2017-04-01' and b.package in ('Crimson','Crimson Corporate')    
        */
    -- ) b 
	on a.clientcode=b.clientcode and a.contractcode=b.contractcode and (b.period>=a.datestart and b.period<=a.dateend);




select * from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0);

select category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
from rcbill_my.dailyusage
where clientcode in 
(
select clientcode from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0)
)
and category='UNCAPPED'
group by category, clientname, clientcode, device, traffictype, timezone
order by MB_USED desc, ACTUAL_DURATION desc
;


select distinct datestart, dateend, clientcode, clientname, contractcode, device, traffictype, mb_used
, clientclass, clienttype, package, datediff(dateend, datestart) as days, count(period) as perioddays
from 
(
	select a.*, b.period, b.clientclass, b.clienttype, b.servicesubcategory, b.package, b.activecount, b.network
	from 
	(

			select a.*, b.ContractCode, b.ContractType
			from 
			(
				select datestart, dateend, category, clientname, clientcode, device, traffictype
                , timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION
                , sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
				from rcbill_my.dailyusage
				where clientcode in 
				(
				select clientcode from rcbill_my.clientstats where (`Crimson`>0 or `Crimson Corporate`>0)
				)
				and category='UNCAPPED'
				group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
				order by DATESTART
			-- order by MB_USED desc, ACTUAL_DURATION desc
			) a 
			inner join 
			(
			select clientcode, phoneno, mac, contractcode, contracttype 
			from rcbill.clientcontractdevices
			) b
			on 
			a.device=b.phoneno and a.clientcode=b.clientcode
            order by a.clientcode
	) a 
	inner join
	rcbill_my.customercontractactivity b 
	on a.clientcode=b.clientcode and a.contractcode=b.contractcode and (b.period>=a.datestart and b.period<=a.dateend)
) a 
group by datestart, dateend, clientcode, clientname, contractcode, device, traffictype, mb_used, clientclass, clienttype, package     
;



select distinct datestart, dateend, clientcode, clientname, contractcode, device, traffictype, mb_used, clientclass, clienttype, package, datediff(dateend, datestart) as days, count(period) as perioddays
from 
(
	select a.*, b.period, b.clientclass, b.clienttype, b.servicesubcategory, b.package, b.activecount, b.network
	from 
	(

			select a.*, b.ContractCode, b.ContractType
			from 
			(
				select datestart, dateend, category, clientname, clientcode, device, traffictype, timezone, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
				from rcbill_my.dailyusage
				where clientcode in 
				(
				select clientcode from rcbill_my.clientstats where (`Elite`>0 or `Extreme`>0 or `Extreme Plus`>0 or `Performance`>0 or `Performance Plus`>0)
				)
				and category='HOTSPOT'
				group by datestart, dateend, category, clientname, clientcode, device, traffictype, timezone
				order by DATESTART
			-- order by MB_USED desc, ACTUAL_DURATION desc
			) a 
			inner join 
			(
			select clientcode, phoneno, mac, contractcode, contracttype 
			from rcbill.clientcontractdevices
			) b
			on 
			a.device=b.phoneno and a.clientcode=b.clientcode
	) a 
	left join
	rcbill_my.customercontractactivity b 
	on a.clientcode=b.clientcode and a.contractcode=b.contractcode and (b.period>=a.datestart and b.period<=a.dateend)
) a 
group by datestart, dateend, clientcode, clientname, contractcode, device, traffictype, mb_used, clientclass, clienttype, package     
;

select * from rcbill.clientcontractdevices;
select * from rcbill_my.customercontractactivity limit 100;


-- SELECT * FROM rcbill.rcb_contracts where kod like '%PPC2046884%';

-- select * from rcbill.clientcontractdevices where Phoneno ='00125-27195';

-- select * from rcbill_my.customercontractactivity where contractcode='PPC2068128';
-- select * from rcbill.rcb_devices limit 100;

