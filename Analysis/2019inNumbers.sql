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
SELECT year(orderday) as orderyear, salestype, sum(ordercount) as orders from rcbill_my.rep_dailysales group by 1,2;
SELECT year(orderday) as orderyear, month(orderday) as ordermonth, salestype, sum(ordercount) as orders 
from rcbill_my.rep_dailysales group by 1,2,3;




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
;

####################################################################################################

