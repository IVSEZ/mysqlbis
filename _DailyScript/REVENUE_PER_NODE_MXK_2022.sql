
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

-- select * from rcbill_my.customercontractsnapshot where ;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;

-- select * from rcbill_my.rep_clientcontractdevices ;
-- select distinct contract_type from rcbill_my.rep_clientcontractdevices;


## GPON CUSTOMERS
create temporary table a (index idxf1(FSAN2)) as 
(
			select *, cast(if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as char(100)) as FSAN2
			from        
			rcbill_my.rep_clientcontractdevices 
			where 
			length(FSAN)>=4
            and CONTRACT_CODE in (select contractcode from rcbill_my.customercontractsnapshot where network='GPON')
            /*
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
				'HOTSPOT ACCESS',
                'VOIP INTERCONNECT'
            )
            */
            and CONTRACT_CODE<>CLIENT_CODE
			-- FSAN is not null or FSAN <>''
);

select 'created temp table a' as message;

-- select * from a;

create temporary table b (index idxsn2(SERIAL_NUM2)) as 
(
			select MXK_NAME
			, TRIM(UPPER(concat(VENDOR_ID,SERIAL_NUM))) as DEVICEFSAN
			, SERIAL_NUM
			-- , length(SERIAL_NUM) as len_ser
			, CAST(trim(upper(if(length(SERIAL_NUM)=8,substring(SERIAL_NUM,2),SERIAL_NUM))) as char(100)) as SERIAL_NUM2  
			, MODEL_ID, MXK_INTERFACE
            , date(INSERTEDON) as MXK_DATE
			from
			rcbill.rcb_mxk where (date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_mxk))
			-- and model_id<>'-'
			and TRIM(SERIAL_NUM)<>'0'
)
;

select 'created temp table b' as message;


drop table if exists rcbill_my.tempcustmxk1;
create table rcbill_my.tempcustmxk1 as 
(
		select a.*, b.* 
		from 
		/*(
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
		) */
        a 
		left join 
		/*(
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
		) */
        b
		on upper(trim(a.FSAN2))=upper(trim(b.SERIAL_NUM2))
);

select 'created rcbill_my.tempcustmxk1' as message;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;


create temporary table a (index idxf1(FSAN2)) as 
(
			select *, 
			cast(if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as char(100)) as FSAN2
			from        
			rcbill_my.rep_clientcontractdevices 
			where 
			length(FSAN)>=4
            and CONTRACT_CODE in (select contractcode from rcbill_my.customercontractsnapshot where network='GPON')
            /*
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
				'HOTSPOT ACCESS',
                'VOIP INTERCONNECT'
            ) 
            */
            and CONTRACT_CODE<>CLIENT_CODE
);

select 'created temp a' as message;


create temporary table b (index idxsn2(SERIAL_NUM2)) as 
(
			select MXK_NAME
			, TRIM(UPPER(concat(VENDOR_ID,SERIAL_NUM))) as DEVICEFSAN
			, SERIAL_NUM
			-- , length(SERIAL_NUM) as len_ser
			, cast(trim(upper(if(length(SERIAL_NUM)=8,substring(SERIAL_NUM,2),SERIAL_NUM))) as char(100)) as SERIAL_NUM2  
			, MODEL_ID, MXK_INTERFACE
            , date(INSERTEDON) as MXK_DATE            
			from
			rcbill.rcb_mxk where (date(INSERTEDON) in (select max(date(INSERTEDON)) from rcbill.rcb_mxk))
			-- and model_id<>'-'
			and TRIM(SERIAL_NUM)<>'0'
);

select 'created temp b' as message;


drop table if exists rcbill_my.tempcustmxk2;
create table rcbill_my.tempcustmxk2 as
(
		select a.*, b.*
		from 
		/*(
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
		) */
        a 
		right join 
		/*(
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
		) */ 
        b
		on upper(trim(a.FSAN2))=upper(trim(b.SERIAL_NUM2))
);

select 'created rcbill_my.tempcustmxk2' as message;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;



drop table if exists rcbill_my.customers_mxk;
create table rcbill_my.customers_mxk as
-- (
	(select *, now() as InsertedOn from rcbill_my.tempcustmxk1 a)
    union
	(select *, now() as InsertedOn from rcbill_my.tempcustmxk2 b) 
	
-- )
;

select 'created rcbill_my.customers_mxk' as message;
-- select * from rcbill_my.customers_mxk where mxk_name='MXK-ANSEETOILE';
-- select * from rcbill_my.customers_mxk where CLIENT_CODE='I14';

drop table if exists rcbill_my.tempcustmxk1;
drop table if exists rcbill_my.tempcustmxk2;

## HFC CUSTOMERS
create temporary table a (index idxa1(MAC)) as 
(
		select * from rcbill_my.rep_clientcontractdevices where length(MAC)>=4
        and CONTRACT_CODE in (select contractcode from rcbill_my.customercontractsnapshot where network='HFC')
        /*
        and CONTRACT_TYPE in 
        (
			'IMPORT',
			'CAPPED INTERNET',
			'INTERNET',
            'INTERNET,',
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
        */
        and CONTRACT_CODE<>CLIENT_CODE

);

select 'created temp a' as message;

-- select * from rcbill.rcb_techregions
create temporary table c (index idxc1(MAC_ADDRESS)) as 
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
);

select 'created temp c' as message;


drop table if exists rcbill_my.tempcustcmts1;
create table rcbill_my.tempcustcmts1 as 
(
	select a.*, c.*
    -- , now() as INSERTEDON
	from 
	-- rcbill_my.rep_clientcontractdevices a 
	/*(
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
    ) */
    a
    left join
	/*(
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
	) */
    c
	on a.MAC=c.MAC_ADDRESS

);

select 'created rcbill_my.tempcustcmts1' as message;
-- select * from a\
-- select * from c
-- select * from rcbill_my.tempcustcmts1;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;

-- select distinct contract_type from rcbill_my.rep_clientcontractdevices ;

create temporary table a (index idxa1(MAC)) as 
(
		select * from rcbill_my.rep_clientcontractdevices where length(MAC)>=4
        and CONTRACT_CODE in (select contractcode from rcbill_my.customercontractsnapshot where network='HFC')
       /*
        and CONTRACT_TYPE in 
        (
			'IMPORT',
			'CAPPED INTERNET',
			'INTERNET',
            'INTERNET,',
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
        */
        and CONTRACT_CODE<>CLIENT_CODE
);


select 'created temp a' as message;

create temporary table c (index idxc1(MAC_ADDRESS)) as 
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
);


select 'created temp c' as message;

drop table if exists rcbill_my.tempcustcmts2;
create table rcbill_my.tempcustcmts2 as 
(
	select a.*, c.*
    -- , now() as INSERTEDON
	from 
	-- rcbill_my.rep_clientcontractdevices a 
	/*(
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
    ) */
    a
	right join
	/*(
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
	) */
    c
	on a.MAC=c.MAC_ADDRESS

);

select 'created rcbill_my.tempcustcmts2' as message;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;

drop table if exists rcbill_my.customers_cmts;
create table rcbill_my.customers_cmts as
	(select *, now() as InsertedOn from rcbill_my.tempcustcmts1 a)
    union
	(select *, now() as InsertedOn from rcbill_my.tempcustcmts2 b) 
;

select 'created rcbill_my.customers_cmts' as message;

-- select * from rcbill_my.customers_cmts where CLIENT_CODE='I14';
drop table if exists rcbill_my.tempcustcmts1;
drop table if exists rcbill_my.tempcustcmts2;


drop table if exists rcbill_my.customers_cmts_mxk;

create table rcbill_my.customers_cmts_mxk
(index idxccm1(client_id),index idxccm2(client_code),index idxccm3(contract_id),index idxccm4(contract_code))
as
	(
	/*
	select 'HFC' as connection_type ,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, null as fsan_mxk, null as mxk_name, null as model_id, null as mxk_interface, null as mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, mac_address as mac_cmts, ip_address, hfc_node, cmts_date, interfacename, nodename, date(insertedon) as report_date
	from rcbill_my.customers_cmts
	*/
	select 'CMTS' as conntype ,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, null as fsan_mxk, null as mxk_name, null as model_id, null as mxk_interface, null as mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, mac_address as mac_cmts, ip_address, hfc_node, cmts_date, interfacename, nodename, date(insertedon) as report_date
	from rcbill_my.customers_cmts
    
    )
	union
	(
	/*
	select 'GPON' as connection_type,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, serial_num as fsan_mxk, mxk_name, model_id, mxk_interface, mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, NULL as mac_cmts, null as ip_address, null as hfc_node, null as cmts_date, null as interfacename, null as nodename, date(insertedon) as report_date
	from rcbill_my.customers_mxk
	*/
	select 'MXK' as conntype,client_id, client_code, client_name, contract_id, contract_code, contract_type, service_type
	, fsan as fsan_rcb, serial_num as fsan_mxk, mxk_name, model_id, mxk_interface, mxk_date
	, mac as mac_rcb, uid as uid_rcb
	, NULL as mac_cmts, null as ip_address, null as hfc_node, null as cmts_date, null as interfacename, null as nodename, date(insertedon) as report_date
	from rcbill_my.customers_mxk
    -- where client_code='I.000018640'
    -- and 
    where model_id<>'-'
    ### this model_id<>'-' condition inserted on 06/09/2019 to ensure that mxk are not double counted due to fsan being found on multiple interfaces on different mxks
    
    
    )
;
-- select * from rcbill_my.customers_cmts_mxk where client_code='I.000011750';
-- select * from rcbill_my.customers_cmts_mxk where client_code='I.000018640';
-- select * from rcbill_my.customers_cmts_mxk where client_code='I14';
select 'created rcbill_my.customers_cmts_mxk' as message;

create temporary table a (index idxa1(CL_CLIENTID), index idxa2(CON_CONTRACTID)) as 
(

		select CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS 
        , rcbill_my.GetNetworkForClientContract(CL_CLIENTCODE,CON_CONTRACTCODE) as connection_type
		from rcbill.clientcontracts where s_servicename like 'SUBSCRIPTION%' 
		-- and CL_CLIENTID=723711
		group by 
		CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS

);

select 'created temp a' as message;


drop table if exists rcbill_my.customers_contracts_cmts_mxk;

create table rcbill_my.customers_contracts_cmts_mxk
(index idxccmc1(CL_CLIENTID), index idxccmc2(CL_CLIENTCODE), index idxccmc3(CON_CONTRACTID), index idxccmc4(CON_CONTRACTCODE))
as
(
	select a.*,  b.*
	from 
	/*(
		select CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS 
		from rcbill.clientcontracts where s_servicename like 'SUBSCRIPTION%' 
		-- and CL_CLIENTID=723711
		group by 
		CL_CLIENTID, CL_CLIENTNAME, CL_CLIENTCODE, CL_CLCLASSNAME, CON_CONTRACTID, CON_CONTRACTCODE, S_SERVICENAME, VPNR_SERVICETYPE, VPNR_SERVICEPRICE, CONTRACTCURRENTSTATUS
	) */
    a
	-- left join
	-- customers_contracts_cmts_mxk b 
    -- customers_cmts_mxk b
	-- on 
	-- a.CL_CLIENTID=b.client_id
	-- and 
	-- a.CON_CONTRACTID=b.contract_id
	left join
	rcbill_my.customers_cmts_mxk b 
	on 
	a.CL_CLIENTID=b.client_id
	and 
	a.CON_CONTRACTID=b.contract_id
)
;

select 'created rcbill_my.customers_contracts_cmts_mxk' as message;


drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;

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

select 'updated rcbill_my.customers_contracts_cmts_mxk' as message;


-- select * from rcbill_my.customers_contracts_cmts_mxk where cl_clientcode='I.000011750';
-- select * from rcbill_my.customers_contracts_cmts_mxk where cl_clientcode='I14';

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

-- select count(*) from rcbill_my.customers_collection;
-- select * from rcbill_my.customers_collection;

select 'created rcbill_my.customers_collection' as message;

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

select 'created rcbill_my.customers_cmts_mxk_cont_coll' as message;

-- select * from rcbill_my.customers_cmts_mxk_cont_coll where cl_clientcode='I.000001076';
###2018 payments####
/*
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

-- select * from rcbill_my.rep_customers_collection2018;
*/

#####2019 payments
/*
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

select 'created rcbill_my.customers_contracts_collection_pivot2019' as message;

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

select 'created rcbill_my.customers_collection_pivot2019' as message;
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

select 'created rcbill_my.rep_customers_collection2019' as message;
*/
#####################




drop table if exists rcbill_my.customers_contracts_collection_pivot ;
create table rcbill_my.customers_contracts_collection_pivot (index idxccp1 (clientcode), index idxccp2(clid), index idxccp3(cid), index idxccp4(contractcode) ) as 
(
		select clid, clientcode, cid, contractcode
		, ifnull(sum(`202201`),0) as `202201` 
		, ifnull(sum(`202202`),0) as `202202` 
		, ifnull(sum(`202203`),0) as `202203` 
		, ifnull(sum(`202204`),0) as `202204` 
		, ifnull(sum(`202205`),0) as `202205` 
		, ifnull(sum(`202206`),0) as `202206` 
		, ifnull(sum(`202207`),0) as `202207` 
		, ifnull(sum(`202208`),0) as `202208` 
		, ifnull(sum(`202209`),0) as `202209` 
		, ifnull(sum(`202210`),0) as `202210` 
		, ifnull(sum(`202211`),0) as `202211` 
		, ifnull(sum(`202212`),0) as `202212` 
		, ifnull(sum(TotalPayments2022),0) as TotalPayments2022
		, ifnull(sum(TotalPaymentAmount2022),0) as TotalPaymentAmount2022

		, ifnull(sum(`202101`),0) as `202101` 
		, ifnull(sum(`202102`),0) as `202102` 
		, ifnull(sum(`202103`),0) as `202103` 
		, ifnull(sum(`202104`),0) as `202104` 
		, ifnull(sum(`202105`),0) as `202105` 
		, ifnull(sum(`202106`),0) as `202106` 
		, ifnull(sum(`202107`),0) as `202107` 
		, ifnull(sum(`202108`),0) as `202108` 
		, ifnull(sum(`202109`),0) as `202109` 
		, ifnull(sum(`202110`),0) as `202110` 
		, ifnull(sum(`202111`),0) as `202111` 
		, ifnull(sum(`202112`),0) as `202112` 
		, ifnull(sum(TotalPayments2021),0) as TotalPayments2021
		, ifnull(sum(TotalPaymentAmount2021),0) as TotalPaymentAmount2021
        
		, ifnull(sum(`202001`),0) as `202001` 
		, ifnull(sum(`202002`),0) as `202002` 
		, ifnull(sum(`202003`),0) as `202003` 
		, ifnull(sum(`202004`),0) as `202004` 
		, ifnull(sum(`202005`),0) as `202005` 
		, ifnull(sum(`202006`),0) as `202006` 
		, ifnull(sum(`202007`),0) as `202007` 
		, ifnull(sum(`202008`),0) as `202008` 
		, ifnull(sum(`202009`),0) as `202009` 
		, ifnull(sum(`202010`),0) as `202010` 
		, ifnull(sum(`202011`),0) as `202011` 
		, ifnull(sum(`202012`),0) as `202012` 
		, ifnull(sum(TotalPayments2020),0) as TotalPayments2020
		, ifnull(sum(TotalPaymentAmount2020),0) as TotalPaymentAmount2020
        
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
		, ifnull(sum(TotalPayments2019),0) as TotalPayments2019
		, ifnull(sum(TotalPaymentAmount2019),0) as TotalPaymentAmount2019
        
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
		, ifnull(sum(TotalPayments2018),0) as TotalPayments2018
		, ifnull(sum(TotalPaymentAmount2018),0) as TotalPaymentAmount2018



		from 
		(    
			select clid, clientcode, cid, contractcode
				,case when paymonth=1 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202201`
				,case when paymonth=2 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202202`
				,case when paymonth=3 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202203`
				,case when paymonth=4 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202204`
				,case when paymonth=5 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202205`
				,case when paymonth=6 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202206`
				,case when paymonth=7 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202207`
				,case when paymonth=8 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202208`
				,case when paymonth=9 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202209`
				,case when paymonth=10 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202210`
				,case when paymonth=11 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202211`
				,case when paymonth=12 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202212`
				,case when payyear=2022 then ifnull(sum(totalpayments),0) end as TotalPayments2022
				,case when payyear=2022 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2022

				,case when paymonth=1 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202101`
				,case when paymonth=2 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202102`
				,case when paymonth=3 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202103`
				,case when paymonth=4 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202104`
				,case when paymonth=5 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202105`
				,case when paymonth=6 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202106`
				,case when paymonth=7 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202107`
				,case when paymonth=8 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202108`
				,case when paymonth=9 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202109`
				,case when paymonth=10 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202110`
				,case when paymonth=11 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202111`
				,case when paymonth=12 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202112`
				,case when payyear=2021 then ifnull(sum(totalpayments),0) end as TotalPayments2021
				,case when payyear=2021 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2021

				,case when paymonth=1 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202001`
				,case when paymonth=2 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202002`
				,case when paymonth=3 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202003`
				,case when paymonth=4 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202004`
				,case when paymonth=5 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202005`
				,case when paymonth=6 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202006`
				,case when paymonth=7 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202007`
				,case when paymonth=8 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202008`
				,case when paymonth=9 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202009`
				,case when paymonth=10 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202010`
				,case when paymonth=11 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202011`
				,case when paymonth=12 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202012`
				,case when payyear=2020 then ifnull(sum(totalpayments),0) end as TotalPayments2020
				,case when payyear=2020 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2020


				,case when paymonth=1 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201912`
				,case when payyear=2019 then ifnull(sum(totalpayments),0) end as TotalPayments2019
				,case when payyear=2019 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2019


				,case when paymonth=1 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201812`
				,case when payyear=2018 then ifnull(sum(totalpayments),0) end as TotalPayments2018
				,case when payyear=2018 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2018
			
				-- , max(lastpaymentdate) as LastPaymentDate

           from 
			rcbill_my.customers_collection
			-- where year(LastPaymentDate)=2020
			group by
			clid, clientcode, cid, contractcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode, cid, contractcode	

);

select 'created rcbill_my.customers_contracts_collection_pivot' as message;
-- select * from rcbill_my.customers_contracts_collection_pivot where clientcode='I6816';

drop table if exists rcbill_my.customers_collection_pivot;
create table rcbill_my.customers_collection_pivot (index idxccp1 (clientcode), index idxccp2(clid)) as 
(
		select clid, clientcode
		, ifnull(sum(`202201`),0) as `202201` 
		, ifnull(sum(`202202`),0) as `202202` 
		, ifnull(sum(`202203`),0) as `202203` 
		, ifnull(sum(`202204`),0) as `202204` 
		, ifnull(sum(`202205`),0) as `202205` 
		, ifnull(sum(`202206`),0) as `202206` 
		, ifnull(sum(`202207`),0) as `202207` 
		, ifnull(sum(`202208`),0) as `202208` 
		, ifnull(sum(`202209`),0) as `202209` 
		, ifnull(sum(`202210`),0) as `202210` 
		, ifnull(sum(`202211`),0) as `202211` 
		, ifnull(sum(`202212`),0) as `202212` 
		, ifnull(sum(TotalPayments2022),0) as TotalPayments2022
		, ifnull(sum(TotalPaymentAmount2022),0) as TotalPaymentAmount2022
        
		, ifnull(sum(`202101`),0) as `202101` 
		, ifnull(sum(`202102`),0) as `202102` 
		, ifnull(sum(`202103`),0) as `202103` 
		, ifnull(sum(`202104`),0) as `202104` 
		, ifnull(sum(`202105`),0) as `202105` 
		, ifnull(sum(`202106`),0) as `202106` 
		, ifnull(sum(`202107`),0) as `202107` 
		, ifnull(sum(`202108`),0) as `202108` 
		, ifnull(sum(`202109`),0) as `202109` 
		, ifnull(sum(`202110`),0) as `202110` 
		, ifnull(sum(`202111`),0) as `202111` 
		, ifnull(sum(`202112`),0) as `202112` 
		, ifnull(sum(TotalPayments2021),0) as TotalPayments2021
		, ifnull(sum(TotalPaymentAmount2021),0) as TotalPaymentAmount2021
        
		, ifnull(sum(`202001`),0) as `202001` 
		, ifnull(sum(`202002`),0) as `202002` 
		, ifnull(sum(`202003`),0) as `202003` 
		, ifnull(sum(`202004`),0) as `202004` 
		, ifnull(sum(`202005`),0) as `202005` 
		, ifnull(sum(`202006`),0) as `202006` 
		, ifnull(sum(`202007`),0) as `202007` 
		, ifnull(sum(`202008`),0) as `202008` 
		, ifnull(sum(`202009`),0) as `202009` 
		, ifnull(sum(`202010`),0) as `202010` 
		, ifnull(sum(`202011`),0) as `202011` 
		, ifnull(sum(`202012`),0) as `202012` 
		, ifnull(sum(TotalPayments2020),0) as TotalPayments2020
		, ifnull(sum(TotalPaymentAmount2020),0) as TotalPaymentAmount2020
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
		, ifnull(sum(TotalPayments2019),0) as TotalPayments2019
		, ifnull(sum(TotalPaymentAmount2019),0) as TotalPaymentAmount2019
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
		, ifnull(sum(TotalPayments2018),0) as TotalPayments2018
		, ifnull(sum(TotalPaymentAmount2018),0) as TotalPaymentAmount2018
        
		from 
		(    
			select clid, clientcode
				,case when paymonth=1 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202201`
				,case when paymonth=2 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202202`
				,case when paymonth=3 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202203`
				,case when paymonth=4 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202204`
				,case when paymonth=5 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202205`
				,case when paymonth=6 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202206`
				,case when paymonth=7 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202207`
				,case when paymonth=8 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202208`
				,case when paymonth=9 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202209`
				,case when paymonth=10 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202210`
				,case when paymonth=11 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202211`
				,case when paymonth=12 and payyear=2022 then ifnull(sum(totalpaymentamount),0) end as `202212`
				,case when payyear=2022 then ifnull(sum(totalpayments),0) end as TotalPayments2022
				,case when payyear=2022 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2022

				,case when paymonth=1 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202101`
				,case when paymonth=2 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202102`
				,case when paymonth=3 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202103`
				,case when paymonth=4 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202104`
				,case when paymonth=5 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202105`
				,case when paymonth=6 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202106`
				,case when paymonth=7 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202107`
				,case when paymonth=8 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202108`
				,case when paymonth=9 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202109`
				,case when paymonth=10 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202110`
				,case when paymonth=11 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202111`
				,case when paymonth=12 and payyear=2021 then ifnull(sum(totalpaymentamount),0) end as `202112`
				,case when payyear=2021 then ifnull(sum(totalpayments),0) end as TotalPayments2021
				,case when payyear=2021 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2021

				,case when paymonth=1 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202001`
				,case when paymonth=2 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202002`
				,case when paymonth=3 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202003`
				,case when paymonth=4 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202004`
				,case when paymonth=5 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202005`
				,case when paymonth=6 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202006`
				,case when paymonth=7 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202007`
				,case when paymonth=8 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202008`
				,case when paymonth=9 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202009`
				,case when paymonth=10 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202010`
				,case when paymonth=11 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202011`
				,case when paymonth=12 and payyear=2020 then ifnull(sum(totalpaymentamount),0) end as `202012`
				,case when payyear=2020 then ifnull(sum(totalpayments),0) end as TotalPayments2020
				,case when payyear=2020 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2020


				,case when paymonth=1 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201901`
				,case when paymonth=2 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201902`
				,case when paymonth=3 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201903`
				,case when paymonth=4 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201904`
				,case when paymonth=5 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201905`
				,case when paymonth=6 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201906`
				,case when paymonth=7 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201907`
				,case when paymonth=8 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201908`
				,case when paymonth=9 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201909`
				,case when paymonth=10 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201910`
				,case when paymonth=11 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201911`
				,case when paymonth=12 and payyear=2019 then ifnull(sum(totalpaymentamount),0) end as `201912`
				,case when payyear=2019 then ifnull(sum(totalpayments),0) end as TotalPayments2019
				,case when payyear=2019 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2019


				,case when paymonth=1 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201801`
				,case when paymonth=2 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201802`
				,case when paymonth=3 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201803`
				,case when paymonth=4 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201804`
				,case when paymonth=5 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201805`
				,case when paymonth=6 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201806`
				,case when paymonth=7 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201807`
				,case when paymonth=8 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201808`
				,case when paymonth=9 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201809`
				,case when paymonth=10 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201810`
				,case when paymonth=11 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201811`
				,case when paymonth=12 and payyear=2018 then ifnull(sum(totalpaymentamount),0) end as `201812`
				,case when payyear=2018 then ifnull(sum(totalpayments),0) end as TotalPayments2018
				,case when payyear=2018 then ifnull(sum(totalpaymentamount),0) end as TotalPaymentAmount2018

			from 
			rcbill_my.customers_collection
			-- where year(LastPaymentDate)=2020
			group by
			clid, clientcode, PAYMONTH, PAYYEAR
		-- ,3,4,5,6,7,8,9,10,11,12,13,14
		) a 
		group by clid, clientcode 	

);

select 'created rcbill_my.customers_collection_pivot' as message;
-- select * from rcbill_my.customers_collection_pivot where clientcode='I.000001076';


drop table if exists rcbill_my.rep_customers_collection;
create table rcbill_my.rep_customers_collection(index idxrcc1(client_code), index idxrcc2(clientname) ) as 
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
		,b.subdistrict 
		,b.clientparcel, b.coord_x, b.coord_y, b.latitude, b.longitude
        
        
		,c.HOUSING_ESTATE as HousingEstate
		,c.CLIENT_AREA as ClientArea
		,c.CLIENT_SUBAREA as ClientSubArea

		, a.clientcode as client_code
        , a.`202201`, a.`202202`, a.`202203`, a.`202204`, a.`202205`, a.`202206`, a.`202207`, a.`202208`, a.`202209`, a.`202210`, a.`202211`, a.`202212`, a.`TotalPayments2022`, a.`TotalPaymentAmount2022`

        , a.`202101`, a.`202102`, a.`202103`, a.`202104`, a.`202105`, a.`202106`, a.`202107`, a.`202108`, a.`202109`, a.`202110`, a.`202111`, a.`202112`, a.`TotalPayments2021`, a.`TotalPaymentAmount2021`
        
        , a.`202001`, a.`202002`, a.`202003`, a.`202004`, a.`202005`, a.`202006`, a.`202007`, a.`202008`, a.`202009`, a.`202010`, a.`202011`, a.`202012`, a.`TotalPayments2020`, a.`TotalPaymentAmount2020`
        , a.`201901`, a.`201902`, a.`201903`, a.`201904`, a.`201905`, a.`201906`, a.`201907`, a.`201908`, a.`201909`, a.`201910`, a.`201911`, a.`201912`, a.`TotalPayments2019`, a.`TotalPaymentAmount2019`
        , a.`201801`, a.`201802`, a.`201803`, a.`201804`, a.`201805`, a.`201806`, a.`201807`, a.`201808`, a.`201809`, a.`201810`, a.`201811`, a.`201812`, a.`TotalPayments2018`, a.`TotalPaymentAmount2018`
		, b.totalpaymentamount as TotalPaymentOverall
        from 
		rcbill_my.rep_allcust b
		left join
		rcbill_my.customers_collection_pivot a 
		on b.clientcode=a.clientcode
		left join
		rcbill_my.rep_housingestates c 
		on b.clientcode=c.CLIENT_CODE
		-- order by a.TotalPaymentAmount2020 desc
        order by b.totalpaymentamount desc
);

select 'created rcbill_my.rep_customers_collection' as message;
-- select * from rcbill_my.rep_customers_collection;


#####################



-- select * from rcbill_my.rep_customers_collection2018 where client_code='I.000001076';

set session group_concat_max_len = 2000000;

-- select * from rcbill_my.customers_contracts_cmts_mxk where cl_clientcode='I.000001076';

    drop table if exists rcbill_my.tempa;
	create table rcbill_my.tempa(
    -- index idxtempa1(CL_CLIENTCODE), index idxtempa2(CON_CONTRACTCODE)
    index idxtempa1(CL_CLIENTCODE,CON_CONTRACTCODE)
    )
    -- , index idxtempa3(CL_CLIENTID), index idxtempa4(CON_CONTRACTID)
     as
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

select 'created rcbill_my.tempa' as message;

-- select * from rcbill_my.customers_contracts_collection_pivot2018 where clientcode='I.000001076';
	drop table if exists rcbill_my.tempb;
    create table rcbill_my.tempb(
    -- index idxtempb1(b_clientcode), index idxtempb2(b_contractcode)
        -- index idxtempb1(b_clientcode,b_contractcode)
	index idxtempb1(bc_clientcode,bc_contractcode)    
    )
    as
    (
		/*
        commented on 3 Jan 2019 to cater for 2019 payments
        select clientcode as b_clientcode, clid as b_clientid, contractcode as b_contractcode, cid as b_contractid, `201801`, `201802`, `201803`, `201804`, `201805`, `201806`, `201807`, `201808`, `201809`, `201810`, `201811`, `201812`, TotalPayments2018, TotalPaymentAmount2018
        from rcbill_my.customers_contracts_collection_pivot2018 
        */
			select * ,
			clientcode as bc_clientcode,
			clid as bc_clientid,
			contractcode as bc_contractcode,
			cid as bc_contractid
			
			from
			
			rcbill_my.customers_contracts_collection_pivot a        
       
    );

select 'created rcbill_my.tempb' as message;









-- show index from tempa;
-- show index from tempb;
-- select * from tempa
-- select * from tempb
create temporary table a as 
(
-- explain
	select a.*, b.*
	from
	rcbill_my.tempa	a 
	left join
	rcbill_my.tempb b
	-- on a.CL_CLIENTCODE=b.b_clientcode
	-- and a.CON_CONTRACTCODE=b.b_contractcode      
	on a.CL_CLIENTCODE=b.bc_clientcode
	and a.CON_CONTRACTCODE=b.bc_contractcode   
);

select 'created a' as message;

create temporary table b as 
(
	select a.*, b.*
	from
	rcbill_my.tempa a 
	right join
	rcbill_my.tempb b
	-- on a.CL_CLIENTCODE=b.b_clientcode
	-- and a.CON_CONTRACTCODE=b.b_contractcode 
	on a.CL_CLIENTCODE=b.bc_clientcode
	and a.CON_CONTRACTCODE=b.bc_contractcode  
);

select 'created b' as message;

drop table if exists rcbill_my.tempa;
drop table if exists rcbill_my.tempb;

drop table if exists rcbill_my.cust_cont_payment_cmts_mxk;
create table rcbill_my.cust_cont_payment_cmts_mxk 
(
index idxccpcm1(cl_clientcode),index idxccpcm2(CON_CONTRACTCODE)
-- ,index idxccpcm3(b_clientcode),index idxccpcm4(b_contractcode)
,index idxccpcm3(bc_clientcode),index idxccpcm4(bc_contractcode)
,index idxccpcm5(cl_clientid),index idxccpcm6(con_contractid)
)
as
(
select * from a
/*
select a.*, b.*
from
rcbill_my.tempa	a 
left join
rcbill_my.tempb b
-- on a.CL_CLIENTCODE=b.b_clientcode
-- and a.CON_CONTRACTCODE=b.b_contractcode      
on a.CL_CLIENTCODE=b.bc_clientcode
and a.CON_CONTRACTCODE=b.bc_contractcode   
*/
)
union 
(
select * from b
/*
select a.*, b.*
from
rcbill_my.tempa a 
right join
rcbill_my.tempb b
-- on a.CL_CLIENTCODE=b.b_clientcode
-- and a.CON_CONTRACTCODE=b.b_contractcode 
on a.CL_CLIENTCODE=b.bc_clientcode
and a.CON_CONTRACTCODE=b.bc_contractcode   
*/
)
;        

select 'created rcbill_my.cust_cont_payment_cmts_mxk' as message;

drop temporary table if exists a;
drop temporary table if exists b;
drop temporary table if exists c;

-- select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I.000001076' or b_clientcode='I.000001076';
-- select * from rcbill_my.cust_cont_payment_cmts_mxk where connection_type='HFC';
-- select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I9929';
-- select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I9890';
-- select * from rcbill_my.cust_cont_payment_cmts_mxk where cl_clientcode='I8983';

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
			select 
            -- ifnull(cl_clientcode,b_clientcode) as combined_clientcode
            ifnull(cl_clientcode,bc_clientcode) as combined_clientcode
            , cl_clientcode
			-- , b_clientcode
			-- , coalesce(max(b_clientcode)) as b_clientcode
            , coalesce(max(bc_clientcode)) as bc_clientcode
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
                        
            -- added 3 Jan 2019
			, sum(`201901`) as `201901`, sum(`201902`) as `201902`, sum(`201903`) as `201903`, sum(`201904`) as `201904`
			, sum(`201905`) as `201905`, sum(`201906`) as `201906`, sum(`201907`) as `201907`, sum(`201908`) as `201908`
			, sum(`201909`) as `201909`, sum(`201910`) as `201910`, sum(`201911`) as `201911`, sum(`201912`) as `201912`
			, sum(`TotalPayments2019`) as `TotalPayments2019`
			, sum(`TotalPaymentAmount2019`) as `TotalPaymentAmount2019`       
            
            -- added 4 Jan 2020
			, sum(`202001`) as `202001`, sum(`202002`) as `202002`, sum(`202003`) as `202003`, sum(`202004`) as `202004`
			, sum(`202005`) as `202005`, sum(`202006`) as `202006`, sum(`202007`) as `202007`, sum(`202008`) as `202008`
			, sum(`202009`) as `202009`, sum(`202010`) as `202010`, sum(`202011`) as `202011`, sum(`202012`) as `202012`
			, sum(`TotalPayments2020`) as `TotalPayments2020`
			, sum(`TotalPaymentAmount2020`) as `TotalPaymentAmount2020`       

            -- added 4 Jan 2021
			, sum(`202101`) as `202101`, sum(`202102`) as `202102`, sum(`202103`) as `202103`, sum(`202104`) as `202104`
			, sum(`202105`) as `202105`, sum(`202106`) as `202106`, sum(`202107`) as `202107`, sum(`202108`) as `202108`
			, sum(`202109`) as `202109`, sum(`202110`) as `202110`, sum(`202111`) as `202111`, sum(`202112`) as `202112`
			, sum(`TotalPayments2021`) as `TotalPayments2021`
			, sum(`TotalPaymentAmount2021`) as `TotalPaymentAmount2021`       

            -- added 31 Dec 2021
			, sum(`202201`) as `202201`, sum(`202202`) as `202202`, sum(`202203`) as `202203`, sum(`202204`) as `202204`
			, sum(`202205`) as `202205`, sum(`202206`) as `202206`, sum(`202207`) as `202207`, sum(`202208`) as `202208`
			, sum(`202209`) as `202209`, sum(`202210`) as `202210`, sum(`202211`) as `202211`, sum(`202212`) as `202212`
			, sum(`TotalPayments2022`) as `TotalPayments2022`
			, sum(`TotalPaymentAmount2022`) as `TotalPaymentAmount2022`       

			from rcbill_my.cust_cont_payment_cmts_mxk 
			-- where cl_clientcode='I.000011750'
            -- where CL_CLIENTCODE='I.000018640'
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

select 'created rcbill_my.rep_cust_cont_payment_cmts_mxk' as message;
    
drop table if exists rcbill_my.tempa;
drop table if exists rcbill_my.tempb;

-- select * from rcbill_my.rep_cust_cont_payment_cmts_mxk where clientcode='I.000001076';
-- select * from rcbill_my.rep_allcust where clientcode='I13400';
####################################
#CREATE CONSOLIDATED CUSTOMER REPORT
####################################


drop table if exists rcbill_my.rep_custconsolidated;
create table rcbill_my.rep_custconsolidated(index idxrcc1(clientcode),index idxrcc2(clientid)) as
(


	select 
	`reportdate`,
	`clientcode`,
    rcbill.GetClientID(clientcode) as `clientid`,
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

	`202201`,
	`202202`,
	`202203`,
	`202204`,
	`202205`,
	`202206`,
	`202207`,
	`202208`,
	`202209`,
	`202210`,
	`202211`,
	`202212`,
	`totalpayments2022`,
	`totalpaymentamount2022`,
    `AvgMonthlyPayment2022`,
    
	`202101`,
	`202102`,
	`202103`,
	`202104`,
	`202105`,
	`202106`,
	`202107`,
	`202108`,
	`202109`,
	`202110`,
	`202111`,
	`202112`,
	`totalpayments2021`,
	`totalpaymentamount2021`,
    `AvgMonthlyPayment2021`,

	`202001`,
	`202002`,
	`202003`,
	`202004`,
	`202005`,
	`202006`,
	`202007`,
	`202008`,
	`202009`,
	`202010`,
	`202011`,
	`202012`,
	`totalpayments2020`,
	`totalpaymentamount2020`,
    `AvgMonthlyPayment2020`,
    
    
	`201901`,
	`201902`,
	`201903`,
	`201904`,
	`201905`,
	`201906`,
	`201907`,
	`201908`,
	`201909`,
	`201910`,
	`201911`,
	`201912`,
	`totalpayments2019`,
	`totalpaymentamount2019`,
    `AvgMonthlyPayment2019`,
    
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
    `AvgMonthlyPayment2018`,
    
	`clientarea`,
	`subdistrict`,
	`clientparcel`,
	`coord_x`,
	`coord_y`,
	`latitude`,
	`longitude`,

	`clientemail`,
	`clientnin`,
	`clientpassport`,
	`clientphone`,
	`combined_clientcode`,
	`cl_clientcode`,
	`bc_clientcode`,
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
        ((b.totalpaymentamount2018)/12) as AvgMonthlyPayment2018 ,
        ((b.totalpaymentamount2019)/12) as AvgMonthlyPayment2019,
        ((b.totalpaymentamount2020)/12) as AvgMonthlyPayment2020,
        ((b.totalpaymentamount2021)/12) as AvgMonthlyPayment2021,
        ((b.totalpaymentamount2022)/MONTH(now())) as AvgMonthlyPayment2022,
        
        d.activeservices,
        d.activenetwork,
		-- a.clientcode,
        -- a.CLIENTID,
		a.AccountActivityStage,
		a.activesubscriptions,
		a.clientaddress,
		a.clientarea,
		a.subdistrict 
		,a.clientparcel, a.coord_x, a.coord_y, a.latitude, a.longitude
        ,
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
		-- inner join 
        left join
		rcbill_my.rep_cust_cont_payment_cmts_mxk b
		on 
		a.clientcode=b.clientcode
		-- inner join 
        left join
		(
			select client_code as clientcode, coalesce(group_concat((CONTRACT_INFO) separator '|')) as contractinfo
			from
			(
			select CLIENT_CODE
			, concat(coalesce(CONTRACT_CODE,''),'~',coalesce(SERVICE_TYPE,''),'~',coalesce(FSAN,''),'~',coalesce(MAC,''),'~',coalesce(UID,'')) as CONTRACT_INFO 
			from rcbill_my.rep_clientcontractdevices 
			-- where CLIENT_CODE='I.000019951'

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


		-- where 0=0
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
		-- and a.clientcode='I6030'


	) a
)
-- where clientcode='I6816'
;

select count(*) as rep_custconsolidated from rcbill_my.rep_custconsolidated;


#####################################
### customer distribution across areas



drop table if exists rcbill_my.rep_activecustomerdistribution_level1;

create table rcbill_my.rep_activecustomerdistribution_level1 
as
(

	select coalesce(ISLAND,'GRAND TOTAL') as ISLAND
	, coalesce(DISTRICT,'--------------') as DISTRICT
	, ActiveAccounts_GPON, ActiveAccounts_HFC, ActiveAccounts_MIX
	from 
	(
		select 
		clientarea as ISLAND
		, clientlocation as DISTRICT
		, ifnull(sum(`ActiveAccounts_GPON`),0) as `ActiveAccounts_GPON` 
		, ifnull(sum(`ActiveAccounts_HFC`),0) as `ActiveAccounts_HFC` 
		, ifnull(sum(`ActiveAccounts_MIX`),0) as `ActiveAccounts_MIX` 

		from 
		(
			select clientarea, clientlocation, activenetwork
			, case when activenetwork='GPON' then count(clientcode) end as ActiveAccounts_GPON 
			, case when activenetwork='HFC' then count(clientcode) end as ActiveAccounts_HFC 
			, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveAccounts_MIX 
			-- , case when activenetwork is null then count(clientcode) end as ActiveAccounts_INACTIVE 

			from rcbill_my.rep_custconsolidated 
			where IsAccountActive='Active'
			group by 1,2,3
			-- with rollup
		) a 
		group by 1,2
		with rollup
	) a 

)
;

select count(*) as 'rep_activecustomerdistribution_level1' from rcbill_my.rep_activecustomerdistribution_level1;

drop table if exists rcbill_my.rep_activecustomerdistribution_level2;

create table rcbill_my.rep_activecustomerdistribution_level2 
as
(
	select  coalesce(ISLAND,'GRAND TOTAL') as ISLAND
	, coalesce(DISTRICT,'--------------') as DISTRICT
	, coalesce(SUBDISTRICT,'--------------') as SUBDISTRICT
	, ActiveAccounts_GPON, ActiveAccounts_HFC, ActiveAccounts_MIX
	from
	(
		select clientarea as ISLAND, clientlocation as DISTRICT, subdistrict as SUBDISTRICT
		, ifnull(sum(`ActiveAccounts_GPON`),0) as `ActiveAccounts_GPON` 
		, ifnull(sum(`ActiveAccounts_HFC`),0) as `ActiveAccounts_HFC` 
		, ifnull(sum(`ActiveAccounts_MIX`),0) as `ActiveAccounts_MIX` 

		from 
		(
			select clientarea, clientlocation, subdistrict, activenetwork
			, case when activenetwork='GPON' then count(clientcode) end as ActiveAccounts_GPON 
			, case when activenetwork='HFC' then count(clientcode) end as ActiveAccounts_HFC 
			, case when activenetwork in ('GPON|GPON','GPON|HFC') then count(clientcode) end as ActiveAccounts_MIX 
			-- , case when activenetwork is null then count(clientcode) end as ActiveAccounts_INACTIVE 

			from rcbill_my.rep_custconsolidated 
			where IsAccountActive='Active'
			group by 1,2,3,4
			-- with rollup
		) a 
		group by 1,2,3
		 with rollup
	) a 
)
;


select count(*) as 'rep_activecustomerdistribution_level2' from rcbill_my.rep_activecustomerdistribution_level2;

#####################################
### CLIENT ADDRESS, LOCATION, PARCELS, COODINATES
drop table if exists rcbill_my.rep_custaddressparcelsprefix;

create table rcbill_my.rep_custaddressparcelsprefix(index idxrcap1(clientcode))
as 
(

	select a.*
    , b.clientparcel, b.coord_x, b.coord_y, b.latitude, b.longitude, b.parcel_prefix
	from 
	(
		select clientcode, clientname, clientaddress, clientclass, clientarea, clientlocation, subdistrict, activenetwork, isaccountactive, accountactivitystage

		from rcbill_my.rep_custconsolidated 
		-- where IsAccountActive='Active'
	) a 
	left join
	(
		select *, substr(clientparcel,1,1) as parcel_prefix 
		from rcbill.rcb_clientparcelcoords 
		where latitude<>0 and date(insertedon)=((select max(date(insertedon)) from rcbill.rcb_clientparcelcoords))            
	) b 
	on a.clientcode=b.clientcode
	

)
;

-- select * from rcbill_my.rep_custaddressparcelsprefix;
select count(*) as rep_custaddressparcelsprefix from rcbill_my.rep_custaddressparcelsprefix;



#####################################
## residential customers for sales

drop table if exists rcbill_my.rep_residentialcustomers_tillasleep;

create table rcbill_my.rep_residentialcustomers_tillasleep(index idxrrcta1(clientcode))
(

select reportdate, clientcode, currentdebt, IsAccountActive, AccountActivityStage, clientname, clientclass
, activenetwork, activeservices
, clientarea, clientlocation, subdistrict
, clientaddress
, (select clientparcel from rcbill_my.rep_custaddressparcelsprefix where clientcode=a.clientcode) as clientparcel
, (select latitude from rcbill_my.rep_custaddressparcelsprefix where clientcode=a.clientcode) as latitude
, (select longitude from rcbill_my.rep_custaddressparcelsprefix where clientcode=a.clientcode) as longitude
, clientemail, clientnin, clientpassport, clientphone
, activecontracts, activesubscriptions
, lastactivedate, dayssincelastactive
, SUBSTRING_INDEX(rcbill_my.GetLastPackageDateFromSnapshot(clientcode, 'INTERNET'),'|',1) as LASTINTERNETPACKAGE
, SUBSTRING_INDEX(rcbill_my.GetLastPackageDateFromSnapshot(clientcode, 'INTERNET'),'|',-1) as LASTINTERNETPACKAGEDATE
, SUBSTRING_INDEX(rcbill_my.GetLastPackageDateFromSnapshot(clientcode, 'TV'),'|',1) as LASTTVPACKAGE
, SUBSTRING_INDEX(rcbill_my.GetLastPackageDateFromSnapshot(clientcode, 'TV'),'|',-1) as LASTTVPACKAGEDATE
-- , rcbill_my.GetLastPackageFromSnapshot(clientcode, 'INTERNET') as LASTINTERNETPACKAGE
-- , rcbill_my.GetLastPackageFromSnapshot(clientcode, 'TV') as LASTTVPACKAGE
, lastinvoicedate, lastpaidamount, lastpaymentdate
, TotalPaymentAmount2022, AvgMonthlyPayment2022
, TotalPaymentAmount2021, AvgMonthlyPayment2021
, TotalPaymentAmount2020, AvgMonthlyPayment2020
, TotalPaymentAmount2019, AvgMonthlyPayment2019
, TotalPaymentAmount2018, AvgMonthlyPayment2018



from rcbill_my.rep_custconsolidated a 
where ClientClass in ('RESIDENTIAL') 
and ClientCode not in ('I.000015720')
-- and TotalPaymentAmount2021>0
and TotalPaymentAmount2022>0
and AccountActivityStage in ('3. Asleep (8 to 30 days)','2. Snoozing (1 to 7 days)','1. Alive')
-- order by AvgMonthlyPayment2021 desc
order by AvgMonthlyPayment2022 desc
-- limit 5000
)
;
#####################################

-- select * from rcbill_my.rep_residentialcustomers_tillasleep;
select count(*) as rep_residentialcustomers_tillasleep from rcbill_my.rep_residentialcustomers_tillasleep;


#####################################
### CUST EXTRACT FOR PARCELS

drop table if exists rcbill_my.rep_custextract;
select 'creating rcbill_my.rep_custextract' as message;

create table rcbill_my.rep_custextract (index idxrce1 (clientcode))
as 
(
	select a.reportdate, a.CLIENTCODE, a.CLIENTID, a.IsAccountActive, a.AccountActivityStage , a.CurrentDebt, a.CLIENTNAME, a.clientclass
	, a.clientaddress
	, a.clientlocation, a.clientarea, a.subdistrict
    , a.clientemail
    , a.activenetwork
    
    -- , 'a@a.com' as clientemail
    , a.clientnin, a.clientphone
	-- , a.dayssincelastactive
	, b.address, b.moladdress, b.MOLRegistrationAddress
    , a.firstcontractdate
    , a.firstinvoicedate
    , a.firstpaymentdate
    , a.firstactivedate
    , a.dayssincelastactive
	, b.a1_parcel, b.a2_parcel, b.a3_parcel
	, case when (b.a1_parcel is null or length(b.a1_parcel)=0) and (b.a2_parcel is null or length(b.a2_parcel)=0) and (b.a3_parcel is null or length(b.a3_parcel)=0) 
		then 'NOT PRESENT'
		else 'PRESENT' end as `PARCEL_PRESENT` 
	, case when a.clientemail is null or length(a.clientemail)=0
		then 'NOT PRESENT'
		else 'PRESENT' end as `EMAIL_PRESENT` 
	, case when a.clientnin is null or length(a.clientnin)=0 
		then 'NOT PRESENT'
		when locate("-",a.clientnin)=0 then 'INVALID'
		else 'PRESENT' end as `NIN_PRESENT`
	, case when (a.clientaddress is null or length(a.clientaddress)=0) and (b.address is null or length(b.address)=0) and (b.moladdress is null or length(b.moladdress)=0) and (b.MOLRegistrationAddress is null or length(b.MOLRegistrationAddress)=0)
		then 'NOT PRESENT'
		else 'PRESENT' end as `ADDRESS_PRESENT`
    , case when a.dayssincelastactive <=365 
		then 'ONE YEAR'
		else 'MORE THAN ONE YEAR' end as `ONE_YEAR`

	from 
	rcbill_my.rep_custconsolidated a 
	left join
	rcbill.rcb_clientparcels b
	on 
	a.CLIENTCODE=b.clientcode
	-- where a.AccountActivityStage not in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
	-- where a.AccountActivityStage in ('4. Hibernating (31 to 90 days)','5. Dormant (more than 90 days)')
	order by 3 asc, 16 asc
)
;

select count(*) as rep_custextract from rcbill_my.rep_custextract;
-- select * from rcbill_my.rep_custextract;

#####################################



set session group_concat_max_len = 1024;

-- select * from rcbill_my.rep_custconsolidated where clientcode='I.000011750';

##RETENTION CUSTOMER REPORT
drop table if exists rcbill_my.retentioncustomeractivity;
select 'creating rcbill_my.retentioncustomeractivity' as message;
create table rcbill_my.retentioncustomeractivity as
(


select 
-- * 
ReportDate,
clientcode as ClientCode,
clientname as ClientName,
clientclass as ClientClass,
clientclass as ClientType,
firstactivedate as FirstActiveDate,
lastactivedate as LastActiveDate,
dayssincelastactive as DaysSinceLastActive,
activecontracts as ActiveContracts,
clientphone as ClientPhone,
clientemail as ClientEmail,
clientnin as ClientNIN,
clientaddress as ClientAddress

from rcbill_my.rep_custconsolidated where upper(clientname) like '%RETENTION%'


)
;

select count(*) as retentioncustomeractivity from rcbill_my.retentioncustomeractivity;

-- select * from rcbill_my.retentioncustomeractivity;


/*


##RETENTION CUSTOMER REPORT
drop table if exists rcbill_my.retentioncustomeractivity;
select 'creating rcbill_my.retentioncustomeractivity' as message;
create table rcbill_my.retentioncustomeractivity as
(


select distinct
@rundate as ReportDate,
count(distinct a.contractcode) as ContractCount,
count(distinct a.period) as DaysActive,
min(a.period) as FirstActiveDate,
max(a.period) as LastActiveDate,
a.clientid as ClientId,
a.clientcode as ClientCode,
a.clientclass as ClientClass, 
a.clienttype as ClientType,


b.ClientName,
b.ClientPhone, 
b.ClientEmail,
b.ClientPassport,
b.ClientNIN,
b.ClientAddress,
b.RegistrationAddress,

now() as InsertedOn


from 

rcbill_my.dailyactivenumber a 

inner join
(
	select id,
	firm as ClientName,
	mphone as ClientPhone, 
	memail as ClientEmail,
	passno as ClientPassport,
	Danno as ClientNIN,
	moladdress as ClientAddress,
	molregistrationaddress as RegistrationAddress
	from rcbill.rcb_tclients
	where 
	upper(firm) like '%RETENTION%'
) b
-- rcbill.rcb_tclients b

on a.clientid=b.id

group by
a.clientid,
a.clientcode,
a.clientclass, a.clienttype,
b.ClientName,
b.ClientPhone, 
b.ClientEmail,
b.ClientPassport,
b.ClientNIN,
b.ClientAddress,
b.RegistrationAddress

order by max(a.period) asc


)
;

select count(*) as retentioncustomeractivity from rcbill_my.retentioncustomeractivity;


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

