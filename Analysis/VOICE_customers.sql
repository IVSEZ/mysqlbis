### VOICE CUSTOMERS

/*
select * from rcbill_my.rep_clientcontractdevices;
select * from rcbill_my.rep_custconsolidated;
*/
select * from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE');

select * from rcbill_my.customercontractsnapshot where clientcode in (select CLIENT_CODE from rcbill_my.rep_clientcontractdevices where SERVICE_TYPE in ('VOICE','GVOICE'));


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


