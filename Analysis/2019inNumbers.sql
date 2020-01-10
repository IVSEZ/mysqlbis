#######
/*
ORDERS CREATED
INSTALLATION TICKETS
GPON CONVERSIONS
TICKETS RAISED
CALLS MADE
ONLINE PAYMENTS
BIGGEST COLLECTIONS
MOST ACTIVE
LEAST ACTIVE
MOST TV WATCHED
MOST VOD WATCHED
TOP 10 MOVIES / SERIES
DATA USED CAPPED VS UNCAPPED


*/

####################################################################################################
## SALES ORDERS


-- select * from rcbill_my.rep_dailysales where salescenter='Sales' order by orderday desc;
-- select * from rcbill_my.rep_dailysalesreg where salescenter='Sales' order by orderday desc;
SELECT year(orderday) as orderyear, salestype, sum(ordercount) as orders from rcbill_my.rep_dailysales group by 1,2 order by 1 desc;
SELECT year(orderday) as orderyear, month(orderday) as ordermonth, salestype, sum(ordercount) as orders 
from rcbill_my.rep_dailysales group by 1,2,3
order by 1 desc, 2 desc;


SELECT year(orderday) as orderyear, month(orderday) as ordermonth, salestype, sum(`Mahe`) as `Mahe`, sum(`Praslin`) as `Praslin`
, sum(`Unknown`) as `Unknown`
from rcbill_my.rep_dailysalesreg group by 1,2,3
order by 1 desc, 2 desc;


select year(firstactivedate) as firstactiveyear, IsAccountActive, AccountActivityStage, count(clientcode) as clients
from rcbill_my.rep_custconsolidated 
group by 1, 2, 3
order by 1 desc
;


####################################################################################################

#TICKETS
-- select * from rcbill_my.rep_servicetickets_2019 limit 100;
-- select * from rcbill_my.rep_servicetickets_2018 limit 100;

drop table if exists rcbill_my.temptkt;
create table rcbill_my.temptkt as 
(
select ticketid, service, opendate, clientcode, tickettype from rcbill_my.rep_servicetickets_2019
)
union all
(
select ticketid, service, opendate, clientcode, tickettype from rcbill_my.rep_servicetickets_2018
)
;

select 
year(opendate) as tkt_year
,month(opendate) as tkt_month
,case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, service
, tickettype
, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2,3,4,5
;

select 
year(opendate) as tkt_year
,month(opendate) as tkt_month
,case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
-- , service

, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2,3
;

select 
year(opendate) as tkt_year
,case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, service
-- , month(opendate) as tkt_month
, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2,3
;

select 
year(opendate) as tkt_year
,case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, tickettype
-- , month(opendate) as tkt_month
, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2,3
;

select 
year(opendate) as tkt_year
, case when (service = 'gNet' or service='gVOICE' or service='IPTV') then 'GPON Services'
		when (service = 'Internet' or service='VOIP' or service='DTV') then 'HFC Services'
		else 'UNKNOWN' 
        end as `services_type`
, service
, tickettype
, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2, 3, 4
;

select year(opendate) as tkt_year, month(opendate) as tkt_month, tickettype, count(distinct ticketid) as tkt_count, count(distinct clientcode) as client_count
from rcbill_my.temptkt
group by 1,2,3
;

####################################################################################################

## GPON CONVERSIONS

select gponyear, gponmonth
-- , clientlocation
, case when clientlocation='BEL OMBRE' then 'BELOMBRE' 
	else clientlocation end as clientlocation
, count(distinct clientcode) as gpon_client
from
(

	select a.clientcode, a.currentdebt, a.IsAccountActive, a.AccountActivityStage, c.TKT_MONTH as GPONMonth, c.TKT_YEAR as GPONYear
	, a.clientname, a.clientemail, a.clientnin, a.clientpassport, a.clientphone
	, a.clientclass, a.activenetwork, a.activeservices, a.clientaddress
	, b.a1_parcel, b.a2_parcel, b.a3_parcel
	, a.clientlocation
	, a.clean_mxk_name, a.clean_mxk_interface, a.clean_hfc_nodename, a.clean_hfc_node
	, a.firstactivedate, a.lastactivedate, a.TotalPaymentAmount2019, a.AvgMonthlyPayment2019 


	from rcbill_my.rep_custconsolidated a 
	inner join 
	(
		select distinct clientcode, month(opendate) as TKT_MONTH, year(OPENDATE) as TKT_YEAR 
		from rcbill_my.clientticket_cmmtjourney 
		where 
		(comment like '%GPON conversion%')

	) c 
	on a.clientcode=c.clientcode
	left join
	rcbill.rcb_clientparcels b
	on 
	a.CLIENTCODE=b.clientcode
) a
group by 1,2,3
order by 1 desc, 2 desc
;

####################################################################################################

## CALLS MADE

-- select * from rcbill_my.rep_cccallreport;
select year(calldate) as callyear
, callstatus
-- , shift
, SEC_TO_TIME(AVG(TIME_TO_SEC(waittime))) as avg_waittime, SEC_TO_TIME(AVG(TIME_TO_SEC(talktime))) as avg_talktime
, count(*) as calls
, count(distinct callernumber) as d_callers
from rcbill_my.rep_cccallreport
group by 1,2 -- ,3
order by 1 desc
;

-- select * from rcbill_my.dailycalls;
select year(calldate) as callyear
, CALLEVENTNAME, SEC_TO_TIME(AVG(TIME_TO_SEC(waittime))) as avg_waittime, SEC_TO_TIME(AVG(TIME_TO_SEC(talktime))) as avg_talktime
, count(*) as calls
, count(distinct callnumber) as d_callers
from rcbill_my.dailycalls
group by 1,2
order by 1 desc
;

select year(calldate) as callyear, hour(calldate) as callhour
, CALLEVENTNAME, SEC_TO_TIME(AVG(TIME_TO_SEC(waittime))) as avg_waittime, SEC_TO_TIME(AVG(TIME_TO_SEC(talktime))) as avg_talktime
, count(*) as calls
, count(distinct callnumber) as d_callers
from rcbill_my.dailycalls
group by 1,2, 3
order by 1 desc
;

####################################################################################################

## COLLECTIONS
-- select * from rcbill_my.rep_paycol_channel;
-- select * from rcbill_my.rep_paycol_pos;

select payyear, pay_pos, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_pos
group by 1,2
order by 1 desc, 3 desc
;


select payyear, pay_channel, sum(pay_amount) as pay_amount
from rcbill_my.rep_paycol_channel
group by 1,2
order by 1 desc, 3 desc
;


-- select * from rcbill_my.rep_customers_collection2018;
-- select * from rcbill_my.rep_customers_collection2019;

select sum(totalpaymentamount2019) from rcbill_my.rep_customers_collection2019;
select sum(totalpaymentamount2018) from rcbill_my.rep_customers_collection2018;

select a.*, b.IsAccountActive, b.AccountActivityStage, b.TotalPaymentAmount2019, b.totalpaymentamount
from 
(
	(
	select 2018 as paymentyear, clientcode, clientname, clientclass, totalpayments2018 as totalpayments, totalpaymentamount2018 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2018
	where clientclass='CORPORATE LARGE'
	order by totalpaymentamount2018 desc
	limit 20
	) 
	union
	(
	select 2018 as paymentyear, clientcode, clientname, clientclass, totalpayments2018 as totalpayments, totalpaymentamount2018 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('CORPORATE BUNDLE','CORPORATE BULK')
	order by totalpaymentamount2018 desc
	limit 20
	)
	union
	(
	select 2018 as paymentyear, clientcode, clientname, clientclass, totalpayments2018 as totalpayments, totalpaymentamount2018 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('CORPORATE LITE')
	order by totalpaymentamount2018 desc
	limit 20
	)
	union
	(
	select 2018 as paymentyear, clientcode, clientname, clientclass, totalpayments2018 as totalpayments, totalpaymentamount2018 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('RESIDENTIAL') and clientcode not in ('I.000015720') -- HIKVISION
	order by totalpaymentamount2018 desc
	limit 20
	)

	-- ==============================================================
	union
	(
	select 2019 as paymentyear, clientcode, clientname, clientclass, totalpayments2019 as totalpayments, totalpaymentamount2019 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2019
	where clientclass='CORPORATE LARGE'
	order by totalpaymentamount2019 desc
	limit 20
	)
	union
	(
	select 2019 as paymentyear, clientcode, clientname, clientclass, totalpayments2019 as totalpayments, totalpaymentamount2019 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('CORPORATE BUNDLE','CORPORATE BULK')
	order by totalpaymentamount2019 desc
	limit 20
	)
	union
	(
	select 2019 as paymentyear, clientcode, clientname, clientclass, totalpayments2019 as totalpayments, totalpaymentamount2019 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('CORPORATE LITE')
	order by totalpaymentamount2019 desc
	limit 20
	)
	union
	(
	select 2019 as paymentyear, clientcode, clientname, clientclass, totalpayments2019 as totalpayments, totalpaymentamount2019 as totalpaymentamountyear
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('RESIDENTIAL') and clientcode not in ('I.000015720') -- HIKVISION
	order by totalpaymentamount2019 desc
	limit 20
	)
)
a
left join
rcbill_my.rep_custconsolidated b 
on a.CLIENTCODE=b.clientcode
;

drop table if exists temp1;
create table temp1 as 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2018
	where clientclass='CORPORATE LARGE'
	order by totalpaymentamount2018 desc
	limit 30
	) 
	union
	(
	select clientcode
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('CORPORATE BUNDLE','CORPORATE BULK')
	order by totalpaymentamount2018 desc
	limit 30
	)
	union
	(
	select clientcode
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('CORPORATE LITE')
	order by totalpaymentamount2018 desc
	limit 30
	)
	union 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2018
	where clientclass in ('RESIDENTIAL') and clientcode not in ('I.000015720') -- HIKVISION
	order by totalpaymentamount2018 desc
	limit 30
	)

	-- ==============================================================
	union 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2019
	where clientclass='CORPORATE LARGE'
	order by totalpaymentamount2019 desc
	limit 30
	)
	union 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('CORPORATE BUNDLE','CORPORATE BULK')
	order by totalpaymentamount2019 desc
	limit 30
	)
	union 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('CORPORATE LITE')
	order by totalpaymentamount2019 desc
	limit 30
	)
	union 
	(
	select clientcode
	from rcbill_my.rep_customers_collection2019
	where clientclass in ('RESIDENTIAL') and clientcode not in ('I.000015720') -- HIKVISION
	order by totalpaymentamount2019 desc
	limit 30
	)
;

select clientcode, clientname, clientclass, IsAccountActive, AccountActivityStage, TotalPaymentAmount2018, TotalPaymentAmount2019, totalpaymentamount
from rcbill_my.rep_custconsolidated 
where clientcode in 
(
select clientcode from temp1
)
;

drop table if exists temp1;



select distinct clientclass from rcbill_my.rep_customers_collection2018;
####################################################################################################

## ACTIVE NUMBERS

-- select * from rcbill_my.rep_activenumberlastday_pv;
select servicecategory, package
, `20161231`
, `20171231`
, `20181231`
, `20191231`
 from rcbill_my.rep_activenumberlastday_pv;
 
 select * from rcbill_my.rep_activenumberlastday where period in ('2016-12-31','2017-12-31','2018-12-31','2019-12-31');
 
####################################################################################################

## PER LOCATION

select * from rcbill_my.rep_custconsolidated;
select * from rcbill.rcb_clientaddress;


####################################################################################################

## VOD

-- select * from rcbill.rcb_vodtitles where titletype='N';
select 
year(UPLOADDATE) as uploadyear, TITLETYPE, count(TITLE) as titles
from 
rcbill.rcb_vodtitles 
where id>1000
group by 1,2
order by 1 desc
;

-- select * from rcbill_my.rep_vodpivot2018;

(
SELECT 2018 as VODYEAR 
    , IFNULL(TITLE,
            rcbill.GetVODTitleFromResource(RESOURCE)) AS TITLE
            , rcbill.GetVODTypeFromResource(RESOURCE) as TITLETYPE
            , TOTAL_DURATION
FROM
    rcbill_my.rep_vodpivot2018
where title is null
ORDER BY total_duration DESC
)
union
(
SELECT 2019 as VODYEAR 
   , IFNULL(TITLE,
            rcbill.GetVODTitleFromResource(RESOURCE)) AS TITLE
            , rcbill.GetVODTypeFromResource(RESOURCE) as TITLETYPE
            , TOTAL_DURATION
FROM
    rcbill_my.rep_vodpivot2019
where title is null
ORDER BY total_duration DESC
)
;

####################################################################################################
