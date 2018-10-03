select * from rcbill.rcb_mxk;
select * from rcbill.rcb_cmts;

select * from rcbill_my.customers_cmts;
select * from rcbill_my.customers_mxk;

show index from rcbill_my.customers_collection;
show index from rcbill_my.customers_collection_pivot2018;


select * from rcbill_my.customers_collection limit 1000;
select * from rcbill_my.customers_collection_pivot2018;

show index from rcbill.clientcontracts;
-- 




select * from rcbill_my.customers_cmts_mxk;

-- set @custid=723711 - RAW
-- set @custid=693929; -- gilbert elisa
-- set @custid=723470; -- gert corenlius
-- set @custid=694263; -- chalets d'anse forbans 
-- set @custid=727380; - MARLENE
-- set @custid=717345; - Patricia Laboudalon
-- set @custid=705460; - James bouzin

select * from rcbill_my.rep_allcust where clientcode='I7147';

select * from rcbill_my.customers_cmts_mxk where client_id=@custid;
select distinct connection_type,client_code,mxk_name,mxk_interface,hfc_node,nodename
from rcbill_my.customers_cmts_mxk
group by connection_type,client_code,mxk_name,mxk_interface,hfc_node,nodename
;
select * from rcbill_my.customers_collection_pivot2018 where clid=@custid;

select a.reportdate, a.currentdebt, a.clientcode, a.clientname, a.activecontracts, a.clientlocation, a.firstactivedate, a.lastactivedate, a.totalpaymentamount
,b.*
,c.*
from 
rcbill_my.rep_allcust a
left join
(
		select connection_type,client_code, mxk_name, mxk_interface, hfc_node, nodename
		from rcbill_my.customers_cmts_mxk
		group by connection_type,client_code ,mxk_name,mxk_interface,hfc_node,nodename	

/*
	select connection_type, client_code, coalesce(mxk_name,0) as mxk_name, coalesce(mxk_interface,0) as mxk_interface, coalesce(hfc_node,0) as hfc_node, coalesce(nodename,0) as nodename
    from 
    (
		select connection_type,client_code, GROUP_CONCAT(coalesce(mxk_name,'') separator '') as mxk_name
        , GROUP_CONCAT(coalesce(mxk_interface,'') separator '') as mxk_interface
        , GROUP_CONCAT(coalesce(hfc_node,'') separator '') as hfc_node
        , GROUP_CONCAT(coalesce(nodename,'') separator '') as nodename
		from rcbill_my.customers_cmts_mxk
		group by connection_type,client_code ,mxk_name,mxk_interface,hfc_node,nodename
	) a
    group by connection_type, client_code,mxk_name,mxk_interface,hfc_node,nodename
*/
) b
on
a.clientcode=b.client_code

left join
rcbill_my.customers_collection_pivot2018 c
on
a.clientcode=c.clientcode
;


select * from rcbill_my.customers_cmts_mxk_contracts where cl_clientid=@custid;
select * from rcbill_my.customers_collection where clid=@custid;

select * from rcbill_my.customers_cmts_mxk_cont_coll where cl_clientid=@custid;

select * from rcbill_my.customers_cmts_mxk_cont_coll where payyear=year(now()) and cl_clientid=@custid order by payyear desc, paymonth desc;

select * from rcbill_my.customers_contracts_collection_pivot2018 where clid=@custid;


select distinct cl_clientid, cl_clientcode, cl_clientname
, CON_CONTRACTID, CON_CONTRACTCODE
, connection_type, mxk_name, mxk_interface, mxk_date, hfc_node, cmts_date, interfacename, nodename
from 
rcbill_my.customers_cmts_mxk_cont_coll
where cl_clientid=@custid
group by 
cl_clientid, cl_clientcode, cl_clientname
, CON_CONTRACTID, CON_CONTRACTCODE
, connection_type, mxk_name, mxk_interface, mxk_date, hfc_node, cmts_date, interfacename, nodename
;

	select a.*,b.* 
	from 
	rcbill_my.customers_cmts_mxk_contracts a 
	left join
	rcbill_my.customers_contracts_collection_pivot2018 b
	on 
	a.CL_CLIENTID=b.clid
	and
	a.CON_CONTRACTID=b.cid
    
    where a.CL_CLIENTID=@custid
    ;
    
    
select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as REPORT_DATE
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
order by HFC_NODE
;

select MXK_NAME, MXK_DATE, date(INSERTEDON) as REPORT_DATE
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
order by MXK_NAME
;