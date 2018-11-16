set @ticketid=894059;

-- select * from rcbill_my.clientticket_cmmtjourney where ticketid=@ticketid order by commentdate;
-- select * from rcbill_my.clientticket_assgnjourney where ticketid=@ticketid order by ASSGN_CLOSEDATE;
-- select * from rcbill_my.clientticketjourney where ticketid=@ticketid;
-- select * from rcbill_my.clientticketsnapshot_f where ticketid=@ticketid;

-- select * from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';
-- select *, TIMESTAMPDIFF(MINUTE, ASSGN_OPENDATE, ASSGN_CLOSEDATE) as assgnduration from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';
-- select * from rcbill_my.clientticket_assgnjourney where assgntechregion='Approvals' and assgntechuser='Rahul Walavalkar';





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

-- select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;
-- reportdate, currentdebt, clientcode, clientname, clientclass, services, network, activecontracts, clientlocation, firstactivedate, lastactivedate
-- , totalpaymentamount, combined_clientcode, cl_clientcode, b_clientcode, connection_type, mxk_name, mxk_interface, hfc_node, nodename
--  TotalPayments2018, TotalPaymentAmount2018, clean_mxk_name, clean_mxk_interface, clean_hfc_node, clean_hfc_nodename, clean_connection_type
	select * from 
    (
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
        
        and
        (
			(clientarea like '%PRASLIN%') or (clientaddress like '%PRASLIN%') 
			or (mxk_name like '%PRASLIN%') or (clean_mxk_name like '%PRASLIN%')
		)
        
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
on a.clientcode=b.cl_clientcode;




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



