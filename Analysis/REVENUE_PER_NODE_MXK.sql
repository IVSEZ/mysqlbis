
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
create table rcbill_my.customers_collection as 
(

	select clid
	, cid
	, month(PAYDATE) as PAYMONTH, year(PAYDATE) as PAYYEAR 
	, COALESCE(sum(money),0) as TotalPaymentAmount  
	, COALESCE(count(*),0) as TotalPayments, date(min(ENTERDATE)) as FirstPaymentDate, date(max(ENTERDATE)) as LastPaymentDate
    , now() as InsertedOn
	from rcbill.rcb_casa
	where
	(hard not in (100, 101, 102) or hard is null)
	group by clid, cid, 3, 4
	order by clid, 4 desc, 3 desc
);




select * from rcbill.rcb_cmts;
select * from rcbill.rcb_mxk;
select * from rcbill_my.customers_cmts;
-- select * from rcbill_my.customers_cmts where NODENAME is null;  
select * from rcbill.rcb_techregions;
select * from rcbill_my.customers_mxk;

select * from rcbill_my.customers_collection;

/*
select distinct contract_type from rcbill_my.customers_cmts;
select distinct service_type from rcbill_my.customers_cmts;
select distinct contract_type from rcbill_my.customers_mxk;
select distinct service_type from rcbill_my.customers_mxk;


*/





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



/*
select *, if(length(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''))=8,substring(replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS',''),2),replace(replace(replace(UPPER(TRIM(FSAN)),'ZNTS0',''),'ZNTSC',''),'ZNTS','')) as FSAN2 from rcbill_my.rep_clientcontractdevices;



select * from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME='MXK-PRASLIN';
select MXK_NAME, SERIAL_NUM as MXK_FSAN, MODEL_ID, MXK_INTERFACE from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME='MXK-PRASLIN';

select * from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME<>'MXK-PRASLIN';
select MXK_NAME, SERIAL_NUM as MXK_FSAN, MODEL_ID, MXK_INTERFACE from rcbill_my.customers_mxk where fsan2 is null and MXK_NAME<>'MXK-PRASLIN';

*/

