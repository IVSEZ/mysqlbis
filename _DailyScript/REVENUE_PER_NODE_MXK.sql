
-- set @custid=693929;

-- select * from rcbill.rcb_invoicesheader where clid=@custid;
-- select * from rcbill.rcb_invoicescontents where clid=@custid;

/*
 select * from rcbill.rcb_techregions;
 select * from rcbill.rcb_cmts;
 select * from rcbill.rcb_mxk;
 select * from rcbill.clientcontractdevices;
 select *, replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','') as FSAN2 from rcbill_my.rep_clientcontractdevices;
 
 select distinct fsan from rcbill_my.rep_clientcontractdevices;
 select * from rcbill_my.rep_clientcontractdevices where contract_type='IMPORT';
 select distinct contract_type from rcbill_my.rep_clientcontractdevices;
 select distinct service_type from rcbill_my.rep_clientcontractdevices;
 
select * from rcbill_my.rep_clientcontractdevices where 
contract_type in 
(
'IMPORT',
'CAPPED INTERNET',
'INTERNET',
'EMAIL',
'VOICE',
'DIGITAL TV',
'BUNDLE (CI)',
'DTV, INTERNET, VOICE',
'DTV,',
'INTERNET, VOICE',
'NEXTTV',
'MOBILE TV',
'DTV',
'HOTSPOT ACCESS',
'PREPAID INTERNET',
'PREPAID TRAFFIC'
)
;

*/

/*
GET HFC NODE INFORMATION 
JOIN CMTS TABLE WITH TECH REGIONS 

*/
/*
select a.*, b.* 
from 
rcbill.rcb_cmts a 
left join
rcbill.rcb_techregions b 
on 
trim(upper(a.HFC_NODE))=trim(upper(b.INTERFACENAME))
;

select MXK_NAME, TRIM(UPPER(concat(VENDOR_ID,SERIAL_NUM))) as DEVICEFSAN, MODEL_ID, MXK_INTERFACE
from
rcbill.rcb_mxk;
*/


/*
  SELECT * FROM t1
  LEFT JOIN t2 ON t1.id = t2.id
  UNION ALL
  SELECT * FROM t1
  RIGHT JOIN t2 ON t1.id = t2.id
  WHERE t1.id IS NULL
*/


## GPON CUSTOMERS

drop table if exists rcbill_my.tempcustmxk1;
create table rcbill_my.tempcustmxk1 as 
(
		select a.*, b.* 
		from 
		(
			select *, if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as FSAN2
			from        
			rcbill_my.rep_clientcontractdevices 
			where 
			length(FSAN)>=4
            and 
            CONTRACT_TYPE in 
            (
				'GNET',
				'CAPPED GNET',
				'GTV',
				'BUNDLE (GPON)',
				'GVOICE',
				'EMAIL',
				'NEXTTV',
				'MOBILE TV',
				'IPTV',
				'HOTSPOT ACCESS'
            )
            and CONTRACT_CODE<>CLIENT_CODE
			-- FSAN is not null or FSAN <>''
		) a 
		left join 
		(
			select MXK_NAME
			, TRIM(UPPER(concat(VENDOR_ID,SERIAL_NUM))) as DEVICEFSAN
			, SERIAL_NUM
			-- , length(SERIAL_NUM) as len_ser
			, trim(upper(if(length(SERIAL_NUM)=8,substring(SERIAL_NUM,2),SERIAL_NUM))) as SERIAL_NUM2  
			, MODEL_ID, MXK_INTERFACE
            , date(INSERTEDON) as MXK_DATE
			from
			rcbill.rcb_mxk where (date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_mxk))
			-- and model_id<>'-'
			and TRIM(SERIAL_NUM)<>'0'
		) b
		on upper(trim(a.FSAN2))=upper(trim(b.SERIAL_NUM2))
);

drop table if exists rcbill_my.tempcustmxk2;
create table rcbill_my.tempcustmxk2 as
(
		select a.*, b.*
		from 
		(
			select *, 
			if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as FSAN2
			from        
			rcbill_my.rep_clientcontractdevices 
			where 
			length(FSAN)>=4
            and 
            CONTRACT_TYPE in 
            (
				'GNET',
				'CAPPED GNET',
				'GTV',
				'BUNDLE (GPON)',
				'GVOICE',
				'EMAIL',
				'NEXTTV',
				'MOBILE TV',
				'IPTV',
				'HOTSPOT ACCESS'
            )   
            and CONTRACT_CODE<>CLIENT_CODE
		) a 
		right join 
		(
			select MXK_NAME
			, TRIM(UPPER(concat(VENDOR_ID,SERIAL_NUM))) as DEVICEFSAN
			, SERIAL_NUM
			-- , length(SERIAL_NUM) as len_ser
			, trim(upper(if(length(SERIAL_NUM)=8,substring(SERIAL_NUM,2),SERIAL_NUM))) as SERIAL_NUM2  
			, MODEL_ID, MXK_INTERFACE
            , date(INSERTEDON) as MXK_DATE            
			from
			rcbill.rcb_mxk where (date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_mxk))
			-- and model_id<>'-'
			and TRIM(SERIAL_NUM)<>'0'
		) b
		on upper(trim(a.FSAN2))=upper(trim(b.SERIAL_NUM2))
);

drop table if exists rcbill_my.customers_mxk;
create table rcbill_my.customers_mxk as
-- (
	(select *, now() as InsertedOn from rcbill_my.tempcustmxk1 a)
    union
	(select *, now() as InsertedOn from rcbill_my.tempcustmxk2 b) 
	
-- )
;

drop table if exists rcbill_my.tempcustmxk1;
drop table if exists rcbill_my.tempcustmxk2;

## HFC CUSTOMERS

drop table if exists rcbill_my.tempcustcmts1;
create table rcbill_my.tempcustcmts1 as 
(
	select a.*, c.*
    -- , now() as INSERTEDON
	from 
	-- rcbill_my.rep_clientcontractdevices a 
	(
		select * from rcbill_my.rep_clientcontractdevices where length(MAC)>=4
        and CONTRACT_TYPE in 
        (
			'IMPORT',
			'CAPPED INTERNET',
			'INTERNET',
			'EMAIL',
			'VOICE',
			'DIGITAL TV',
			'BUNDLE (CI)',
			'DTV, INTERNET, VOICE',
			'DTV,',
			'INTERNET, VOICE',
			'NEXTTV',
			'MOBILE TV',
			'DTV',
			'HOTSPOT ACCESS',
			'PREPAID INTERNET',
			'PREPAID TRAFFIC'        
        )
        and CONTRACT_CODE<>CLIENT_CODE
    ) a
    left join
	(
		select a.MAC_ADDRESS_CLEAN2 as MAC_ADDRESS, a.IP_ADDRESS, a.HFC_NODE
		, date(a.INSERTEDON) as CMTS_DATE
        , b.INTERFACENAME, b.NODENAME
        -- , b.DECIMALLAT, b.DECIMALLONG, b.DISTRICT, b.SUBDISTRICT, b.LATITUDE, b.LONGITUDE
		from 
		rcbill.rcb_cmts a 
		left join
		rcbill.rcb_techregions b 
		on 
		trim(upper(a.HFC_NODE))=trim(upper(b.INTERFACENAME))
		where date(a.INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_cmts)
	) c
	on a.MAC=c.MAC_ADDRESS

);

drop table if exists rcbill_my.tempcustcmts2;
create table rcbill_my.tempcustcmts2 as 
(
	select a.*, c.*
    -- , now() as INSERTEDON
	from 
	-- rcbill_my.rep_clientcontractdevices a 
	(
		select * from rcbill_my.rep_clientcontractdevices where length(MAC)>=4
        and CONTRACT_TYPE in 
        (
			'IMPORT',
			'CAPPED INTERNET',
			'INTERNET',
			'EMAIL',
			'VOICE',
			'DIGITAL TV',
			'BUNDLE (CI)',
			'DTV, INTERNET, VOICE',
			'DTV,',
			'INTERNET, VOICE',
			'NEXTTV',
			'MOBILE TV',
			'DTV',
			'HOTSPOT ACCESS',
			'PREPAID INTERNET',
			'PREPAID TRAFFIC'        
        )
        and CONTRACT_CODE<>CLIENT_CODE
    ) a
	right join
	(
		select a.MAC_ADDRESS_CLEAN2 as MAC_ADDRESS, a.IP_ADDRESS, a.HFC_NODE
		, date(a.INSERTEDON) as CMTS_DATE        
        , b.INTERFACENAME, b.NODENAME
        -- , b.DECIMALLAT, b.DECIMALLONG, b.DISTRICT, b.SUBDISTRICT, b.LATITUDE, b.LONGITUDE
		from 
		rcbill.rcb_cmts a 
		left join
		rcbill.rcb_techregions b 
		on 
		trim(upper(a.HFC_NODE))=trim(upper(b.INTERFACENAME))
		where date(a.INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_cmts)
	) c
	on a.MAC=c.MAC_ADDRESS

);



drop table if exists rcbill_my.customers_cmts;
create table rcbill_my.customers_cmts as
	(select *, now() as InsertedOn from rcbill_my.tempcustcmts1 a)
    union
	(select *, now() as InsertedOn from rcbill_my.tempcustcmts2 b) 
;

drop table if exists rcbill_my.tempcustcmts1;
drop table if exists rcbill_my.tempcustcmts2;


drop table if exists rcbill_my.customers_cmts_mxk;

create table rcbill_my.customers_cmts_mxk
(index idxccm1(client_id),index idxccm2(client_code),index idxccm3(contract_id),index idxccm4(contract_code))
as
	(
	select 'HFC' as connection_type ,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, null as fsan_mxk, null as mxk_name, null as model_id, null as mxk_interface, null as mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, mac_address as mac_cmts, ip_address, hfc_node, cmts_date, interfacename, nodename, date(insertedon) as report_date
	from rcbill_my.customers_cmts
	)
	union
	(
	select 'GPON' as connection_type,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, serial_num as fsan_mxk, mxk_name, model_id, mxk_interface, mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, NULL as mac_cmts, null as ip_address, null as hfc_node, null as cmts_date, null as interfacename, null as nodename, date(insertedon) as report_date
	from rcbill_my.customers_mxk
	)
;



drop table if exists rcbill_my.customers_contracts_cmts_mxk;

create table rcbill_my.customers_contracts_cmts_mxk
(index idxccmc1(CL_CLIENTID), index idxccmc2(CL_CLIENTCODE), index idxccmc3(CON_CONTRACTID), index idxccmc4(CON_CONTRACTCODE))
as
(
	select a.*, b.*
	from 
	(
		select CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS 
		from rcbill.clientcontracts where s_servicename like 'SUBSCRIPTION%' 
		-- and CL_CLIENTID=723711
		group by 
		CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS
	) a
	left join
	rcbill_my.customers_cmts_mxk b 
	on 
	a.CL_CLIENTID=b.client_id
	and 
	a.CON_CONTRACTID=b.contract_id
)
;

/*

UPDATE data_table dt1, data_table dt2 
SET dt1.VALUE = dt2.VALUE 
WHERE dt1.NAME = dt2.NAME AND dt1.VALUE = '' AND dt2.VALUE != '' 
;
*/

set sql_safe_updates=0;

UPDATE rcbill_my.customers_contracts_cmts_mxk a, rcbill_my.customers_contracts_cmts_mxk b 
SET 
a.hfc_node=b.hfc_node
,a.cmts_date=b.cmts_date
,a.interfacename=b.interfacename
,a.nodename=b.nodename
,a.mxk_name=b.mxk_name
,a.mxk_interface=b.mxk_interface
,a.mxk_date=b.mxk_date
,a.report_date=b.report_date
where 
-- a.cl_clientid=723711
-- and
a.contractcurrentstatus='ACTIVE'
and
a.cl_clientid=b.cl_clientid
and 
(
	(a.mxk_name is null and b.mxk_name is not null)
	or
    (a.mxk_interface is null and b.mxk_interface is not null)
    or
    (a.mxk_date is null and b.mxk_date is not null)
    or
    (a.hfc_node is null and b.hfc_node is not null)
    or 
    (a.cmts_date is null and b.cmts_date is not null)
    or 
    (a.interfacename is null and b.interfacename is not null)
    or
    (a.nodename is null and b.nodename is not null)
);



-- select * from rcbill_my.customers_contracts_cmts_mxk;

/*
(
	select a.*, c.*, now() as INSERTEDON
	from 
	rcbill_my.rep_clientcontractdevices a 
	right join
	(
		select a.MAC_ADDRESS_CLEAN2 as MAC_ADDRESS, a.IP_ADDRESS, a.HFC_NODE, b.INTERFACENAME, b.NODENAME, b.DECIMALLAT, b.DECIMALLONG, b.DISTRICT, b.SUBDISTRICT, b.LATITUDE, b.LONGITUDE
		from 
		rcbill.rcb_cmts a 
		left join
		rcbill.rcb_techregions b 
		on 
		trim(upper(a.HFC_NODE))=trim(upper(b.INTERFACENAME))
		where date(a.insertedon) in (select max(date(INSERTEDON)) from rcbill.rcb_cmts)
	) c
	on a.MAC=c.MAC_ADDRESS
)
;
*/

drop table if exists rcbill_my.customers_collection;
create table rcbill_my.customers_collection (index idxccoll1(ClientCode), index idxccoll2(clid), index idxccoll3(cid), index idxccoll4(ContractCode)) as 
(

	select clid
	, cid
    , rcbill.GetClientCode(clid) as ClientCode, rcbill.GetContractCode(cid) as ContractCode
	, month(PAYDATE) as PAYMONTH, year(PAYDATE) as PAYYEAR 
	, COALESCE(sum(money),0) as TotalPaymentAmount  
	, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
    , now() as InsertedOn
	from rcbill.rcb_casa
	where
	(hard not in (100, 101, 102) or hard is null)
	group by clid, cid, 3, 4, 5, 6
	order by clid, 6 desc, 5 desc
);




drop table if exists rcbill_my.customers_cmts_mxk_cont_coll;

create table rcbill_my.customers_cmts_mxk_cont_coll
(index idxccmcc1(CL_CLIENTID), index idxccmcc2(CL_CLIENTCODE), index idxccmcc3(CON_CONTRACTID), index idxccmcc4(CON_CONTRACTCODE))
as
(
	select a.*,b.* 
	from 
	rcbill_my.customers_contracts_cmts_mxk a 
	left join
	rcbill_my.customers_collection b
	on 
	a.CL_CLIENTID=b.clid
	and
	a.CON_CONTRACTID=b.cid
	-- where a.CL_CLIENTID=693929
)
;

-- select * from rcbill_my.customers_cmts_mxk_cont_coll where cl_clientcode='I.000001076';
###2018 payments####
drop table if exists rcbill_my.customers_contracts_collection_pivot2018 ;
create table rcbill_my.customers_contracts_collection_pivot2018 (index idxccp1 (clientcode), index idxccp2(clid), index idxccp3(cid), index idxccp4(contractcode) ) as 
(
		select clid, clientcode, cid, contractcode
		, ifnull(sum(`201801`),0) as `201801` 
		, ifnull(sum(`201802`),0) as `201802` 
		, ifnull(sum(`201803`),0) as `201803` 
		, ifnull(sum(`201804`),0) as `201804` 
		, ifnull(sum(`201805`),0) as `201805` 
		, ifnull(sum(`201806`),0) as `201806` 
		, ifnull(sum(`201807`),0) as `201807` 
		, ifnull(sum(`201808`),0) as `201808` 
		, ifnull(sum(`201809`),0) as `201809` 
		, ifnull(sum(`201810`),0) as `201810` 
		, ifnull(sum(`201811`),0) as `201811` 
		, ifnull(sum(`201812`),0) as `201812` 
		, sum(TotalPayments2018) as TotalPayments2018
		, sum(TotalPaymentAmount2018) as TotalPaymentAmount2018
		from 
		(    
			select clid, clientcode, cid, contractcode
				,case when paymonth=1 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 then ifnull(sum(totalpaymentamount),0) end as `201812`
				, max(lastpaymentdate) as LastPaymentDate
				, sum(totalpayments) as TotalPayments2018
				, sum(totalpaymentamount) as TotalPaymentAmount2018

			from 
			rcbill_my.customers_collection
			where year(LastPaymentDate)=2018
			group by
			clid, clientcode, cid, contractcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode, cid, contractcode	

);


drop table if exists rcbill_my.customers_collection_pivot2018 ;
create table rcbill_my.customers_collection_pivot2018 (index idxccp1 (clientcode), index idxccp2(clid)) as 
(
		select clid, clientcode
		, ifnull(sum(`201801`),0) as `201801` 
		, ifnull(sum(`201802`),0) as `201802` 
		, ifnull(sum(`201803`),0) as `201803` 
		, ifnull(sum(`201804`),0) as `201804` 
		, ifnull(sum(`201805`),0) as `201805` 
		, ifnull(sum(`201806`),0) as `201806` 
		, ifnull(sum(`201807`),0) as `201807` 
		, ifnull(sum(`201808`),0) as `201808` 
		, ifnull(sum(`201809`),0) as `201809` 
		, ifnull(sum(`201810`),0) as `201810` 
		, ifnull(sum(`201811`),0) as `201811` 
		, ifnull(sum(`201812`),0) as `201812` 
		, sum(TotalPayments2018) as TotalPayments2018
		, sum(TotalPaymentAmount2018) as TotalPaymentAmount2018
		from 
		(    
			select clid, clientcode
				,case when paymonth=1 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 then ifnull(sum(totalpaymentamount),0) end as `201812`
				, max(lastpaymentdate) as LastPaymentDate
				, sum(totalpayments) as TotalPayments2018
				, sum(totalpaymentamount) as TotalPaymentAmount2018

			from 
			rcbill_my.customers_collection
			where year(LastPaymentDate)=2018
			group by
			clid, clientcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode 	

);

-- select * from rcbill_my.customers_collection_pivot2018 where clientcode='I.000001076';

drop table if exists rcbill_my.rep_customers_collection2018;
create table rcbill_my.rep_customers_collection2018(index idxrcc20181(client_code), index idxrcc20182(clientname) ) as 
(
		select b.reportdate as ReportDate
		,b.clientcode as ClientCode
		,b.clientname as ClientName
		,b.clientclass as ClientClass
		,date(b.firstcontractdate) as FirstContractDate
        ,b.lastpaymentdate as LastPaymentDate
		,b.lastactivedate as LastActiveDate
		,b.clientaddress as ClientAddress
		,b.clientlocation as ClientLocation
		,c.HOUSING_ESTATE as HousingEstate
		,c.CLIENT_AREA as ClientArea
		,c.CLIENT_SUBAREA as ClientSubArea

		, a.clientcode as client_code, a.`201801`, a.`201802`, a.`201803`, a.`201804`, a.`201805`, a.`201806`, a.`201807`, a.`201808`, a.`201809`, a.`201810`, a.`201811`, a.`201812`, a.`TotalPayments2018`, a.`TotalPaymentAmount2018`
		, b.totalpaymentamount as TotalPaymentOverall
        from 
		rcbill_my.rep_allcust b
		left join
		rcbill_my.customers_collection_pivot2018 a 
		on b.clientcode=a.clientcode
		left join
		rcbill_my.rep_housingestates c 
		on b.clientcode=c.CLIENT_CODE
		order by a.TotalPaymentAmount2018 desc
);



#####2019 payments

drop table if exists rcbill_my.customers_contracts_collection_pivot2019 ;
create table rcbill_my.customers_contracts_collection_pivot2019 (index idxccp1 (clientcode), index idxccp2(clid), index idxccp3(cid), index idxccp4(contractcode) ) as 
(
		select clid, clientcode, cid, contractcode
		, ifnull(sum(`201901`),0) as `201901` 
		, ifnull(sum(`201902`),0) as `201902` 
		, ifnull(sum(`201903`),0) as `201903` 
		, ifnull(sum(`201904`),0) as `201904` 
		, ifnull(sum(`201905`),0) as `201905` 
		, ifnull(sum(`201906`),0) as `201906` 
		, ifnull(sum(`201907`),0) as `201907` 
		, ifnull(sum(`201908`),0) as `201908` 
		, ifnull(sum(`201909`),0) as `201909` 
		, ifnull(sum(`201910`),0) as `201910` 
		, ifnull(sum(`201911`),0) as `201911` 
		, ifnull(sum(`201912`),0) as `201912` 
		, sum(TotalPayments2019) as TotalPayments2019
		, sum(TotalPaymentAmount2019) as TotalPaymentAmount2019
		from 
		(    
			select clid, clientcode, cid, contractcode
				,case when paymonth=1 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 then ifnull(sum(totalpaymentamount),0) end as `201912`
				, max(lastpaymentdate) as LastPaymentDate
				, sum(totalpayments) as TotalPayments2019
				, sum(totalpaymentamount) as TotalPaymentAmount2019

			from 
			rcbill_my.customers_collection
			where year(LastPaymentDate)=2019
			group by
			clid, clientcode, cid, contractcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode, cid, contractcode	

);


drop table if exists rcbill_my.customers_collection_pivot2019 ;
create table rcbill_my.customers_collection_pivot2019 (index idxccp1 (clientcode), index idxccp2(clid)) as 
(
		select clid, clientcode
		, ifnull(sum(`201901`),0) as `201901` 
		, ifnull(sum(`201902`),0) as `201902` 
		, ifnull(sum(`201903`),0) as `201903` 
		, ifnull(sum(`201904`),0) as `201904` 
		, ifnull(sum(`201905`),0) as `201905` 
		, ifnull(sum(`201906`),0) as `201906` 
		, ifnull(sum(`201907`),0) as `201907` 
		, ifnull(sum(`201908`),0) as `201908` 
		, ifnull(sum(`201909`),0) as `201909` 
		, ifnull(sum(`201910`),0) as `201910` 
		, ifnull(sum(`201911`),0) as `201911` 
		, ifnull(sum(`201912`),0) as `201912` 
		, sum(TotalPayments2019) as TotalPayments2019
		, sum(TotalPaymentAmount2019) as TotalPaymentAmount2019
		from 
		(    
			select clid, clientcode
				,case when paymonth=1 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 then ifnull(sum(totalpaymentamount),0) end as `201912`
				, max(lastpaymentdate) as LastPaymentDate
				, sum(totalpayments) as TotalPayments2019
				, sum(totalpaymentamount) as TotalPaymentAmount2019

			from 
			rcbill_my.customers_collection
			where year(LastPaymentDate)=2019
			group by
			clid, clientcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode 	

);

-- select * from rcbill_my.customers_collection_pivot2019 where clientcode='I.000001076';

drop table if exists rcbill_my.rep_customers_collection2019;
create table rcbill_my.rep_customers_collection2019(index idxrcc20191(client_code), index idxrcc20192(clientname) ) as 
(
		select b.reportdate as ReportDate
		,b.clientcode as ClientCode
		,b.clientname as ClientName
		,b.clientclass as ClientClass
		,date(b.firstcontractdate) as FirstContractDate
        ,b.lastpaymentdate as LastPaymentDate
		,b.lastactivedate as LastActiveDate
		,b.clientaddress as ClientAddress
		,b.clientlocation as ClientLocation
		,c.HOUSING_ESTATE as HousingEstate
		,c.CLIENT_AREA as ClientArea
		,c.CLIENT_SUBAREA as ClientSubArea

		, a.clientcode as client_code, a.`201901`, a.`201902`, a.`201903`, a.`201904`, a.`201905`, a.`201906`, a.`201907`, a.`201908`, a.`201909`, a.`201910`, a.`201911`, a.`201912`, a.`TotalPayments2019`, a.`TotalPaymentAmount2019`
		, b.totalpaymentamount as TotalPaymentOverall
        from 
		rcbill_my.rep_allcust b
		left join
		rcbill_my.customers_collection_pivot2019 a 
		on b.clientcode=a.clientcode
		left join
		rcbill_my.rep_housingestates c 
		on b.clientcode=c.CLIENT_CODE
		order by a.TotalPaymentAmount2019 desc
);

#####################





-- select * from rcbill_my.rep_customers_collection2018 where client_code='I.000001076';

set session group_concat_max_len = 15000;

-- select * from rcbill_my.customers_contracts_cmts_mxk where cl_clientcode='I.000001076';

    drop table if exists rcbill_my.tempa;
	create table rcbill_my.tempa(index idxtempa1(CL_CLIENTCODE), index idxtempa2(CON_CONTRACTCODE), index idxtempa3(CL_CLIENTID), index idxtempa4(CON_CONTRACTID)) as
    (
		/*
		select CL_CLIENTCODE, CL_CLIENTID, CON_CONTRACTCODE, CON_CONTRACTID, connection_type,client_code, contract_code, mxk_name, mxk_interface, hfc_node, nodename
		from rcbill_my.customers_contracts_cmts_mxk
		group by CL_CLIENTCODE, CL_CLIENTID, CON_CONTRACTCODE, CON_CONTRACTID,  connection_type,client_code, contract_code, mxk_name,mxk_interface,hfc_node,nodename	
		*/
        
        select CL_CLIENTCODE, CL_CLIENTID, CON_CONTRACTCODE, CON_CONTRACTID, connection_type,client_code, contract_code
        , mxk_name, mxk_interface, hfc_node, nodename
        , group_concat( distinct VPNR_SERVICETYPE order by S_SERVICENAME asc separator '~') as packageinfo
		from rcbill_my.customers_contracts_cmts_mxk
		group by CL_CLIENTCODE, CL_CLIENTID, CON_CONTRACTCODE, CON_CONTRACTID,  connection_type,client_code, contract_code, mxk_name,mxk_interface,hfc_node,nodename	
        
    );

-- select * from rcbill_my.customers_contracts_collection_pivot2018 where clientcode='I.000001076';
	drop table if exists rcbill_my.tempb;
    create table rcbill_my.tempb(index idxtempb1(b_clientcode), index idxtempb2(b_contractcode))
    as
    (
		select clientcode as b_clientcode, clid as b_clientid, contractcode as b_contractcode, cid as b_contractid, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018
        from rcbill_my.customers_contracts_collection_pivot2018 
       -- union
    );

drop table if exists rcbill_my.cust_cont_payment_cmts_mxk;

create table rcbill_my.cust_cont_payment_cmts_mxk 
(
index idxccpcm1(cl_clientcode),index idxccpcm2(CON_CONTRACTCODE)
,index idxccpcm3(b_clientcode),index idxccpcm4(b_contractcode)
,index idxccpcm5(cl_clientid),index idxccpcm6(con_contractid)
)
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

-- select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I.000001076' or b_clientcode='I.000001076';

drop table if exists rcbill_my.rep_cust_cont_payment_cmts_mxk;

create table rcbill_my.rep_cust_cont_payment_cmts_mxk 
(index rccpcm1(clientcode),index rccpcm2(clientname))
as 
(
	select a.reportdate, a.currentdebt, a.clientcode, a.clientname, a.clientclass
    -- , c.services,c.network
    , a.activecontracts, a.clientlocation, a.firstactivedate, a.lastactivedate, a.totalpaymentamount
	,b.*
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
            , coalesce(group_concat(distinct packageinfo order by con_contractid asc separator '|')) as packageinfo
			, sum(`201801`) as `201801`, sum(`201802`) as `201802`, sum(`201803`) as `201803`, sum(`201804`) as `201804`
			, sum(`201805`) as `201805`, sum(`201806`) as `201806`, sum(`201807`) as `201807`, sum(`201808`) as `201808`
			, sum(`201809`) as `201809`, sum(`201810`) as `201810`, sum(`201811`) as `201811`, sum(`201812`) as `201812`
			, sum(`TotalPayments2018`) as `TotalPayments2018`
			, sum(`TotalPaymentAmount2018`) as `TotalPaymentAmount2018` 
			from rcbill_my.cust_cont_payment_cmts_mxk 
			-- where cl_clientcode='I.000011750'
			group by 1 -- , cl_clientcode 
            order by con_contractid
    ) b
    on
    a.clientcode=b.combined_clientcode
    
    -- left join
    -- rcbill_my.clientstats c 
    -- on a.clientcode=c.clientcode
)
;
    
drop table if exists rcbill_my.tempa;
drop table if exists rcbill_my.tempb;

-- select * from rcbill_my.rep_cust_cont_payment_cmts_mxk where clientcode='I.000001076';

####################################
#CREATE CONSOLIDATED CUSTOMER REPORT
####################################


drop table if exists rcbill_my.rep_custconsolidated;
create table rcbill_my.rep_custconsolidated as
(


	select 
	`reportdate`,
	`clientcode`,
	`currentdebt`,
	`isaccountactive`,
	`accountactivitystage`,
	`clientname`,
	`clientclass`,
	`activenetwork`,
	`activeservices`,
	`activecontracts`,
	`activesubscriptions`,
	`clientaddress`,
	`clientlocation`,
	`clean_connection_type`,
	`clean_mxk_name`,
	`clean_mxk_interface`,
	`clean_hfc_node`,
	`clean_hfc_nodename`,
    `hfc_district`,
    `hfc_subdistrict`,
	`firstactivedate`,
	`lastactivedate`,
	`dayssincelastactive`,
	`firstcontractdate`,
	`firstinvoicedate`,
	`firstpaymentdate`,
	`lastinvoicedate`,
	`lastpaidamount`,
	`lastpaymentdate`,
	`totalpayments`,
	`totalpaymentamount`,
	`201801`,
	`201802`,
	`201803`,
	`201804`,
	`201805`,
	`201806`,
	`201807`,
	`201808`,
	`201809`,
	`201810`,
	`201811`,
	`201812`,
	`totalpayments2018`,
	`totalpaymentamount2018`,
	`clientarea`,
	`clientemail`,
	`clientnin`,
	`clientpassport`,
	`clientphone`,
	`combined_clientcode`,
	`cl_clientcode`,
	`b_clientcode`,
	`connection_type`,
	`mxk_name`,
	`mxk_interface`,
	`hfc_node`,
	`nodename`,
	`contractinfo`,
    `packageinfo`
	from 
	(

		select
		b.* ,
        d.activeservices,
        d.activenetwork,
		-- a.clientcode,
		a.AccountActivityStage,
		a.activesubscriptions,
		a.clientaddress,
		a.clientarea,

		a.clientemail,
		a.clientnin,
		a.clientpassport,
		a.clientphone,
		a.dayssincelastactive,
		a.firstcontractdate,
		a.firstinvoicedate,
		a.firstpaymentdate,
		a.IsAccountActive,
		a.lastinvoicedate,
		a.lastpaidamount,
		a.lastpaymentdate,
		a.totalpayments,
		c.contractinfo,
		(select DISTRICT from rcbill.rcb_techregions where INTERFACENAME=b.clean_hfc_node limit 1) as hfc_district,
		(select group_concat(subdistrict separator '|') as hfc_subdistrict from rcbill.rcb_techregions where INTERFACENAME=b.clean_hfc_node) as hfc_subdistrict
		from 
		rcbill_my.rep_allcust a 
		inner join 
		rcbill_my.rep_cust_cont_payment_cmts_mxk b
		on 
		a.clientcode=b.clientcode

		-- where 
		/*
		(
			a.clientaddress like '%glacis%' or a.clientaddress like '%glasic%'  or a.clientaddress like '%glaci%'
		or
			a.clientaddress like '%beau vallon%' or a.clientaddress like '%beauvallon%' or a.clientaddress like '%beauvalon%' 
			or a.clientaddress like '%beauvalon%' or a.clientaddress like '%beau  vallon%' or a.clientaddress like '%beau-vallon%'
			or a.clientaddress like '%beau  valon%'
		or
			a.clientaddress like '%belombre%' or a.clientaddress like '%bel ombre%' or a.clientaddress like '%belom%'  or a.clientaddress like '%belomb%'  or a.clientaddress like '%belomber%'
		or
			a.clientaddress like '%maca%' or a.clientaddress like '%mach%'
		)
		and
		*/ 
		-- a.firstactivedate is not null
		-- and a.clientcode='I.000011750'

		inner join 
		(
			select client_code as clientcode, coalesce(group_concat((CONTRACT_INFO) separator '|')) as contractinfo
			from
			(
			select CLIENT_CODE
			, concat(coalesce(CONTRACT_CODE,''),'~',coalesce(SERVICE_TYPE,''),'~',coalesce(FSAN,''),'~',coalesce(MAC,''),'~',coalesce(UID,'')) as CONTRACT_INFO 
			from rcbill_my.rep_clientcontractdevices 
			-- where CLIENT_CODE='I.000011750'

			) a 
			group by 1
		) c
		on a.clientcode=c.clientcode
        
        left join
        (
			select clientcode
			, coalesce(group_concat((services) order by network asc separator '|')) as activeservices
			, coalesce(group_concat((network) order by network asc separator '|')) as activenetwork
			from rcbill_my.clientstats  
            group by clientcode
        ) d
        on a.clientcode=d.clientcode
	) a
)
-- where clientcode='I6816'
;

select count(*) as rep_custconsolidated from rcbill_my.rep_custconsolidated;

set session group_concat_max_len = 1024;
/*

select * from rcbill_my.rep_cust_cont_payment_cmts_mxk;

select * from rcbill_my.rep_custconsolidated where activenetwork is null and clean_connection_type is null;

select * from rcbill.rcb_cmts;
select * from rcbill.rcb_mxk;
select * from rcbill_my.customers_cmts;
-- select * from rcbill_my.customers_cmts where NODENAME is null;  
select * from rcbill.rcb_techregions;
select * from rcbill_my.customers_mxk;
select * from rcbill_my.customers_cmts_mxk;


select * from rcbill_my.customers_collection;

select * from rcbill_my.customers_collection_pivot2018;

select a.*
,b.clientname as ClientName
,b.clientclass as ClientClass
,b.firstactivedate as FirstActiveDate
,b.lastactivedate as LastActiveDate
,c.HOUSING_ESTATE as HousingEstate
,c.CLIENT_AREA as ClientArea
,c.CLIENT_SUBAREA as ClientSubArea
from 
rcbill_my.customers_collection_pivot2018 a 
left join
rcbill_my.rep_allcust b
on a.clientcode=b.clientcode

left join
rcbill_my.rep_housingestates c 
on a.clientcode=c.CLIENT_CODE
order by a.TotalPaymentAmount desc;



show index from rcbill_my.customers_collection;

set @custid='I6816';
select * from rcbill_my.customers_collection where ClientCode=@custid;
select a.contractcode, a.firstpaymentdate, a.lastpaymentdate
, year(a.lastpaymentdate) as paylyr, month(a.lastpaymentdate) as paylmt, day(a.lastpaymentdate) as payldy 
, year(a.firstpaymentdate) as payfyr, month(a.firstpaymentdate) as payfmt, day(a.firstpaymentdate) as payfdy 
, sum(a.totalpaymentamount) as totalpaymentamount, sum(a.totalpayments) as totalpayments 
from rcbill_my.customers_collection a
where 
a.ClientCode=@custid
group by 1,2,3,4,5,6,7,8,9
order by lastpaymentdate desc
;

select a.*,b.FIRM as ClientName
from 
rcbill_my.customers_collection_pivot2018 a 
left join
rcbill.rcb_tclients b
on a.clientcode=b.kod
 where a.ClientCode='I6816';


select * from rcbill_my.rep_customers_collection2018;

*/

/*
select distinct contract_type from rcbill_my.customers_cmts;
select distinct service_type from rcbill_my.customers_cmts;
select distinct contract_type from rcbill_my.customers_mxk;
select distinct service_type from rcbill_my.customers_mxk;


*/





select HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct MAC) as UNIQUE_MAC_INRCBOSS, count(distinct MAC_ADDRESS) as UNIQUE_MAC_INCMTS
from rcbill_my.customers_cmts
group by HFC_NODE, NODENAME, CMTS_DATE, date(INSERTEDON)
order by HFC_NODE
;

select MXK_NAME, MXK_DATE, date(INSERTEDON) as INSERTED_ON
, count(distinct CLIENT_CODE) as UNIQUE_ACCOUNTS, count(distinct CONTRACT_CODE) as UNIQUE_CONTRACTS
, count(distinct FSAN2) as UNIQUE_FSAN_INRCBOSS, count(distinct SERIAL_NUM2) as UNIQUE_FSAN_INMXK
from rcbill_my.customers_mxk
group by MXK_NAME, MXK_DATE, date(INSERTEDON)
order by MXK_NAME
;


/*

select * from rcbill_my.customers_mxk;
select * from rcbill_my.customers_cmts;
select * from rcbill_my.customers_cmts where client_code=contract_code;
select * from rcbi

 
select *, if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as FSAN2 from rcbill_my.rep_clientcontractdevices;



select * from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME='MXK-PRASLIN';
select MXK_NAME, SERIAL_NUM as MXK_FSAN, MODEL_ID, MXK_INTERFACE from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME='MXK-PRASLIN';

select * from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME<>'MXK-PRASLIN';
select MXK_NAME, SERIAL_NUM as MXK_FSAN, MODEL_ID, MXK_INTERFACE from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME<>'MXK-PRASLIN';

*/

