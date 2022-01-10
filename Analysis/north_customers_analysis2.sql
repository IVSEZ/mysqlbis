use rcbill_my;


-- select * 

select * from rcbill_my.rep_custconsolidated a 
where
	 
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
	or
	a.clientaddress like '%SIMPSON%'
	or 
	a.clientaddress like '%beau belle%' or a.clientaddress like '%beau bel%'  or a.clientaddress like '%beaubel%'
	or
	a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
	or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
	or a.clientaddress like '%beau  valon%'
	or
	a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
	or
	a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
	or
	a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%' or a.clientaddress like '%la gogue%'  
    or a.clientaddress like '%lagog%' or a.clientaddress like '%anse etole%' or a.clientaddress like '%anse etoile%'
    or a.clientaddress like '%la retraite%' or a.clientaddress like '%maldive%' or a.clientaddress like '%maldives%'
    or a.clientaddress like '%english river%' or a.clientaddress like '%union vale%' or a.clientaddress like '%unionvale%'

	or clientlocation in ('BEAU VALLON','BELOMBRE','BEL OMBRE','GLACIS','ANSE ETOILE','ENGLISH RIVER')

	or hfc_district in ('BEAU VALLON','BEL OMBRE','GLACIS','ANSE ETOILE')
	or clean_mxk_name in ('MXK-BEAUVALLON','MXK-ANSEETOILE')
;


### GLACIS CUSTOMERS

## only hfc customers

select 
 a.*,
a.reportdate, a.clientcode, a.clientname, a.IsAccountActive as AccountStatus, a.AccountActivityStage
, a.dayssincelastactive
, a.activeservices
, a.lastactivedate, a.firstactivedate
, a.activenetwork
, a.clean_connection_type
, a.currentdebt
, a.clientemail, a.clientphone
, a.clientclass, a.clientaddress, a.clientarea as island, a.clientlocation as district, a.subdistrict
, a.clientparcel, a.latitude, a.longitude

, case when a.clientparcel is null then 'Not Present'
		else 'Present' end as `ParcelStatus`
, a.TotalPaymentAmount
, a.TotalPaymentAmount2022, a.AvgMonthlyPayment2022
, a.TotalPaymentAmount2021, a.AvgMonthlyPayment2021
, a.TotalPaymentAmount2020, a.AvgMonthlyPayment2020
, a.TotalPaymentAmount2019, a.AvgMonthlyPayment2019
, a.TotalPaymentAmount2018, a.AvgMonthlyPayment2018 

from rcbill_my.rep_custconsolidated a 
where
	( 
		
		a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
		or
		a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%' or a.clientaddress like '%la gogue%'  
		
		or clientlocation in ('GLACIS')

		or hfc_district in ('GLACIS')
	)
    
    -- AND (activenetwork='HFC' or (clean_connection_type='HFC' and activenetwork<>'GPON'))
    AND clean_connection_type='HFC' and (activenetwork<>'GPON' or activenetwork is null)
    
    AND dayssincelastactive<30
    -- AND IsAccountActive='Active'
;

-- select * from rcbill_my.rep_custconsolidated where hfc_district in ('GLACIS');


select distinct clientlocation from rcbill_my.rep_custconsolidated;
select distinct hfc_district from rcbill_my.rep_custconsolidated;
select distinct clean_mxk_name from rcbill_my.rep_custconsolidated;
select distinct clientaddress from rcbill_my.rep_custconsolidated;


select * from rcbill_my.rep_custconsolidated a 
where
 
a.clientaddress like '%SIMPSON%'
;


-- select distinct clientlocation from rcbill_my.rep_custconsolidated order by 1;
-- select distinct hfc_district from rcbill_my.rep_custconsolidated order by 1;
-- select distinct clean_mxk_name from rcbill_my.rep_custconsolidated order by 1;


/*

select * from rcbill_my.rep_custconsolidated;
select * from rcbill_my.clientstats;

select * from rcbill_my.salestoactive where o_clientcode='I19750';


select * from rcbill_my.rep_custconsolidated where IsAccountActive='Active' and AccountActivityStage<>'1. Alive';

select * from rcbill_my.rep_custconsolidated where network<>clean_connection_type;



select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I21367' order by CON_CONTRACTCODE;

select * from rcbill_my.cust_cont_payment_cmts_mxk  where cl_clientcode='I21367' order by b_contractid;

select * from rcbill_my.rep_allcust where clientcode='I21367';
select * from rcbill_my.rep_cust_cont_payment_cmts_mxk  where CL_CLIENTCODE='I21367';

select * from rcbill_my.clientstats where clientcode='I21367';

		select clientcode
		, coalesce(group_concat((services) separator '|')) as servicesinfo
        , coalesce(group_concat((network) separator '|')) as networkinfo
		from rcbill_my.clientstats 
        where clientcode='I23516';

		select client_code as clientcode, coalesce(group_concat((CONTRACT_INFO) separator '|')) as contractinfo
		from
		(
		select CLIENT_CODE
		, concat(coalesce(CONTRACT_CODE,''),'~',coalesce(SERVICE_TYPE,''),'~',coalesce(FSAN,''),'~',coalesce(MAC,''),'~',coalesce(UID,'')) as CONTRACT_INFO 
		from rcbill_my.rep_clientcontractdevices 
		where CLIENT_CODE='I21367'

		) a 
		group by 1;



select clean_connection_type
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
group by clean_connection_type
;

select isaccountactive, accountactivitystage
, count(clientcode) as clients
, count(distinct clientcode) as d_clients
from rcbill_my.rep_custconsolidated
group by isaccountactive, accountactivitystage
;

select 
ifnull(isaccountactive,'') as isaccountactive
, ifnull(accountactivitystage,'') as accountactivitystage
, ifnull(clientclass,'') as clientclass
, ifnull(activenetwork,'') as activenetwork
, ifnull(hfc_district,'') as hfc_district
, ifnull(hfc_district,clientlocation) as hfc_district2
, ifnull(clean_hfc_nodename,'') as clean_hfc_nodename
, ifnull(clean_mxk_name,'') as clean_mxk_name
, ifnull(clientlocation,'') as clientlocation

, count(clientcode) as clients
, count(distinct clientcode) as d_clients
, sum(totalpaymentamount) as totalpaymentamount
, sum(TotalPayments2018) as TotalPayments2018
, sum(TotalPaymentAmount2018) as TotalPaymentAmount2018
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
from rcbill_my.rep_custconsolidated
group by 
1, 2, 3, 4, 5, 6, 7, 8, 9
;

select * from rcbill_my.rep_custconsolidated;

select * from rcbill_my.rep_custconsolidated where clientcode='I23272';
select * from rcbill_my.rep_custconsolidated where clientlocation ='EDEN ISLAND';



-- select *, group_concat(connection_type order by cl_clientcode asc, con_contractcode asc separator '|' ) as clean_connection_type from  rcbill_my.cust_cont_payment_cmts_mxk where CL_CLIENTCODE='I23516' order by cl_clientid, con_contractid;


			select ifnull(cl_clientcode,b_clientcode) as combined_clientcode, cl_clientcode
			-- , b_clientcode
			, coalesce(max(b_clientcode)) as b_clientcode
			, coalesce(group_concat((connection_type) order by con_contractid asc separator '|')) as connection_type
            , coalesce(group_concat((mxk_name)  order by con_contractid asc separator '|')) as mxk_name
			, coalesce(group_concat((mxk_interface) order by con_contractid asc  separator '|')) as mxk_interface
            , coalesce(group_concat((hfc_node)  order by con_contractid asc separator '|')) as hfc_node
			, coalesce(group_concat((nodename)  order by con_contractid asc separator '|')) as nodename
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
			, sum(`TotalPayments2018`) as `TotalPayments2018`
			, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
			from rcbill_my.cust_cont_payment_cmts_mxk 
			where cl_clientcode='I21367'
			group by 1, cl_clientcode 
            order by con_contractid;
            
 select * from rcbill_my.customers_contracts_cmts_mxk  ;
 
 
 
select group_concat(connection_type order by cl_clientcode asc, con_contractcode asc separator '|' ) as clean_connection_type
from rcbill_my.cust_cont_payment_cmts_mxk where client_code='I23516';


select connection_type
from rcbill_my.cust_cont_payment_cmts_mxk where client_code='I23516' order by CON_CONTRACTid;



	select a.reportdate, a.currentdebt, a.clientcode, a.clientname, a.clientclass
    -- , c.services,c.network
    , a.activecontracts, a.clientlocation, a.firstactivedate, a.lastactivedate, a.totalpaymentamount
	,a.*
    , substring_index(b.mxk_name,'|',-1) as clean_mxk_name
    , substring_index(b.mxk_interface,'|',-1) as clean_mxk_interface
    , substring_index(b.hfc_node,'|',-1) as clean_hfc_node
    , substring_index(b.nodename,'|',-1) as clean_hfc_nodename
    , substring_index(b.connection_type,'|',-1) as clean_connection_type
	from 
	rcbill_my.rep_allcust a
	left join
    (
			select ifnull(cl_clientcode,b_clientcode) as combined_clientcode, cl_clientcode
			-- , b_clientcode
			, coalesce(max(b_clientcode)) as b_clientcode
			, coalesce(group_concat((connection_type) order by con_contractid asc separator '|')) as connection_type
            , coalesce(group_concat((mxk_name)  order by con_contractid asc separator '|')) as mxk_name
			, coalesce(group_concat((mxk_interface) order by con_contractid asc  separator '|')) as mxk_interface
            , coalesce(group_concat((hfc_node)  order by con_contractid asc separator '|')) as hfc_node
			, coalesce(group_concat((nodename)  order by con_contractid asc separator '|')) as nodename
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
			, sum(`TotalPayments2018`) as `TotalPayments2018`
			, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
			from rcbill_my.cust_cont_payment_cmts_mxk 
			where cl_clientcode='I21367'
			group by 1, cl_clientcode 
            order by con_contractid
    ) b
    on
    a.clientcode=b.combined_clientcode
    
    -- left join
    -- rcbill_my.clientstats c 
    -- on a.clientcode=c.clientcode
	
    where a.clientcode='I21367'

/*
SELECT col1, col2,
       CONCAT(LEAST(col1, col2), '-', 
              GREATEST(col1, col2)) concat_result
  FROM table1
 ORDER BY concat_result
 ;
 
 SELECT DISTINCT 
       CONCAT(LEAST(col1, col2), '-', 
              GREATEST(col1, col2)) concat_result
  FROM table1
 ORDER BY concat_result
 ;
 

*/