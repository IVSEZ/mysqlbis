-- I7147
-- I.000011509

    drop table if exists rcbill_my.tempa;
	create table rcbill_my.tempa(index idxtempa1(CL_CLIENTCODE), index idxtempa2(CON_CONTRACTCODE)) as
    (
    select CL_CLIENTCODE, CON_CONTRACTCODE, connection_type,client_code, contract_code, mxk_name, mxk_interface, hfc_node, nodename
	from rcbill_my.customers_contracts_cmts_mxk
	group by CL_CLIENTCODE, CON_CONTRACTCODE,  connection_type,client_code, contract_code, mxk_name,mxk_interface,hfc_node,nodename	
    );


	drop table if exists rcbill_my.tempb;
    create table rcbill_my.tempb(index idxtempb1(b_clientcode), index idxtempb2(b_contractcode))
    as
    (
		select clientcode as b_clientcode, contractcode as b_contractcode, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018
        from rcbill_my.customers_contracts_collection_pivot2018     
    );

drop table if exists rcbill_my.cust_cont_payment_cmts_mxk;

create table rcbill_my.cust_cont_payment_cmts_mxk 
(index idxccpcm1(cl_clientcode),index idxccpcm2(CON_CONTRACTCODE),index idxccpcm3(b_clientcode),index idxccpcm4(b_contractcode))
as
(
select a.*, b.*
from
rcbill_my.tempa	a 
left join
rcbill_my.tempb b
on a.CL_CLIENTCODE=b.b_clientcode
and a.CON_CONTRACTCODE=b.b_contractcode      
)
union 
(
select a.*, b.*
from
rcbill_my.tempa a 
right join
rcbill_my.tempb b
on a.CL_CLIENTCODE=b.b_clientcode
and a.CON_CONTRACTCODE=b.b_contractcode 
)

;        

drop table if exists rcbill_my.rep_cust_cont_payment_cmts_mxk;

create table rcbill_my.rep_cust_cont_payment_cmts_mxk 
(index rccpcm1(clientcode),index rccpcm2(clientname))
as 
(
	select a.reportdate, a.currentdebt, a.clientcode, a.clientname,c.services,c.network, a.activecontracts, a.clientlocation, a.firstactivedate, a.lastactivedate, a.totalpaymentamount
	,b.*
	from 
	rcbill_my.rep_allcust a
	left join
    (
			select ifnull(cl_clientcode,b_clientcode) as combined_clientcode, cl_clientcode
			-- , b_clientcode
			, coalesce(max(b_clientcode)) as b_clientcode
			, coalesce(group_concat((connection_type) separator '|')) as connection_type, coalesce(group_concat((mxk_name) separator '|')) as mxk_name
			, coalesce(group_concat((mxk_interface)  separator '|')) as mxk_interface, coalesce(group_concat((hfc_node)  separator '|')) as hfc_node
			, coalesce(group_concat((nodename) separator '|')) as nodename
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
			, sum(`TotalPayments2018`) as `TotalPayments2018`
			, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
			from rcbill_my.cust_cont_payment_cmts_mxk 
			-- where cl_clientcode='I.000011750'
			group by 1, cl_clientcode 
    ) b
    on
    a.clientcode=b.combined_clientcode
    
    left join
    rcbill_my.clientstats c 
    on a.clientcode=c.clientcode
)
;
    
drop table if exists rcbill_my.tempa;
drop table if exists rcbill_my.tempb;


/*

select * from rcbill_my.rep_allcust where clientcode='0010';
select * from rcbill.rcb_tclients where kod='0010';


select * from rcbill_my.tempa where cl_clientcode='I.000010765';
select * from rcbill_my.tempb where b_clientcode='I.000010765';    

select a.*, b.*
from
rcbill_my.tempa	a 
left join
rcbill_my.tempb b
on a.CL_CLIENTCODE=b.b_clientcode
and a.CON_CONTRACTCODE=b.b_contractcode   
where a.cl_clientcode='I.000010765'   
;

select a.*, b.*
from
rcbill_my.tempa a 
right join
rcbill_my.tempb b
on a.CL_CLIENTCODE=b.b_clientcode
and a.CON_CONTRACTCODE=b.b_contractcode 
where a.cl_clientcode='I.000010765'
;        

select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I.000010765';

select ifnull(cl_clientcode,b_clientcode) as ClientCode, cl_clientcode
-- , b_clientcode
, coalesce(max(b_clientcode)) as b_clientcode
, coalesce(group_concat((connection_type) separator '|')) as connection_type, coalesce(group_concat((mxk_name) separator '|')) as mxk_name
, coalesce(group_concat((mxk_interface)  separator '|')) as mxk_interface, coalesce(group_concat((hfc_node)  separator '|')) as hfc_node
, coalesce(group_concat((nodename) separator '|')) as nodename
, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
, sum(`TotalPayments2018`) as `TotalPayments2018`
, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
from rcbill_my.cust_cont_payment_cmts_mxk 
-- where cl_clientcode='I.000011750'
group by 1, cl_clientcode
-- , b_clientcode
;



 */