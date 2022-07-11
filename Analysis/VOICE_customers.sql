### VOICE CUSTOMERS

/*
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_custconsolidated;

select * from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE');

select * from rcbill_my.customercontractsnapshot where clientcode in (select CLIENT_CODE from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE'));

*/

select 
a.CLIENT_NAME, a.CLIENT_ADDRESS, a.UID AS PHONE_NO 
, b.CurrentStatus as CURRENT_STATUS
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT

, a.CLIENT_CODE, a.CONTRACT_CODE
, c.AccountActivityStage as ACTIVITY_STAGE
, c.dayssincelastactive as DAYS_INACTIVE
from 
rcbill_my.rep_clientcontractdevices a 
inner join 
rcbill_my.customercontractsnapshot b
on a.CONTRACT_CODE=b.contractcode

inner join
rcbill_my.rep_custconsolidated c
on a.CLIENT_CODE=c.clientcode
where a.SERVICE_TYPE in ('VOICE','GVOICE')
and a.UID like ('44%')
-- and b.CurrentStatus in ('Active')
;

### EXTRACT FOR PHONE DIRECTORY
select distinct 
a.CLIENT_NAME
-- , a.CLIENT_ADDRESS
, a.UID AS PHONE_NO 
-- , b.CurrentStatus
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT
, c.AccountActivityStage as ACTIVITY_STAGE
, c.dayssincelastactive as DAYS_INACTIVE
, b.CurrentStatus as CURRENT_STATUS
, a.CLIENT_CODE, a.CONTRACT_CODE
from 
rcbill_my.rep_clientcontractdevices a 
inner join 
rcbill_my.customercontractsnapshot b
on a.CONTRACT_CODE=b.contractcode

inner join
rcbill_my.rep_custconsolidated c
on a.CLIENT_CODE=c.clientcode
where a.SERVICE_TYPE in ('VOICE','GVOICE')
and a.UID like ('44%')
-- and b.CurrentStatus in ('Active')

-- order by b.CurrentStatus
;

### EXTRACT FOR PHONE DIRECTORY

## first time

/*

drop table if exists rcbill_extract.DICT_CUST_PHONE;

set @extractdate='2022-07-06';

create table rcbill_extract.DICT_CUST_PHONE(index idxccode(CLIENT_CODE), index idxcphone(PHONE_NO))
(

select distinct 
@extractdate as EXTRACT_DATE
, a.CLIENT_CODE
,a.CLIENT_NAME
-- , a.CLIENT_ADDRESS
, a.UID AS PHONE_NO 
-- , b.CurrentStatus
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT
, c.AccountActivityStage as ACTIVITY_STAGE
, c.dayssincelastactive as DAYS_INACTIVE
, b.CurrentStatus as CURRENT_STATUS
, a.CONTRACT_CODE
from 
rcbill_my.rep_clientcontractdevices a 
inner join 
rcbill_my.customercontractsnapshot b
on a.CONTRACT_CODE=b.contractcode

inner join
rcbill_my.rep_custconsolidated c
on a.CLIENT_CODE=c.clientcode
where a.SERVICE_TYPE in ('VOICE','GVOICE')
and a.UID like ('44%')
-- and b.CurrentStatus in ('Active')
)
;
*/
-- show index from rcbill_extract.DICT_CUST_PHONE;

## FUTURE TIMES
set @extractdate='2022-07-06';

SELECT V.*
FROM 
(
	select distinct 
    @extractdate as EXTRACT_DATE
	, a.CLIENT_CODE
	, a.CLIENT_NAME
	-- , a.CLIENT_ADDRESS
	, a.UID AS PHONE_NO 
	-- , b.CurrentStatus
	, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT
	, c.AccountActivityStage as ACTIVITY_STAGE
	, c.dayssincelastactive as DAYS_INACTIVE
	, b.CurrentStatus as CURRENT_STATUS
	, a.CONTRACT_CODE
	from 
	rcbill_my.rep_clientcontractdevices a 
	inner join 
	rcbill_my.customercontractsnapshot b
	on a.CONTRACT_CODE=b.contractcode

	inner join
	rcbill_my.rep_custconsolidated c
	on a.CLIENT_CODE=c.clientcode
	where a.SERVICE_TYPE in ('VOICE','GVOICE')
	and a.UID like ('44%')
	-- and b.CurrentStatus in ('Active')

) V 

LEFT JOIN 
rcbill_extract.DICT_CUST_PHONE E 
ON V.CLIENT_CODE = E.CLIENT_CODE and V.PHONE_NO=E.PHONE_NO
WHERE E.CLIENT_CODE IS NULL and E.PHONE_NO is NULL
;



## export for dictionary

select * from rcbill_extract.DICT_CUST_PHONE;
select * from rcbill_extract.DICT_CUST_PHONE where CURRENT_STATUS='Active';
select CLIENT_NAME, PHONE_NO, ISLAND, DISTRICT, SUBDISTRICT from rcbill_extract.DICT_CUST_PHONE where CURRENT_STATUS='Active' ;
SELECT * FROM rcbill_extract.`DICT_MasterList-IV-Voice-20220706`;

SET SQL_SAFE_UPDATES = 0;
/*
- kept only active phone numbers
- removed numbers of capital management, pure entertainment, R Ganeshan, Fahreen Rajan, Sarah Rene, K Perera, 
- removed all IV numbers, NOC, Tech Support
- kept main number of (AV group, CKLB FIDUCIARY (SEYCHELLES) LIMITED - ANALOGUE PBX, First Island Trust, KANNUS SHOPPING CENTRE HEAD OFFICE, MAYFAIR,  UAE EXCHANGE)
DELETE FROM rcbill_extract.`DICT_MasterList-IV-Voice-20220706` where ﻿CLIENT_NAME like 'Mukesh%';
*/



