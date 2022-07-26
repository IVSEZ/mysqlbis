-- set @ticketid=894059;

-- select * from rcbill_my.clientticket_cmmtjourney where ticketid=@ticketid order by commentdate;
-- select * from rcbill_my.clientticket_assgnjourney where ticketid=@ticketid order by ASSGN_CLOSEDATE;
-- select * from rcbill_my.clientticketjourney where ticketid=@ticketid;
-- select * from rcbill_my.clientticketsnapshot_f where ticketid=@ticketid;
-- select * from rcbill_my.clientticket_assgnjourney order by ticketid desc, assgn_opendate asc;
-- select * from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';
-- select *, TIMESTAMPDIFF(MINUTE, ASSGN_OPENDATE, ASSGN_CLOSEDATE) as assgnduration from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';
-- select * from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';
-- select * from rcbill_my.clientticket_assgnjourney where assgntechregion='RC BOSS' and assgntechuser='Rahul Walavalkar';



drop table if exists rcbill_my.rep_servicetickets_2022;

create table rcbill_my.rep_servicetickets_2022 as 
(
	select a.*
    -- , (a.priceperday * a.penaltydays) as penaltyamount
    ,case when a.agreeddays>0 and a.service_workdays2>a.agreeddays then (a.service_workdays2-a.agreeddays) end as penaltydays
		-- else 0 end as penaltydays
    ,case when a.agreeddays>0 and a.service_workdays2>a.agreeddays then round(((a.service_workdays2-a.agreeddays)*a.priceperday),2) end as penaltyamount
		-- else 0 end as penaltyamount
    from 
    (
		select a.*, b.*
        -- ,
		-- , (select packageprice from rcbill_my.packagelist where package=a.package and servicesubcategory=a.network) as packageprice
		, round((select sum(price) from rcbill_my.customercontractsnapshot where contractcode=a.contractcode),2) as packageprice
		, round(((select sum(price) from rcbill_my.customercontractsnapshot where contractcode=a.contractcode)/30),2) as priceperday
        , case 

            when year(a.assgnopendate)=2022 then 2 
            end as agreeddays
        
		from 
		(

				select ticketid, service, clientcode as client_code, contractcode, tickettype
				, openreason
                , opentechregion
                , openuser
				, assgntechregion
				, assgntechuser
                , closeuser
				-- , date(opendate) as opendate, date(CLOSEDATE) as closedate
				-- , date(ASSGN_OPENDATE) as assgnopendate, date(ASSGN_CLOSEDATE) as assgnclosedate
				, opendate as opendate, CLOSEDATE as closedate
				, ASSGN_OPENDATE as assgnopendate, ASSGN_CLOSEDATE as assgnclosedate
				, WORKING_MINUTES, WORKING_HOURS
                , ACTUAL_MINUTES, ACTUAL_HOURS

				, OPEN_DAY, CLOSE_DAY, OPEN_HOLIDAY, CLOSE_HOLIDAY                
                
                -- , (select package from rcbill_my.customercontractsnapshot where contractcode=contractcode) as package

				, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
                , sum(tkt_workdays2) as service_workdays2
				from rcbill_my.clientticket_assgnjourney
				-- where assgntechregion in ('TECHNICAL - NEW SERVICE','TECHNICAL - WORK ORDER MANAGEMENT')
				where year(OPENDATE)=2022
				group by ticketid, service, clientcode, contractcode, tickettype, openreason
                , opentechregion
                , openuser
				, assgntechregion
				, assgntechuser
                , closeuser
                , opendate, CLOSEDATE, ASSGN_OPENDATE, ASSGN_CLOSEDATE
                -- , 12
                order by opendate, ASSGN_OPENDATE

		) a
		left join
		(

		-- select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;
		-- reportdate, currentdebt, clientcode, clientname, clientclass, services, network, activecontracts, clientlocation, firstactivedate, lastactivedate
		-- , totalpaymentamount, combined_clientcode, cl_clientcode, b_clientcode, connection_type, mxk_name, mxk_interface, hfc_node, nodename
		--  TotalPayments2018, TotalPaymentAmount2018, clean_mxk_name, clean_mxk_interface, clean_hfc_node, clean_hfc_nodename, clean_connection_type
			select * from 
			(
				/*
				select cl_clientcode, combined_clientcode, reportdate, clientname, services, network, activecontracts, clientlocation
				, (select clientaddress from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientaddress
				, (select clientarea from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientarea
				,  firstactivedate, lastactivedate, totalpaymentamount
				, TotalPaymentAmount2018
				, mxk_name, mxk_interface
				, hfc_node, nodename
				-- , clean_connection_type
				, clean_mxk_name, clean_mxk_interface, clean_hfc_node, clean_hfc_nodename, clean_connection_type
				from rcbill_my.rep_cust_cont_payment_cmts_mxk 
				*/
				
				select * from rcbill_my.rep_custconsolidated
			) a
			where 
			(
				0=0 
				-- PERSEVERANCE
				/*
				and 
				(
					(clientlocation like '%PERSEVERANCE%')
					or (clientarea like '%PERSEVERANCE%') or (clientaddress like '%PERSEVERANCE%') 
					or (mxk_name like '%PERSEVERANCE%') or (clean_mxk_name like '%PERSEVERANCE%')
				)
				*/
				-- PRASLIN
				/*
				and
				(
					(clientarea like '%PRASLIN%') or (clientaddress like '%PRASLIN%') 
					or (mxk_name like '%PRASLIN%') or (clean_mxk_name like '%PRASLIN%')
				)
				*/
				/*
				and
				(
					-- (clientarea not like '%PRASLIN%') and (clientaddress not like '%PRASLIN%') 
					-- and (mxk_name not like '%PRASLIN%') and 
					(clean_mxk_name not like '%PRASLIN%') or (clean_mxk_name is null)
				)
				*/
				-- EDEN ISLAND
				/*
				and
				(
				
					(clientlocation like '%EDEN ISLAND%')
					or (clientarea like '%EDEN ISLAND%') or (clientaddress like '%EDEN ISLAND%') 
					or (mxk_name like '%EDEN ISLAND%') or (clean_mxk_name like '%EDEN ISLAND%')
				
				)
				*/
				-- BEAU VALLON
				/*
				and 
				(
				-- (clientlocation like '%BEAU VALLON%')
				-- or (clientarea like '%BEAU VALLON%') or (clientaddress like '%BEAU VALLON%') 
				-- or (mxk_name like '%MXK-BEAUVALLON%') 
				-- or 
				(clean_mxk_name like '%MXK-BEAUVALLON%')   
				)
				*/
				
				/*
				and
				(
					activecontracts>0
				)
				*/
			)
			

		) b
		-- on a.clientcode=b.cl_clientcode;
		on a.client_code=b.clientcode
        order by a.opendate, a.assgnopendate
	) a order by a.opendate, a.assgnopendate
)
;

-- show index from rcbill_my.rep_servicetickets_2022;

-- drop index idx1 on rcbill_my.rep_servicetickets_2022;
-- drop index idx2 on rcbill_my.rep_servicetickets_2022;

CREATE INDEX IDXrst1 ON rcbill_my.rep_servicetickets_2022 (assgntechregion);
CREATE INDEX IDXrst2 ON rcbill_my.rep_servicetickets_2022 (assgnopendate);

select count(*) as rep_servicetickets_2022 from rcbill_my.rep_servicetickets_2022;
-- select * from rcbill_my.rep_servicetickets_2022;



########### TICKET REPORTS


drop table if exists rcbill_my.rep_tkt_f_level1;

create table rcbill_my.rep_tkt_f_level1(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason))
(
	select OPEN_D, ISLAND, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS, count(distinct contractcode) as CONTRACTS
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
			, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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

create table rcbill_my.rep_tkt_f_level2(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict))
(

	select OPEN_D, ISLAND, DISTRICT, SUBDISTRICT, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS, count(distinct contractcode) as CONTRACTS
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
			, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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

create table rcbill_my.rep_tkt_f_level3(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict), index idxrtfl5(clientcode))
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
		, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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

create table rcbill_my.rep_tkt_irs_level1(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason))
(
	select OPEN_D, ISLAND, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS, count(distinct contractcode) as CONTRACTS
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
			, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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

create table rcbill_my.rep_tkt_irs_level2(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict))
(

	select OPEN_D, ISLAND, DISTRICT, SUBDISTRICT, OPENREASON, count(TICKETID) as TICKETS, count(distinct CLIENTCODE) as CLIENTS, count(distinct contractcode) as CONTRACTS
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
			, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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

create table rcbill_my.rep_tkt_irs_level3(index idxrtfl1(open_d),index idxrtfl11(ISLAND),index idxrtfl2(openreason),index idxrtfl3(district),index idxrtfl4(subdistrict), index idxrtfl5(clientcode))
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
		, a.StageRegion as OPENEDTO, a.CLIENTCODE, a.contractcode
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













/*
select * 
, case 
	when service in ('IPTV','gNET','gVOICE') then 'GPON'
    when service in ('DTV','Internet','VOIP') then 'HFC'
    end as `NETWORK`
    
from rcbill_my.rep_servicetickets_2022
;
*/

-- select * from rcbill_my.rep_servicetickets_2022 where ticketid=909247;
-- select *, (packageprice/30) as  priceperday from rcbill_my.rep_servicetickets_2022 where ticketid=910797;

/*
-- tickets opened last month
select date(opendate) as opendate, count(ticketid), count(distinct ticketid) from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by 1
with rollup
;

select date(opendate) as opendate, count(ticketid), count(distinct ticketid) from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
group by 1
with rollup
;


select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
-- and service='Internet'
;


select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
;

select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
and clean_hfc_nodename is null
;


select assgntechregion, count(ticketid) as tickets from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by assgntechregion 
order by 2 desc
;
select assgntechregion, count(distinct ticketid) as d_tickets from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by assgntechregion 
order by 2 desc
;

select clean_hfc_nodename, count(ticketid) as tickets from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by clean_hfc_nodename 
order by 2 desc
;

select clean_hfc_nodename, count(distinct ticketid) as d_tickets from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by clean_hfc_nodename 
order by 2 desc
;


### REPORT FOR MLADEN - INTERNET TICKETS OPENED IN PAST MONTH PER NODE
select clean_hfc_nodename
, count(ticketid) as tickets
, count(distinct ticketid) as d_tickets, count(distinct clientcode) as d_clients from rcbill_my.rep_servicetickets_2022 
where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
group by clean_hfc_nodename 
order by 2 desc
;

select clean_hfc_nodename, count(distinct ticketid) as d_tickets from rcbill_my.rep_servicetickets_2022 
where month(opendate)=4 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
group by clean_hfc_nodename 
order by 2 desc
;

select clean_hfc_nodename
-- , count(ticketid) as tickets
, count(distinct ticketid) as d_tickets, count(distinct clientcode) as d_clients from rcbill_my.rep_servicetickets_2022 
where month(opendate)=4 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
group by clean_hfc_nodename 
order by 2 desc
;



select clean_hfc_nodename, clientlocation, count(distinct ticketid) as d_tickets from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and service='Internet'
group by clean_hfc_nodename, clientlocation 
order by 3 desc
;

select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and (clean_connection_type = 'HFC' or clean_connection_type is null) and (activenetwork not in ('GPON' , 'GPON|MOBILE TV', 'GPON|GPON') or activenetwork is null)
and clean_connection_type is null
;


*/

/*
select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
-- and connection_type REGEXP 'HFC'
and clean_connection_type <> 'GPON'
;





select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and clean_connection_type in ('HFC')
;

select * from rcbill_my.rep_servicetickets_2022 where month(opendate)=5 and year(opendate)=2022
and clean_connection_type is null
;

*/



/*
select distinct clientlocation from rcbill_my.rep_cust_cont_payment_cmts_mxk ;

select *, (select clientaddress from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientaddress
		, (select clientarea from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientarea from rcbill_my.rep_cust_cont_payment_cmts_mxk 
        where 
        (mxk_name like '%MXK-BEAUVALLON%') 
        or 
        (clean_mxk_name like '%MXK-BEAUVALLON%') ;


select ticketid, service, clientcode, contractcode, tickettype
, date(opendate) as opendate, date(CLOSEDATE) as closedate
, date(ASSGN_OPENDATE) as assgnopendate, date(ASSGN_CLOSEDATE) as assgnclosedate
, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
from rcbill_my.clientticket_assgnjourney where assgntechregion in ('PRASLIN TECH - SERVICE')
group by ticketid, service, clientcode, contractcode, tickettype, 6, 7
-- , 8, 9
;


select ticketid, service, clientcode, contractcode, tickettype
, date(opendate) as opendate, date(CLOSEDATE) as closedate
, date(ASSGN_OPENDATE) as assgnopendate, date(ASSGN_CLOSEDATE) as assgnclosedate
, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
from rcbill_my.clientticket_assgnjourney where assgntechregion in ('TECHNICAL - NEW SERVICE','TECHNICAL - WORK ORDER MANAGEMENT')
group by ticketid, service, clientcode, contractcode, tickettype, 6, 7
-- , 8, 9
;





-- EDEN TICKETS

select a.*, b.*
from 
(

		select ticketid, service, clientcode, contractcode, tickettype
        , openreason
        , assgntechregion
		, date(opendate) as opendate, date(CLOSEDATE) as closedate
		, date(ASSGN_OPENDATE) as assgnopendate, date(ASSGN_CLOSEDATE) as assgnclosedate
		, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
		from rcbill_my.clientticket_assgnjourney
        -- where assgntechregion in ('TECHNICAL - NEW SERVICE','TECHNICAL - WORK ORDER MANAGEMENT')
		group by ticketid, service, clientcode, contractcode, tickettype, openreason, assgntechregion, 7, 8

) a
inner join
(
	select cl_clientcode, combined_clientcode, reportdate, clientname, services, network, activecontracts, clientlocation
	, (select clientaddress from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientaddress
    , (select clientarea from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientarea
	,  firstactivedate, lastactivedate, totalpaymentamount, mxk_name, mxk_interface, clean_mxk_name
    , hfc_node, nodename, TotalPaymentAmount2018, clean_connection_type
	from rcbill_my.rep_cust_cont_payment_cmts_mxk where clientlocation='EDEN ISLAND'

) b
on a.clientcode=b.cl_clientcode;


select distinct clientarea from rcbill_my.rep_allcust;
select distinct clientlocation from rcbill_my.rep_cust_cont_payment_cmts_mxk;



-- PRASLIN TICKETS

select a.*, b.*
from 
(

		select ticketid, service, clientcode, contractcode, tickettype
        , openreason
        , assgntechregion
		, date(opendate) as opendate, date(CLOSEDATE) as closedate
		, date(ASSGN_OPENDATE) as assgnopendate, date(ASSGN_CLOSEDATE) as assgnclosedate
		, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
		from rcbill_my.clientticket_assgnjourney
        -- where assgntechregion in ('TECHNICAL - NEW SERVICE','TECHNICAL - WORK ORDER MANAGEMENT')
		group by ticketid, service, clientcode, contractcode, tickettype, openreason, assgntechregion, 7, 8

) a
inner join
(
	select * from 
    (
		select cl_clientcode, combined_clientcode, reportdate, clientname, services, network, activecontracts, clientlocation
		, (select clientaddress from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientaddress
		, (select clientarea from rcbill_my.rep_allcust where clientcode=cl_clientcode) as clientarea
		,  firstactivedate, lastactivedate, totalpaymentamount, mxk_name, mxk_interface, clean_mxk_name
		, hfc_node, nodename, TotalPaymentAmount2018, clean_connection_type
		from rcbill_my.rep_cust_cont_payment_cmts_mxk 
	) a
    where 
    (
		(clientarea like '%PRASLIN%') or (clientaddress like '%PRASLIN%') 
		or (mxk_name like '%PRASLIN%') or (clean_mxk_name like '%PRASLIN%')
    )
    

) b
on a.clientcode=b.cl_clientcode;


-- PERSEVERANCE TICKETS
*/



