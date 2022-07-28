
drop table if exists rcbill_my.rep_servicetickets_2018;

create table rcbill_my.rep_servicetickets_2018 as 
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
			when year(a.assgnopendate)=2018 and month(a.assgnopendate) in (1,2) then 0
			when year(a.assgnopendate)=2018 and month(a.assgnopendate) in (3) then 3
			when year(a.assgnopendate)=2018 and month(a.assgnopendate) not in (1,2,3) then 2 
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
                , ticketstate, ASSGN_STATE

				, sum(tkt_alldays) as service_alldays, sum(tkt_workdays) as service_workdays
                , sum(tkt_workdays2) as service_workdays2
				from rcbill_my.clientticket_assgnjourney
				-- where assgntechregion in ('TECHNICAL - NEW SERVICE','TECHNICAL - WORK ORDER MANAGEMENT')
				where year(OPENDATE)=2018
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

CREATE INDEX IDXrst1 ON rcbill_my.rep_servicetickets_2018 (assgntechregion);
CREATE INDEX IDXrst2 ON rcbill_my.rep_servicetickets_2018 (assgnopendate);

select count(*) as rep_servicetickets_2018 from rcbill_my.rep_servicetickets_2018;