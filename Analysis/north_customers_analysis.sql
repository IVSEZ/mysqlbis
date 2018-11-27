use rcbill_my;
set @reportdate='2018-11-25';
SET @rundate='2018-11-25';

/*
-- All
select distinct date(now()) as reportdate, a.ClientCode, b.network, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, b.lastactivedate
from 
(
select clientcode, network, max(period) as lastactivedate
from 
rcbill_my.customercontractactivity 
where clientcode in 
(
	select a.ClientCode 
	from 
	rcbill.rcb_clientaddress a
	where
		a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
    or
		a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
		or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
		or a.clientaddress like '%beau  valon%'
    or
		a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
    or
		a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
)
and network is not null
group by clientcode, network
) b
right join
(
	select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
	from 
	rcbill.rcb_clientaddress a
	where 
		a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
    or
		a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
		or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
		or a.clientaddress like '%beau  valon%'
    or
		a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
    or
		a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
) a
on 
b.clientcode=a.clientcode
where b.lastactivedate
;
*/

-- drop table if exists rcbill_my.customers_north;
-- duration 573.422 sec

-- create table rcbill_my.customers_north as
insert into rcbill_my.customers_north
(
	-- NORTH Customers with Client Stats
	select @reportdate as ReportDate, a.*
    ,
	case 
			when a.dayssincelastactive=0 then '1. Alive' 
			when a.dayssincelastactive>0 and a.dayssincelastactive<=7 then '2. Snoozing'
			when a.dayssincelastactive>7 and a.dayssincelastactive<=30 then '3. Asleep'
			when a.dayssincelastactive>30 and a.dayssincelastactive<=90 then '4. Hibernating'
			when a.dayssincelastactive>90 then '5. Dormant'
            when a.dayssincelastactive is null then '5. Dormant'    
	end as `ActivityStatus` 
    , 
    b.*
	,
	case 
	when b.clientcode_b is null then 'InActive' 
	else 'Active'
	end as `ClientIsActive` 
	from 
	(
			select a.ClientCode, b.network, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation, b.lastactivedate
            , rcbill_my.GetActiveDaysForClient(a.clientcode) as ClientActiveDays,
			datediff(@rundate,b.lastactivedate) as dayssincelastactive
			from 
			(
				select clientcode, network, max(period) as lastactivedate
				from 
				rcbill_my.customercontractactivity 
				where clientcode in 
				(
					select a.ClientCode 
					from 
					rcbill.rcb_clientaddress a

					where 
						a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
					or
						a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
						or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
						or a.clientaddress like '%beau  valon%'
					or
						a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
					or
						a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
				)
				and network is not null
				group by clientcode
                , network
			) b
			right join
			(
				select a.ClientCode, a.ClientName,a.ClientAddress,a.ClientArea,a.ClientLocation 
				from 
				rcbill.rcb_clientaddress a
				where 
					a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
				or
					a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
					or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
					or a.clientaddress like '%beau  valon%'
				or
					a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
				or
					a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
			) a
			on 
			b.clientcode=a.clientcode
			-- where b.lastactivedate
	) a 
	left join 
	(
		select clientcode as clientcode_b, services, clientclass, clienttype
		, `Elite`, `Extreme`, `Extreme Plus`, `Crimson`, `Performance`, `Performance Plus`, `Intel Data 10`,`Basic`,`Executive`,`Prestige`,`Extravagance`,`Extravagance Corporate`
		, `Amber`, `Amber Corporate`, `Crimson Corporate`, `DualView`, `MultiView`, `VOD`, `Starter`, `Value`
		 from rcbill_my.clientstats
	) b 
	on a.ClientCode=b.clientcode_b
)
;

select * from rcbill_my.customers_north order by clientname;

select * from rcbill_my.customers_north where clientisactive='Active' and activitystatus not in ('1. Alive');

select * from rcbill_my.customers_north where ReportDate=@reportdate and lastactivedate is not null and clientcode='I18317' and clientisactive='Active' and activitystatus not in ('1. Alive');

select distinct clientcode from rcbill_my.customers_north where ReportDate=@reportdate and lastactivedate is not null;

/*
select period, periodday, periodmth, periodyear, clientcode, clientname, contractcode, count(contractcode) as contractactivedays from rcbill_my.customercontractactivity 
-- limit 1000 
where clientcode in (select clientcode from rcbill_my.customers_north) and period>='2017-09-01'
group by period, periodday, periodmth, periodyear, clientcode, clientname, contractcode
;
*/


set sql_safe_updates=0;

-- delete from rcbill_my.customers_north where reportdate=@reportdate;

-- update rcbill_my.customers_north
-- set network=NULL where network='NULL'
-- set firstactivedate=NULL where firstactivedate='0000-00-00'
-- set lastactivedate=NULL where lastactivedate='0000-00-00'
-- set ActivityStatus=NULL where ActivityStatus='NULL'
-- set clientcode_b=NULL where clientcode_b='NULL'
-- set services=NULL where services='NULL'
-- set clientclass=NULL where clientclass='NULL'
-- set clienttype=NULL where clienttype='NULL'
-- set clienttype=NULL where clienttype='NULL'

;