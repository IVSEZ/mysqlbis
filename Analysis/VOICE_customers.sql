### VOICE CUSTOMERS

/*
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_custconsolidated;

select * from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE');

select * from rcbill_my.customercontractsnapshot where clientcode in (select CLIENT_CODE from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE'));

*/

select 
a.CLIENT_NAME, a.CLIENT_ADDRESS, a.UID AS PHONE_NO 
, b.CurrentStatus
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT

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
;

### EXTRACT FOR PHONE DIRECTORY
select distinct 
a.CLIENT_NAME
-- , a.CLIENT_ADDRESS
, a.UID AS PHONE_NO 
-- , b.CurrentStatus
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT

-- , a.CLIENT_CODE, a.CONTRACT_CODE
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

## first time

/*

set @extractdate='2022-07-05';

create table rcbill_extract.DICT_CUST_PHONE(index idxccode(CLIENT_CODE), index idxcphone(PHONE_NO))
(

select distinct 
@extractdate
, a.CLIENT_CODE
,a.CLIENT_NAME
-- , a.CLIENT_ADDRESS
, a.UID AS PHONE_NO 
-- , b.CurrentStatus
, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT

-- , a.CLIENT_CODE, a.CONTRACT_CODE
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
set @extractdate='2022-07-05';

SELECT V.*
FROM 
(
	select distinct 
	a.CLIENT_CODE
	,a.CLIENT_NAME
	-- , a.CLIENT_ADDRESS
	, a.UID AS PHONE_NO 
	-- , b.CurrentStatus
	, if(c.clientarea='TBU','',c.clientarea) as ISLAND, if(c.clientlocation='TBU','',c.clientlocation) as DISTRICT, if(c.subdistrict='TBU','',c.subdistrict) as SUBDISTRICT

	-- , a.CLIENT_CODE, a.CONTRACT_CODE
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


select * from rcbill_extract.DICT_CUST_PHONE;
select CLIENT_NAME, PHONE_NO, ISLAND, DISTRICT, SUBDISTRICT from rcbill_extract.DICT_CUST_PHONE;
