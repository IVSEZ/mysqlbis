use rcbill_my;
set @reportdate='2018-01-11';

-- GET CRIMSON CUSTOMERS
select a.*,(datediff(a.lastcontractdate,a.firstcontractdate)+1) as ActiveDays, b.phoneno, b.mac,
case when a.lastcontractdate = @reportdate then 'Currently Active' 
else 'Not Active'
end as `CurrentStatus`
from 
(
	select distinct clientcode, contractcode, package, min(period) as firstcontractdate, max(period) as lastcontractdate from rcbill_my.customercontractactivity 
	where package in ('Crimson','Crimson Corporate')
	group by clientcode, contractcode, package
) a
inner join 
(
    select * from rcbill.clientcontractdevices 
) b
on 
a.clientcode=b.clientcode and a.contractcode=b.contractcode
;


-- GET CRIMSON CUSTOMERS USAGE
drop table if exists rcbill_my.crimsoncustomerusage;
create table rcbill_my.crimsoncustomerusage
as
(
select a.*,b.datestart,b.dateend,b.MB_USED, (b.MB_USED/b.UsageDays) as AVG_DAILY_USE_MB, ((b.MB_USED/b.UsageDays)*30) as AVG_MONTHLY_USE_MB, b.UsageDays, b.category
from 
(
	select a.*,(datediff(a.lastcontractdate,a.firstcontractdate)+1) as ActiveDays, b.phoneno, b.mac,
	case when a.lastcontractdate = @reportdate then 'Currently Active' 
	else 'Not Active'
	end as `CurrentStatus`
	from 
	(
		select distinct clientcode, contractcode, package, min(period) as firstcontractdate, max(period) as lastcontractdate from rcbill_my.customercontractactivity 
		where package in ('Crimson','Crimson Corporate') and period>='2017-10-01'
		group by clientcode, contractcode, package
	) a
	inner join 
	(
		select * from rcbill.clientcontractdevices
	) b
	on 
	a.clientcode=b.clientcode and a.contractcode=b.contractcode


) a
left join
(
		select category, clientname, clientcode, device, min(datestart) as datestart, max(dateend) as dateend, (datediff(max(dateend),min(datestart))+1) as UsageDays, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
		from rcbill_my.dailyusage
		-- where clientcode = 'I16139'
        where datestart>='2017-10-01'
		group by category, clientcode, device
) b
on a.clientcode=b.clientcode and a.phoneno=b.device
and (a.firstcontractdate>=b.datestart or a.lastcontractdate<=b.dateend)
)
;

select * from rcbill_my.crimsoncustomerusage;
select * from rcbill_my.crimsoncustomerusage where category='UNCAPPED' and currentstatus='Currently Active';


select * from rcbill_my.crimsoncustomerusage where package='Crimson' and category='HOTSPOT';
--  and currentstatus='Currently Active';


-- SUMMARISE
select a.*,b.clientname, b.clientclass
from 
(
	select clientcode, datestart, dateend, usagedays, sum(mb_used) as mb_used, sum(AVG_MONTHLY_USE_MB) as AVG_MONTHLY_USE_MB, sum(AVG_DAILY_USE_MB) as AVG_DAILY_USE_MB
	from  rcbill_my.crimsoncustomerusage
	where category='UNCAPPED' and currentstatus='Currently Active'
	group by clientcode
	order by 6 desc
) a
inner join
(
select clientcode, clientname, clientclass from rcbill_my.clientstats
) b
on a.clientcode=b.clientcode
;



-- SUMMARISE



-- ============================================================================================

-- CAPPED CUSTOMERS
select a.*,(datediff(a.lastcontractdate,a.firstcontractdate)+1) as ActiveDays, b.phoneno, b.mac,
case when a.lastcontractdate = @reportdate then 'Currently Active' 
else 'Not Active'
end as `CurrentStatus`
from 
(
	select distinct clientcode, contractcode, package, min(period) as firstcontractdate, max(period) as lastcontractdate from rcbill_my.customercontractactivity 
	where  servicecategory2 in ('Internet - Capped')
	group by clientcode, contractcode, package
) a
inner join 
(
    select * from rcbill.clientcontractdevices 
) b
on 
a.clientcode=b.clientcode and a.contractcode=b.contractcode
;


-- GET CAPPED CUSTOMERS USAGE
drop table if exists rcbill_my.cappedcustomerusage;
create table rcbill_my.cappedcustomerusage
as
(
select a.*,b.datestart,b.dateend,b.MB_USED, (b.MB_USED/b.UsageDays) as AVG_DAILY_USE_MB, ((b.MB_USED/b.UsageDays)*30) as AVG_MONTHLY_USE_MB, b.UsageDays, b.category
from 
(
	select a.*,(datediff(a.lastcontractdate,a.firstcontractdate)+1) as ActiveDays, b.phoneno, b.mac,
	case when a.lastcontractdate = @reportdate then 'Currently Active' 
	else 'Not Active'
	end as `CurrentStatus`
	from 
	(
		select distinct clientcode, contractcode, package, min(period) as firstcontractdate, max(period) as lastcontractdate from rcbill_my.customercontractactivity 
		where servicecategory2 in ('Internet - Capped') and period>='2017-10-01'
		group by clientcode, contractcode, package
	) a
	inner join 
	(
		select * from rcbill.clientcontractdevices
	) b
	on 
	a.clientcode=b.clientcode and a.contractcode=b.contractcode


) a
left join
(
		select category, clientname, clientcode, device, min(datestart) as datestart, max(dateend) as dateend, (datediff(max(dateend),min(datestart))+1) as UsageDays, sum(traffic_mb) as MB_USED, sum(billable_duration_min) as BILLED_DURATION, sum(actual_duration_min) as ACTUAL_DURATION, sum(price) as PRICE, sum(price_vat) as PRICE_VAT
		from rcbill_my.dailyusage
		-- where clientcode = 'I16139'
        where datestart>='2017-10-01'
		and 
		traffic_mb > 0
		group by category, clientcode, device
) b
on a.clientcode=b.clientcode and a.phoneno=b.device
and (a.firstcontractdate>=b.datestart or a.lastcontractdate<=b.dateend)
)
;


select * from rcbill_my.cappedcustomerusage;

-- SUMMARISE

select a.*,b.clientname, b.clientclass
from 
(
	select a.clientcode, a.package, sum(a.mb_used) as mb_used, sum(a.AVG_MONTHLY_USE_MB) as AVG_MONTHLY_USE_MB, sum(a.AVG_DAILY_USE_MB) as AVG_DAILY_USE_MB
	from  rcbill_my.cappedcustomerusage a 
	where a.category='CAPPED' and a.currentstatus='Currently Active'
	group by a.clientcode, a.package
	order by 3 desc
) a
inner join
(
select distinct clientcode, clientname, clientclass from rcbill_my.clientstats 
) b
on a.clientcode=b.clientcode
;

