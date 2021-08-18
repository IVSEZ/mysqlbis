select * from rcbill.clientcontractipusage where PACKAGE LIKE ('AMBER%') and USAGEDATE='2021-07-27';

select * from rcbill_my.rep_dailypackageusage where 0=0 and year(USAGEDATE)=2021 and PACKAGE='AMBER' limit 10;

select usagedate as USAGE_DATE, sum(GB_TOTAL) as GB_TOTAL from rcbill_my.rep_dailypackageusage where PACKAGE='AMBER' and year(USAGEDATE)=2020 group by usagedate order by usagedate asc limit 10;

select usagedate as USAGE_DATE, sum(GB_TOTAL) as GB_TOTAL from rcbill_my.rep_dailypackageusage where package='AMBER' and year(usagedate)=2021 group by 1 order by usagedate asc;
select usagedate as USAGE_DATE, sum(GB_TOTAL) as GB_TOTAL from rcbill_my.rep_dailypackageusage where traffictype not in ('FREE','LOCAL') and package='AMBER' and year(usagedate)=2021 group by 1 order by usagedate asc;

select usagedate as USAGE_DATE, traffictype as TRAFFIC_TYPE, sum(GB_TOTAL) as GB_TOTAL 
from rcbill_my.rep_dailypackageusage where PACKAGE='AMBER' and year(USAGEDATE)=2021 
group by 1,2 
order by usagedate asc;

select usagedate as USAGE_DATE, traffictype as TRAFFIC_TYPE, sum(GB_TOTAL) as GB_TOTAL 
from rcbill_my.rep_dailypackageusage where PACKAGE is null and year(USAGEDATE)=2021 
group by 1,2 
order by usagedate asc;

select upper(traffictype),count(*)
from rcbill_my.rep_dailypackageusage
group by 1
;

select upper(traffictype),count(*)
from rcbill_my.rep_dailypackageusage2020
group by 1
;

select upper(traffictype),count(*)
from rcbill_my.rep_dailypackageusage2019
group by 1
;

select upper(package),count(*)
from rcbill_my.rep_dailypackageusage
group by 1
;

select upper(package),count(*)
from rcbill_my.rep_dailypackageusage2020
group by 1
;

select upper(package),count(*)
from rcbill_my.rep_dailypackageusage2019
group by 1
;

(
select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage  where traffictype not in ('FREE','LOCAL')
)
union all
(
select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2020  where traffictype not in ('FREE','LOCAL')
)
union all
(
select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2019  where traffictype not in ('FREE','LOCAL')
)
;

select usagedate as USAGE_DATE, sum(GB_TOTAL) as GB_TOTAL 
from 
( 
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage where traffictype not in ('FREE','LOCAL')
	)
	union all
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2020 where traffictype not in ('FREE','LOCAL')
	)
	union all
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2019 where traffictype not in ('FREE','LOCAL')
	)
) a 
group by 1 order by usagedate asc
;

select usagedate as USAGE_DATE, sum(GB_TOTAL) as GB_TOTAL 
from 
( 
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage 
	)
	union all
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2020 
	)
	union all
	(
	select usagedate, package, gb_total from rcbill_my.rep_dailypackageusage2019 
	)
) a 
group by 1 order by usagedate asc
;

#############################################################################

select usagedate as USAGE_DATE, sum(contracts) as CONTRACTS, sum(GB_TOTAL) as GB_TOTAL 
from 
( 
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage where traffictype not in ('FREE','LOCAL')
	)
	union all
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage2020 where traffictype not in ('FREE','LOCAL')
	)
	union all
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage2019 where traffictype not in ('FREE','LOCAL')
	)
) a 
group by 1 order by usagedate asc
;

select usagedate as USAGE_DATE,  sum(contracts) as CONTRACTS, sum(GB_TOTAL) as GB_TOTAL 
from 
( 
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage 
	)
	union all
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage2020 
	)
	union all
	(
	select usagedate, package, contracts, gb_total from rcbill_my.rep_dailypackageusage2019 
	)
) a 
group by 1 order by usagedate asc
;

#############################################################################


select distinct upper(package) as PACKAGE
from 
( 
	(
	select distinct package from rcbill_my.rep_dailypackageusage
	)
	union all
	(
	select distinct package from rcbill_my.rep_dailypackageusage2020
	)
	union all
	(
	select distinct package from rcbill_my.rep_dailypackageusage2019
	)
) a ;

select distinct TRAFFICTYPE
from 
( 
	(
	select distinct TRAFFICTYPE from rcbill_my.rep_dailypackageusage
	)
	union all
	(
	select distinct TRAFFICTYPE from rcbill_my.rep_dailypackageusage2020
	)
	union all
	(
	select distinct TRAFFICTYPE from rcbill_my.rep_dailypackageusage2019
	)
) a ;