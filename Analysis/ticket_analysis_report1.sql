show index from rcbill_my.rep_servicetickets_2021 ;

select * from rcbill_my.rep_servicetickets_2021 where ticketid=1014346;

select * from rcbill_my.clientticketsnapshot_f where ticketid=1014346 limit 1000;

select * from  rcbill_my.clientticketsnapshot_irs  ;

select * from rcbill_my.rep_custconsolidated;

select date(opendate) as opendate
, openreason
, OpenRegion, StageRegion
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2,3,4
;

select date(opendate) as opendate
, openreason
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_irs
group by 1,2
;

select date(opendate) as opendate
, openreason
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
;

select date(opendate) as opendate
, OpenRegion as OpenedFrom
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
;

select date(opendate) as opendate
, StageRegion as OpenedTo
, count(*) as tkts, count(distinct clientcode) as accts, count(distinct contractcode) as conts
from rcbill_my.clientticketsnapshot_f
group by 1,2
;


/*

FROM rep_custconsolidated

, clientarea as island, clientlocation as district, subdistrict
, clientparcel, latitude, longitude
, case when clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`
*/

set @fromdate = '2021-01-01';
set @todate = '2021-07-31';

set @fromdate = '2021-08-13';
set @todate = '2021-08-13';

###################### faults tickets

#### level 1

drop table if exists rcbill_my.rep_tkt_f_level1;

create table rcbill_my.rep_tkt_f_level1(index idxrtfl1(open_d),index idxrtfl2(openreason))
(
	select OPEN_D, ISLAND, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS
	from 
	(
		select a.*
		, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
		, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
		, case when b.clientparcel is null then 'Not Present'
				else 'Present' end as `PARCELSTATUS`
		from 
		(
			select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
			, a.OpenRegion as OPENEDFROM
			, a.StageRegion as OPENEDTO, a.CLIENTCODE
            , a.CLIENTNAME
			, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
			, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
			, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
			from 
			rcbill_my.clientticketsnapshot_f a 

			-- where 
			-- (a.open_d>=@fromdate and a.open_d<=@todate)
		) a 
		left join 
			rcbill_my.rep_custconsolidated b 
		on a.CLIENTCODE=b.clientcode

		-- where a.firstcomment not like '%installation done%'
	) a 
	group by 1,2,3
)
;

select count(*) as rep_tkt_f_level1 from rcbill_my.rep_tkt_f_level1;

#### level 2

drop table if exists rcbill_my.rep_tkt_f_level2;

create table rcbill_my.rep_tkt_f_level2(index idxrtfl1(open_d),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict))
(

	select OPEN_D, ISLAND, DISTRICT, SUBDISTRICT, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS
	from 
	(
		select a.*
		, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
		, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
		, case when b.clientparcel is null then 'Not Present'
				else 'Present' end as `PARCELSTATUS`
		from 
		(
			select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
			, a.OpenRegion as OPENEDFROM
			, a.StageRegion as OPENEDTO, a.CLIENTCODE
			, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
			, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
			, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
			from 
			rcbill_my.clientticketsnapshot_f a 

			-- where (a.open_d>=@fromdate and a.open_d<=@todate)
		) a 
		left join 
			rcbill_my.rep_custconsolidated b 
		on a.CLIENTCODE=b.clientcode

		-- where a.firstcomment not like '%installation done%'
	) a 
	group by 1,2,3,4,5
)
;

select count(*) as rep_tkt_f_level2 from rcbill_my.rep_tkt_f_level2;

#### level 3
drop table if exists rcbill_my.rep_tkt_f_level3;

create table rcbill_my.rep_tkt_f_level3(index idxrtfl1(open_d),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict), index idxrtfl5(clientcode))
(
	select a.*
	, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
	, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
	, case when b.clientparcel is null then 'Not Present'
			else 'Present' end as `PARCELSTATUS`
	from 
	(
		select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
        , a.OpenRegion as OPENEDFROM
		, a.StageRegion as OPENEDTO, a.CLIENTCODE
		, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
		, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
		, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
		from 
		rcbill_my.clientticketsnapshot_f a 

		-- where (a.open_d>=@fromdate and a.open_d<=@todate)
	) a 
	left join 
		rcbill_my.rep_custconsolidated b 
	on a.CLIENTCODE=b.clientcode

-- where a.firstcomment not like '%installation done%'
)
;

select count(*) as rep_tkt_f_level3 from rcbill_my.rep_tkt_f_level3;




###################### installation tickets

#### level 1

drop table if exists rcbill_my.rep_tkt_irs_level1;

create table rcbill_my.rep_tkt_irs_level1(index idxrtfl1(open_d),index idxrtfl2(openreason))
(
	select OPEN_D, ISLAND, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS
	from 
	(
		select a.*
		, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
		, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
		, case when b.clientparcel is null then 'Not Present'
				else 'Present' end as `PARCELSTATUS`
		from 
		(
			select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
			, a.OpenRegion as OPENEDFROM
			, a.StageRegion as OPENEDTO, a.CLIENTCODE
			, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
			, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
			, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
			from 
			rcbill_my.clientticketsnapshot_irs a 

			-- where (a.open_d>=@fromdate and a.open_d<=@todate)
		) a 
		left join 
			rcbill_my.rep_custconsolidated b 
		on a.CLIENTCODE=b.clientcode

		-- where a.firstcomment not like '%installation done%'
	) a 
	group by 1,2,3
)
;

select count(*) as rep_tkt_irs_level1 from rcbill_my.rep_tkt_irs_level1;

#### level 2

drop table if exists rcbill_my.rep_tkt_irs_level2;

create table rcbill_my.rep_tkt_irs_level2(index idxrtfl1(open_d),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict))
(

	select OPEN_D, ISLAND, DISTRICT, SUBDISTRICT, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS
	from 
	(
		select a.*
		, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
		, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
		, case when b.clientparcel is null then 'Not Present'
				else 'Present' end as `PARCELSTATUS`
		from 
		(
			select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
			, a.OpenRegion as OPENEDFROM
			, a.StageRegion as OPENEDTO, a.CLIENTCODE
			, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
			, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
			, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
			from 
			rcbill_my.clientticketsnapshot_irs a 

			-- where (a.open_d>=@fromdate and a.open_d<=@todate)
		) a 
		left join 
			rcbill_my.rep_custconsolidated b 
		on a.CLIENTCODE=b.clientcode

		-- where a.firstcomment not like '%installation done%'
	) a 
	group by 1,2,3,4,5
)
;

select count(*) as rep_tkt_irs_level2 from rcbill_my.rep_tkt_irs_level2;

#### level 3

drop table if exists rcbill_my.rep_tkt_irs_level3;

create table rcbill_my.rep_tkt_irs_level3(index idxrtfl1(open_d),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict), index idxrtfl5(clientcode))
(

	select a.*
	, b.clientarea as ISLAND, b.clientlocation as DISTRICT, b.subdistrict AS SUBDISTRICT
	, b.clientparcel AS CLIENTPARCEL, b.latitude AS LATITUDE, b.longitude AS LONGITUDE
	, case when b.clientparcel is null then 'Not Present'
			else 'Present' end as `PARCELSTATUS`
	from 
	(
		select a.ticketid AS TICKETID, a.opendate AS OPENDATE, a.open_d AS OPEN_D, a.openreason AS OPENREASON
        , a.OpenRegion as OPENEDFROM
		, a.StageRegion as OPENEDTO, a.CLIENTCODE
		, a.closedate AS CLOSEDATE, a.close_d AS CLOSE_D, a.CloseRegion as CLOSEDBY, a.CloseReason AS CLOSEREASON
		, a.firstcomment AS FIRSTCOMMENT, a.lastcomment AS LASTCOMMENT
		, a.tkt_alldays AS TKT_ALLDAYS, a.tkt_workdays AS TKT_WORKDAYS, a.tkt_workdays2 AS TKT_WORKDAYS2
		from 
		rcbill_my.clientticketsnapshot_irs a 

		-- where (a.open_d>=@fromdate and a.open_d<=@todate)
	) a 
	left join 
		rcbill_my.rep_custconsolidated b 
	on a.CLIENTCODE=b.clientcode

	-- where a.firstcomment not like '%installation done%'
)
;

select count(*) as rep_tkt_irs_level3 from rcbill_my.rep_tkt_irs_level3;

#########################################################


SELECT * FROM rcbill_my.rep_tkt_irs_level1;

SELECT * FROM rcbill_my.rep_tkt_irs_level2;

SELECT * FROM rcbill_my.rep_tkt_irs_level3;

SELECT * FROM rcbill_my.rep_tkt_f_level1;

SELECT * FROM rcbill_my.rep_tkt_f_level2;

SELECT * FROM rcbill_my.rep_tkt_f_level3;




/*
select a.opendate, a.open_d, openreason, OpenRegion as OpenedFrom
, a.StageRegion as OpenedTo, a.CLIENTCODE
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
rcbill_my.clientticketsnapshot_f a 
left join
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode

where 
(a.open_d>=@fromdate and a.open_d<=@todate)
;


select a.opendate, a.open_d, openreason, OpenRegion as OpenedFrom
, a.StageRegion as OpenedTo, a.CLIENTCODE
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
rcbill_my.clientticketsnapshot_irs a 
left join
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode

where 
(a.open_d>=@fromdate and a.open_d<=@todate)
;



select a.opendate, a.open_d, openreason, OpenRegion as OpenedFrom
, a.StageRegion as OpenedTo, a.CLIENTCODE
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
rcbill_my.clientticketsnapshot_f a 
left join
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode

where 
(a.open_d>=@fromdate and a.open_d<=@todate)
;


select a.opendate, a.open_d, openreason, OpenRegion as OpenedFrom
, a.StageRegion as OpenedTo, a.CLIENTCODE
, b.clientarea as island, b.clientlocation as district, b.subdistrict
, b.clientparcel, b.latitude, b.longitude
, case when b.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`

from 
rcbill_my.clientticketsnapshot_irs a 
left join
rcbill_my.rep_custconsolidated b
on a.CLIENTCODE=b.clientcode

where 
(a.open_d>=@fromdate and a.open_d<=@todate)
;
*/